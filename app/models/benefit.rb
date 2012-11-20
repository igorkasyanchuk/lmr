class Benefit

  attr_reader :benefits

  def self.load consumer_id, period
   @period = period
   loaded = ReportLoader.load_benefits(consumer_id, period)

   @benefits = [loaded['benefitsList']].flatten.compact.map do |raw|
     new raw
   end

   @error = loaded[:error]
   self
  end

  def self.period
    @period
  end

  def self.error
    @error
  end

  def self.benefits
    @benefits
  end

  BenefitList = Struct.new :on_family, :benefit_persons, :name, :benefit_id, :owner, :benefit_details
  BenefitDetail = Struct.new :sum, :percent, :service_id, :benefit_id

  def initialize params
    populate_benefits params
  end

  def populate_benefits re
    @benefits = BenefitList.new re['isBenefitsOnFamily'],
                                re['countBenefitsByPerson'],
                                re['categoryBenefitsName'],
                                re['categoryBenefitsID'],
                                re['benefitsOwner'],
                                fill_benefit_details(re['benefitsDetails'])
  end

  def fill_benefit_details raw
    (raw || []).map do |re|
      BenefitDetail.new re['sumBenefits'],
                        re['percentbenefits'],
                        re['serviceID'],
                        re['benefitsCaptionID']
    end
  end

  

end
