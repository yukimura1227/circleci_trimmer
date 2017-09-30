require 'thor'

module CircleciTrimmer
  # define commands
  class Command < Thor
    def self.token_path
      if ENV['TEST_FLAG']
        File.expand_path('~/.circleci_token_test').freeze
      else
        File.expand_path('~/.circleci_token').freeze
      end
    end

    desc 'example', 'an example task'
    def example
      puts "I'm a thor task!"
    end

    desc 'show_token', 'show registered token'
    def show_token
      if File.exist?(self.class.token_path)
        File.open(self.class.token_path, 'r') { |f| puts f.read }
      else
        puts 'there is no registered token. please register token'
      end
    end

    desc 'token', 'store circle ci api token'
    def token(token)
      File.open(self.class.token_path, 'w') { |f| f.puts(token) }
    end
  end
end
