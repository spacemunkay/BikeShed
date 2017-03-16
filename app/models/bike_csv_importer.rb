require 'csv'

class BikeCsvImporter
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def run
    result = {imported_count: 0, skipped_shop_ids: []}
    fetch do |bike_hash|
       bike = import_bike bike_hash
       if bike.try :persisted?
         result[:imported_count] += 1
       else
         result[:skipped_shop_ids].push bike.try(:shop_id) || bike_hash.values.first
       end
    end
    result
  end

  def analyze(fields = [])
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
    @header = row.map(&:downcase)
  end

  def parse_bike(row)
    @header.zip(row).to_h
  end

  # + Velocipede Number -> Bikes.shop_id
  # Program -> Bikes.bike_purpose_id
  #
  # Gone -> If "Yes", set 'gone' to true, then create a Log entry like the following:
  #                                                                            id | loggable_id | loggable_type | logger_id | logger_type | context | start_date | end_date | description | log_action_id | log_action_type       | created_at | updated_at
  # 18 | 1 | Bike | 4 | User | | 2017-02-03 23:27:00 | 2017-02-03 23:27:00 | Gone | 5 | ActsAsLoggable::BikeAction | 2017-02-03 23:27:36.8387 | 2017-02-03 23:27:36.8387
  # See https://github.com/spacemunkay/BikeShed/blob/master/app/components/bike_logs.rb#L12-L18 for example. Use user_id 1 for current_user_id (1 should be the admin ID I think). Use "Date Out" column for start_date & end_date.  Set action_id to "COMPLETED".
  #
  # Date In -> Create a bike log entry with start_date & end_date with same value as "Date In". Set action_id to "AQUIRED"
  # Date Out -> Should be the start_date & end_date value for "Gone" column mentioned above.
  #     Price -> Bikes.value
  # Make -> Bikes.bike_brand_id
  # Model -> Bikes.bike_model_id
  # to Whom -> ignore
  # Zip Code -> ignore
  # Comment -> Create a bike log entry with action_id "NOTE". The log 'description' should be the value of 'Comment'.
  #
  # Data at the end of the CSV seems to be missing a lot of fields. If any field is empty, the the value can be "UNDETERMINED" if applicable, or ignored.  Any other dates beside "Date In/Out" can be current date.
  #
  # I realize the log entry stuff is likely complicated and time consuming. At a minimum, the most important columns to import are the following: Velocipede Number, Program, Gone, Make, Model. To avoid creating the log entry for "Gone", we would instead just set 'gone' to  true.
  def import_bike(bike_hash)
    bike = Bike.new bike_attrs(bike_hash)
    bike.save
  end

  def bike_attrs(bike_hash)
    %i{ shop_id bike_purpose gone }.each_with_object({}) do |field, memo|
      memo[field] = send :"bike_attr_#{ field }", bike_hash
    end
  end

  def bike_attr_shop_id(bike_hash)
    bike_hash['velocipede number'].to_i
  end

  def bike_attr_bike_purpose(bike_hash)
    # TODO bike_hash['program']
  end

  def bike_attr_gone(bike_hash)
    %w{ yes yeah y }.include? clean_value(bike_hash['gone']).try :downcase
  end

  def clean_value(value)
    value_or_nil strip_value(value)
  end

  def strip_value(value)
    value.try(:strip).try(:gsub, /\n|\r/, '')
  end

  def value_or_nil(value)
    return value unless ['?', 'n/a', 'missing', 'unknown', ''].include? value.try(:downcase)
  end
end
