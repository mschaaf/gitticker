require_relative 'jsonable'
require_relative 'bamboo_result'

class BambooResults < Jsonable

  def results
    results = Array.new
    @hashmap['results']['result'].each { |result|
      results.push(BambooResult.new(result))
    }
    results
  end

  def result(projectName, planName)
    results.each { |result|
      if(result.project == projectName && result.plan == planName)
        return result
      end
    }
    return NIL
  end

  def self.urlThatDescribeMe
    '/rest/api/latest/result.json?max-results=100'
  end

end
