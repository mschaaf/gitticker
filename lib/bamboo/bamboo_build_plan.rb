require_relative 'nameable'

class BambooBuildPlan < Nameable

  def setState(state)
    @state = state
  end

  def state
    @state
  end

end
