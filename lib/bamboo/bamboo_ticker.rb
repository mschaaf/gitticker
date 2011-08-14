require 'yaml'
require_relative '../http/fetcher'
require_relative 'bamboo_parser'
require 'colorize'

class BambooTicker

  def tick
    #load properties
    dir = File.dirname(__FILE__)
    props = YAML::load(File.open(File.join(dir,"bamboo.properties")))

    #fetch content
    f = Fetcher.new
    content = f.fetch(props['bamboo.host']+'/rest/api/latest/result.json') { |httpAuth|
        httpAuth.auth(props['bamboo.user'], props['bamboo.password'])
    }

    #parse content
    parser = BambooParser.new
    projects = parser.parseJson(content)

    #print out parsed content
    projects.bambooProjects.each { |projectName, project|
      printf("%-12s", projectName)
      project.buildPlans.each { |planName, plan|
        case plan.state
          when 'Successful'
          print plan.name.colorize(:green)+' '
          when 'Failed'
          print plan.name.colorize(:red)+' '
        end
      }
      puts ''
    }

  end
end

