class BikeWheelSize < ActiveRecord::Base
  belongs_to :bike

  def display_string
    ["#{twmm}-#{rdmm}", "#{rdin}x#{twin}", "#{rdfr}x#{twfr}", description].join(" | ")
  end

  def to_s
    "#{twmm}-#{rdmm} #{rdin}x#{twin} #{rdfr}x#{twfr} '#{description}' #{tire_common_score}"
  end
end
