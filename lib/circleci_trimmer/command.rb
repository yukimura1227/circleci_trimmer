require 'thor'
require 'circleci_trimmer/setting'

module CircleciTrimmer
  # define commands
  class Command < Thor
    include CircleciTrimmer::Setting
    desc 'example', 'an example task'
    def example
      puts "I'm a thor task!"
    end

    desc 'show_token', 'show registered token'
    def show_token
      Setting.token
    end

    desc 'token', 'store circle ci api token'
    def token(token)
      Setting.token = token
    end
  end
end
