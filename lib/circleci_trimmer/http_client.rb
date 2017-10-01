# frozen_string_literal: true

require 'httpclient'
require 'json'
require 'circleci_trimmer/setting'

module CircleciTrimmer
  # define api executer
  class HttpClient
    API_URI_PROJECTS = 'https://circleci.com/api/v1.1/projects'.freeze
    def call_projects
      return @projects_cache if @projects_cache
      params = {
        'circle-token' => CircleciTrimmer::Setting.token
      }
      client = HTTPClient.new
      response = client.get(API_URI_PROJECTS, params)
      @projects_cache = response.body
    end

    def list_user_names
      call_projects unless @projects_cache
      projects_api_result = JSON.parse(@projects_cache)
      projects_api_result.map { |v| v['username'] }
    end
  end
end
