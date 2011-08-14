class BambooProjects

  def initialize
    @bambooProjects = Hash.new
  end

  def bambooProjects
    @bambooProjects
  end

  def addAndGetBambooProject(bambooProjectName)
    unless @bambooProjects.has_key?(bambooProjectName)
      @bambooProjects[bambooProjectName]=BambooProject.new(bambooProjectName)
    end
    #return the new created or existing bamboo project
    @bambooProjects[bambooProjectName]
  end

end
