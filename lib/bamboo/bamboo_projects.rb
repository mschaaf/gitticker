require_relative 'jsonable'
require_relative 'bamboo_project'

class BambooProjects < Jsonable

  def initialize(fetchedContent)
    super
  end

  def projects
    projects = Array.new
    @hashmap['projects']['project'].each { |project|
      projects.push(BambooProject.new(project))
    }
    projects
  end

  def self.urlThatDescribeMe
    '/rest/api/latest/project.json?expand=projects.project.plans.plan'
  end

end
