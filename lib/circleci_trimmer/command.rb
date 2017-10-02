require 'thor'
require 'circleci_trimmer/setting'
require 'circleci_trimmer/http_client'

module CircleciTrimmer
  # define commands
  class Command < Thor
    desc 'example', 'an example task'
    def example
      puts "I'm a thor task!"
    end

    desc 'show_token', 'show registered token'
    def show_token
      puts Setting.token
    end

    desc 'token', 'store circle ci api token'
    def token(token)
      Setting.token = token
    end

    desc 'call_projects', 'call projects'
    def call_projects
      puts client.call_projects
    end

    option :username,  required: true, aliases: :u
    option :repo_name, required: true, aliases: :r
    option :branch,    required: true, aliases: :b
    desc 'call_user_repo_branch', 'call project api'
    def call_user_repo_branch
      client.call_user_repo_branch(
        options[:username],
        options[:repo_name],
        options[:branch]
      )
    end

    desc 'list_user_names', 'call projects and extract usernames'
    def list_user_names
      client.list_user_names.each do |username|
        puts username
      end
    end

    private

    def client
      @client ||= CircleciTrimmer::HttpClient.new
    end
  end
end
