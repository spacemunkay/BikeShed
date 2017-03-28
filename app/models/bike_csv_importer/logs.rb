# Helper module to create ActsAsLoggable log entries for a Bike instance from a CSV row hash
class BikeCsvImporter
  module Logs
    def log_entry_gone(bike, bike_hash)
      if clean_value(bike_hash['gone']).to_s =~ /y/i
        log_entry bike, log_entry_date(clean_value(bike_hash['date out'])), 'COMPLETED', 'Gone'
      end
    end

    def log_entry_acquired(bike, bike_hash)
      if clean_value(bike_hash['date in'])
        log_entry bike, log_entry_date(clean_value(bike_hash['date in'])), 'ACQUIRED'
      end
    end

    def log_entry_comment(bike, bike_hash)
      if clean_value(bike_hash['comment']).present?
        log_entry bike, nil, 'NOTE', clean_value(bike_hash['comment'])
      end
    end

    def log_entry_date(value)
      return unless value
      Date.strptime value, '%m/%d/%y' rescue nil
    end

    def log_entry(bike, date, type, description = nil)
      date ||= DateTime.now
      bike_action = cached_log_bike_action(type)

      ActsAsLoggable::Log.new(
        loggable_type:    bike.class.to_s,
        loggable_id:      bike.id || bike.shop_id.to_i, # for dry run
        log_action_type:  bike_action.class.to_s,
        log_action_id:    bike_action.id,
        start_date:       date,
        end_date:         date,
        description:      description,
      )
    end
  end
end
