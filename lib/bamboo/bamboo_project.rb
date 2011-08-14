require_relative 'nameable'
require_relative 'bamboo_build_plan'

class BambooProject < Nameable

  def initialize(name)
    super
    @buildPlans = Hash.new
  end

  def addAndGetBambooBuildPlan(buildPlan)
    unless @buildPlans.has_key?(buildPlan)
      @buildPlans[buildPlan] = BambooBuildPlan.new(buildPlan)
    end
    @buildPlans[buildPlan]
  end

  def buildPlans
    @buildPlans
  end
end
