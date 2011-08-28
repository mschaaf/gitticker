require 'rubygems'
require 'net/http'
require 'uri'
require_relative "http_auth"

class Fetcher

  def fetch(uriString)
    uri = URI.parse(uriString)
    #push http auth
    httpAuth = HttpAuth.new;
    yield httpAuth if block_given?

    data=""
    Net::HTTP.start(uri.host) { |http|
      full_path = (uri.query.nil?) ? uri.path : "#{uri.path}?#{uri.query}"
      req = Net::HTTP::Get.new(full_path)
      if (httpAuth.isSet)
        req.basic_auth httpAuth.user, httpAuth.password
      end
      response = http.request(req)
      data = response.body
    }
    data
  end

end

