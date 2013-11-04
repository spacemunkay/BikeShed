class BikeWheelSize < ActiveRecord::Base
  belongs_to :bike

  def display_string
    result = []
    result << "#{twmm}-#{rdmm}" unless twmm.blank? and rdmm.blank?
    result << "#{rdin}x#{twin}" unless rdin.blank? and twin.blank?
    result << "#{rdfr}x#{twfr}" unless rdfr.blank? and twfr.blank?
    result << description unless description.blank?
    result.join(" | ")
  end

  def to_s
    "#{twmm}-#{rdmm} #{rdin}x#{twin} #{rdfr}x#{twfr} '#{description}' #{tire_common_score}"
  end
end
