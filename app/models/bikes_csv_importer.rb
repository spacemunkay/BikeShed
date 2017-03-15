require 'csv'

class BikesCsvImporter
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def run
    fetch do |bike_hash|
      import_bike bike_hash
    end
  end

  def analyze(fields = [])
    fields = fields.map &:downcase
    grouped = {}
    fetch do |bike_hash|
      bike_hash.each do |key, value|
        next if fields.any? && !fields.include?(key.downcase)
        grouped[key]        ||= {}
        grouped[key][value] ||= 0
        grouped[key][value]  += 1
      end
    end
    grouped
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
    @header = row
  end

  def parse_bike(row)
    @header.zip(row).to_h
  end

  def import_bike(bike_hash)
    # TODO
  end

  def clean_value(value)
    value_or_nil strip_value(value)
  end

  def strip_value(value)
    value.try(:strip).try(:gsub, /\n|\r/, '')
  end

  def value_or_nil(value)
    return value unless ['?', 'n/a', 'missing', ''].include? value.try(:downcase)
  end
end
