require_relative 'hashable'
require_relative 'bamboo_build_plan'

class BambooProject < Hashable

  def key
    @hashmap['key']
  end

  def plans
    plans = Array.new
    @hashmap['plans']['plan'].each { |plan|
      if(plan['enabled'])
        plans.push(BambooBuildPlan.new(plan))
      end
    }
    plans
  end

end
