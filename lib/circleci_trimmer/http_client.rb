# frozen_string_literal: true

require 'httpclient'
require 'json'
require 'hashie'
require 'circleci_trimmer/setting'

module CircleciTrimmer
  # define api executer
  class HttpClient
    PROTOCOL = 'https:'.freeze
    DOMAIN   = 'circleci.com'.freeze
    COMMON_ENDPOINT = "#{PROTOCOL}//#{DOMAIN}/api/v1.1".freeze
    API_URI_PROJECTS = "#{COMMON_ENDPOINT}/projects".freeze
    # TODO: want to using template with named variables
    API_URI_PROJECT =
      "#{COMMON_ENDPOINT}/project/github/%s/%s/tree/%s?circle-token=%s".freeze

    def call_projects
      return @projects_cache if @projects_cache
      params = {
        'circle-token' => CircleciTrimmer::Setting.token
      }
      client = HTTPClient.new
      response = client.get(API_URI_PROJECTS, params)
      @projects_cache = response.body
    end

    def call_user_repo_branch(
      username, repo_name, branch,
      start_at_from = '1900-01-01', start_at_to = '9999-12-31'
    )
      # TODO: using cache for client is better?
      client = HTTPClient.new
      uri = project_uri(username, repo_name, branch)
      response = client.get(uri)
      result_json = JSON.parse(response.body)
      build_infos = result_json.map { |v| Hashie::Mash.new(v) }
      done_build_infos = filter_by_status(build_infos)
      selected_build_infos =
        filter_by_start_time(done_build_infos, start_at_from, start_at_to)
      puts selected_build_infos.map { |v| "#{v.start_time}, #{v.status}" }
    end

    def list_user_names
      call_projects unless @projects_cache
      projects_api_result = JSON.parse(@projects_cache)
      repo_infos = projects_api_result.map { |v| Hashie::Mash.new(v) }
      repo_infos.map(&:username)
    end

    private

    def filter_by_status(build_infos)
      build_infos.select do |v|
        v.lifecycle == 'finished' && v.status != 'canceled'
      end
    end

    def filter_by_start_time(build_infos, start_at_from, start_at_to)
      build_infos.select do |v|
        start_at_from <= v.start_time && v.start_time < start_at_to
      end
    end

    def project_uri(username, repo_name, branch)
      format(
        API_URI_PROJECT,
        username,
        repo_name,
        branch,
        CircleciTrimmer::Setting.token
      )
    end
  end
end
