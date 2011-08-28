require_relative 'hashable'

class BambooResult < Hashable

  def project
    splits = @hashmap['key'].split('-')
    splits[0]
  end

  def plan
    splits = @hashmap['key'].split('-')
    splits[1]
  end

  def state
    @hashmap['state']
  end

  def isSuccessful
    case state
      when 'Successful'
      return TRUE
      when 'Failed'
      return FALSE
    end
  end

end
