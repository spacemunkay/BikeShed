require 'csv'

# Imports data from CSV file into the bikes database.
class BikeCsvImporter

  include BikeCsvImporter::Cache
  include BikeCsvImporter::Cleaner
  include BikeCsvImporter::BikeAttrs
  include BikeCsvImporter::Logs

  attr_reader :file

  # Default constructor
  #
  # @param [String] file Path to the CSV file
  def initialize(file)
    @file = file
  end

  # Runs the import. Will print out progress to stdout
  #
  # @param [Boolean] dry_run If true, does not save data, only shows the progress of validation
  def run(dry_run)
    imported_count, skipped_count = 0, 0

    puts "Performing a #{dry_run ? 'DRY RUN' : 'LIVE RUN'} of import"

    fetch do |bike_hash|
       bike         = new_bike bike_hash
       check_method = dry_run ? :valid? : :save

       if bike.try check_method
         puts "Imported #{bike.shop_id}: #{bike}".green

         logs = new_logs_entries bike, bike_hash
         logs.each do |log|
           if log.send check_method
             puts "\tLog entry created: #{log.inspect}".green
           else
             puts "\tLog entry creation failed: #{log.errors.full_messages.join '; '}".red
           end
         end

         imported_count += 1
       else
         puts "Skipped #{bike.try(:shop_id) || bike_hash.values.first}: #{bike.try(:errors).try(:full_messages).try :join, '; '}".red
         skipped_count += 1
       end
    end

    puts "#{imported_count} bikes imported, #{skipped_count} bikes skipped, total of #{imported_count + skipped_count} rows in the CSV"
  end

  # Analyzes and prints out the input CSV file values
  #
  # @param [Array<Strong>] fields If passed, analyze only the given fields (names are down cased)
  def analyze(fields = [])
    puts "Analyzing CSV values frequency for #{fields.any? ? fields.join(', ') + ' field' : 'all fields'}"

    fields = fields.map &:downcase
    grouped = {}
    fetch do |bike_hash|
      bike_hash.each do |key, value|
        next if fields.any? && !fields.include?(key)
        grouped[key]        ||= {}
        grouped[key][value] ||= 0
        grouped[key][value]  += 1
      end
    end

    grouped.each do |field, values|
      puts "#{field}:"
      values.each do |value, count|
        puts "\t#{value.inspect}: #{count}"
      end
      puts "\tTotal of #{values.count} distinct values"
    end
  end

  # Imports new brands from CSV file (field 'make'). Will print out progress to stdout
  #
  # @param [Boolean] dry_run If true, does not save data, only shows the progress of validation
  def brands(dry_run)
    created_count, skipped_count = 0, 0

    puts "Performing a #{dry_run ? 'DRY RUN' : 'LIVE RUN'} of brands import"

    fetch do |bike_hash|
      make          = clean_value bike_hash['make']
      brand         = bike_attr_bike_brand make, true
      check_method  = dry_run ? :valid? : :save

      if brand.try :persisted?
        puts "Skipped already existing brand #{brand.brand}"
        skipped_count +=1
      elsif brand.try check_method
        puts "Created brand #{brand.brand}".green
        created_count += 1
      else
        puts "Skipped #{brand.try(:brand) || make}: #{brand.try(:errors).try(:full_messages).try(:join, '; ') || 'object not created'}".red
        skipped_count += 1
      end
    end

    puts "#{created_count} brand created, #{skipped_count} brand skipped, total of #{created_count + skipped_count} rows in the CSV"
  end



  private

  # Parses the CSV header & rows, yielding a block for each row (except the header)
  # Header is down cased!
  #
  # @param [Proc] &block The block to yield to
  def fetch
    CSV.foreach(file).each_with_index do |row, i|
      if i.zero?
        parse_header row
      else
        yield parse_bike(row)
      end
    end
  end

  # Parses & stores the input header, down casing by the way
  #
  # @param [Array<String>] row
  def parse_header(row)
    @header = row.map(&:downcase)
  end

  # Parses the input row into a hash with keys from the header, @see #parse_header
  #
  # @param [Array<String>] row
  #
  # @return [Hash]
  def parse_bike(row)
    @header.zip(row).to_h
  end

  # Constructs a new Bike instance from the given hash from a CSV row
  #
  # @param [Hash] bike_hash
  #
  # @return [Bike]
  def new_bike(bike_hash)
    Bike.new bike_attrs(bike_hash)
  end

  # Constructs new Bike Log Entries instances from the given hash from a CSV row
  #
  # @param [Bike] bike      The Bike instance to construct log entries for
  # @param [Hash] bike_hash The input hash from a CSV row
  #
  # @return [Array<ActsAsLoggable::Log>]
  def new_logs_entries(bike, bike_hash)
    %i{ acquired comment gone }.map { |x| send :"log_entry_#{x}", bike, bike_hash }.compact
  end
end
