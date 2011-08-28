require 'yaml'
require_relative '../http/fetcher'
require_relative 'bamboo_projects'
require_relative 'bamboo_results'
require_relative 'bamboo_result'
require 'colorize'

class BambooTicker

  def tick
    #load properties
    dir = File.dirname(__FILE__)
    props = YAML::load(File.open(File.join(dir,"bamboo.properties")))

    #fetch content
    f = Fetcher.new


    resultsAsJson = f.fetch(props['bamboo.host'] + BambooResults.urlThatDescribeMe) { |httpAuth|
                    httpAuth.auth(props['bamboo.user'], props['bamboo.password'])
    }
    results = BambooResults.new(resultsAsJson)

    projectsAsJson = f.fetch(props['bamboo.host'] + BambooProjects.urlThatDescribeMe) { |httpAuth|
              httpAuth.auth(props['bamboo.user'], props['bamboo.password'])
    }
    b = BambooProjects.new(projectsAsJson)

    b.projects.each { |project|
      puts project.key
      puts '---------------------'
      project.plans.each { |plan|

        unless  results.result(project.key, plan.key).nil?
          if(results.result(project.key, plan.key).isSuccessful)
            print plan.key.colorize(:green)
          else
            print plan.key.colorize(:red)
          end
        else
          plan.key
        end

        if plan.isBuilding
          print '*'.colorize(:cyan)
        end

        print ' '
      }
      puts ''
      puts ''
    }
  end

end

