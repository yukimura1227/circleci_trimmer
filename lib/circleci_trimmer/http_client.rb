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
    # TODO: 名前付きテンプレート　文字列にしたい
    API_URI_PROJECT  = "#{COMMON_ENDPOINT}/project/github/%s/%s/tree/%s?circle-token=%s".freeze

    def call_projects
      return @projects_cache if @projects_cache
      params = {
        'circle-token' => CircleciTrimmer::Setting.token
      }
      client = HTTPClient.new
      response = client.get(API_URI_PROJECTS, params)
      @projects_cache = response.body
    end

    def call_user_repo_branch(username, repo_name, branch)
      uri = format(
        API_URI_PROJECT,
        username,
        repo_name,
        branch,
        CircleciTrimmer::Setting.token
      )
      # TODO: キャッシュして使いまわした方が良い？HTTPClientを
      client = HTTPClient.new
      response = client.get(uri)
      puts response.body
    end

    def list_user_names
      call_projects unless @projects_cache
      projects_api_result = JSON.parse(@projects_cache)
      repo_infos = projects_api_result.map { |v| Hashie::Mash.new(v) }
      repo_infos.map(&:username)
    end
  end
end
