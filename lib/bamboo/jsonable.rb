require 'json'
require_relative 'hashable'

class Jsonable < Hashable

  def initialize(fetchedContent)
    super JSON.parse(fetchedContent)
  end

end
