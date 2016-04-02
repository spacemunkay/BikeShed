namespace :import do
  desc "Import a CSV list of bikes. Call via 'rake import:bikes_csv['myFilename.csv']'"
  task :bikes_csv, [:filename] => :environment do |t, args|
    require 'csv'
    # Expected Headers:
    # Shop Specific ID Number, Program Type/Purpose, Gone (Is it in the shop?),Date In,Date Out,Price/Value,Make/Brand,Model,for Whom,for Whom Zip Code,Comment
    #
    # 2,Shop,Yes,Missing,2/17/2008,$90,Univega,Novo Sport Chronology,Darrell Forbes,Missing,,bikes for the World,
    @loggable_type = 'Bike'
    @log_action_type= 'ActsAsLoggable::BikeAction'
    @logger_type = 'User'
    @logger_id = User.find_by_username('admin')
    @acquired_log_action_id = ActsAsLoggable::BikeAction.find_by_action('ACQUIRED')
    @note_log_action_id = ActsAsLoggable::BikeAction.find_by_action('NOTE')
    @completed_log_action_id = ActsAsLoggable::BikeAction.find_by_action('COMPLETED')
    @sold_log_action_id = ActsAsLoggable::BikeAction.find_by_action('SOLD')

    @build_bike_matchers = ["build-a-bike"]
    @sale_matchers = ["as-is","shop"]
    @parts_matchers = ["parts"]

    def create_acquired_log(bike_id, date)
      ActsAsLoggable::Log.new(
        loggable_type: @loggable_type,
        loggable_id: bike_id,
        logger_type: @logger_type
        logger_id: @logger_id
        log_action_type: @log_action_type
        log_aciton_id: @acquired_log_aciton_id,
        start_date: date,
        end_date: date,
      )
    end

    def create_note_log(bike_id, date, note)
      ActsAsLoggable::Log.new(
        loggable_type: @loggable_type,
        loggable_id: bike_id,
        logger_type: @logger_type
        logger_id: @logger_id
        log_action_type: @log_action_type
        log_aciton_id: @note_log_action_id,
        start_date: date,
        end_date: date,
        description: note,
      )
    end

    def create_sold_log(bike_id, date)
      ActsAsLoggable::Log.new(
        loggable_type: @loggable_type,
        loggable_id: bike_id,
        logger_type: @logger_type
        logger_id: @logger_id
        log_action_type: @log_action_type
        log_aciton_id: @sold_log_action_id,
        start_date: date,
        end_date: date,
      )
    end

    def create_completed_log(bike_id, date)
      ActsAsLoggable::Log.new(
        loggable_type: @loggable_type,
        loggable_id: bike_id,
        logger_type: @logger_type
        logger_id: @logger_id
        log_action_type: @log_action_type
        log_aciton_id: @completed_log_action_id,
        start_date: date,
        end_date: date,
      )
    end

    def get_bike_purpose_id(purpose)
      case purpose.downcase
      when *@build_bike_matchers
      when *@sale_matchers
      when *@parts_matchers
      else
      end
    end

    CSV.foreach(args[:filename], headers: true) do | row |
      bike_id = row["Shop Specific ID Number"]
      bike_purpose_id = get_bike_purpose_id(row["Program Type/Purpose"])
      bike_value = get_bike_value(row["Price/Value"])
      bike_brand_id = get_bike_brand(row["Make/Brand"])
      bike_model = get_bike_model(row["Model"])

      bike = Bike.find_or_create_by_shop_id_and_bike_purpose_id_and_value_and_bike_brand_id_and_model(
        bike_id,
        bike_purpose_id,
        bike_value,
        bike_brand_id,
        bike_model
      )
      
      #Create aquired log
      #
      #Create For whom log
      #
      #Create note/comment log
      #
      #Create SOLD/completed log
      #
    end
  end
end
