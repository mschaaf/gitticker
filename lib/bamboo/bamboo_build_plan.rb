require_relative 'hashable'

class BambooBuildPlan < Hashable

  def key
    @hashmap['shortKey']
  end

  def isBuilding
    @hashmap['isBuilding']
  end
end
