require 'httpclient'
require 'json'
require 'circleci_trimmer/setting'

module CircleciTrimmer
  # define api executer
  class HttpClient
    def call_projects
      uri = 'https://circleci.com/api/v1.1/projects'
      params = {
        'circle-token' => CircleciTrimmer::Setting.token
      }
      client = HTTPClient.new
      response = client.get(uri, params)
      JSON.parse(response.body)
    end
  end
end
