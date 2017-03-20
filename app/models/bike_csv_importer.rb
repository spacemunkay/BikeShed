require 'csv'

# Gone -> If "Yes", set 'gone' to true, then create a Log entry like the following:
# id | loggable_id | loggable_type | logger_id | logger_type | context | start_date | end_date | description | log_action_id | log_action_type       | created_at | updated_at
# 18 | 1 | Bike | 4 | User | | 2017-02-03 23:27:00 | 2017-02-03 23:27:00 | Gone | 5 | ActsAsLoggable::BikeAction | 2017-02-03 23:27:36.8387 | 2017-02-03 23:27:36.8387
# See https://github.com/spacemunkay/BikeShed/blob/master/app/components/bike_logs.rb#L12-L18 for example. Use user_id 1 for current_user_id (1 should be the admin ID I think). Use "Date Out" column for start_date & end_date.  Set action_id to "COMPLETED".
#
# Date In -> Create a bike log entry with start_date & end_date with same value as "Date In". Set action_id to "AQUIRED"
# Date Out -> Should be the start_date & end_date value for "Gone" column mentioned above.
# Comment -> Create a bike log entry with action_id "NOTE". The log 'description' should be the value of 'Comment'.

class BikeCsvImporter

  include BikeCsvImporter::Cache
  include BikeCsvImporter::Cleaner
  include BikeCsvImporter::BikeAttrs

  attr_reader :file

  def initialize(file)
    @file = file
  end

  def run(dry_run)
    imported_count, skipped_count = 0, 0

    puts "Performing a #{dry_run ? 'DRY RUN' : 'LIVE RUN'} of import"

    fetch do |bike_hash|
       bike = new_bike bike_hash
       check_method = dry_run ? :valid? : :save
       if bike.try check_method
         puts "Imported #{bike.shop_id}: #{bike}".green
         imported_count += 1
       else
         puts "Skipped #{bike.try(:shop_id) || bike_hash.values.first}: #{bike.try(:errors).try(:full_messages).try :join, '; '}".red
         skipped_count += 1
       end
    end

    puts "#{imported_count} bikes imported, #{skipped_count} bikes skipped, total of #{imported_count + skipped_count} rows in the CSV"
  end

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



  private

  def fetch
    CSV.foreach(file).each_with_index do |row, i|
      if i.zero?
        parse_header row
      else
        yield parse_bike(row)
      end
    end
  end

  def parse_header(row)
    @header = row.map(&:downcase)
  end

  def parse_bike(row)
    @header.zip(row).to_h
  end

  def new_bike(bike_hash)
    Bike.new bike_attrs(bike_hash)
  end
end
