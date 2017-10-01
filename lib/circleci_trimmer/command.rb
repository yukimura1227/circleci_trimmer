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
      if File.exist?(CircleciTrimmer::Setting.token_path)
        File.open(CircleciTrimmer::Setting.token_path, 'r') { |f| puts f.read }
      else
        puts 'there is no registered token. please register token'
      end
    end

    desc 'token', 'store circle ci api token'
    def token(token)
      File.open(CircleciTrimmer::Setting.token_path, 'w') { |f| f.puts(token) }
    end
  end
end
