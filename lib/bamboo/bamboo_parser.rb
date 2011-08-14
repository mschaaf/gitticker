require 'rubygems'
require 'json'
require_relative '../http/fetcher'
require_relative 'bamboo_project'
require_relative 'bamboo_build_plan'
require_relative 'bamboo_projects'

class BambooParser

  def parseJson(content)
    projects = BambooProjects.new

    jsonResult = JSON.parse(content)
    jsonResult['results']['result'].each { |parseResult|
      key = parseResult['key']
      state = parseResult['state']
      projectName = key.split('-')[0]
      planName = key.split('-')[1]

      bambooProject = projects.addAndGetBambooProject(projectName)
      bambooBuildPlan = bambooProject.addAndGetBambooBuildPlan(planName)
      bambooBuildPlan.setState(state)
    }

    projects

  end
end

