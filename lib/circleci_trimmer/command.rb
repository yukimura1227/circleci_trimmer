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
