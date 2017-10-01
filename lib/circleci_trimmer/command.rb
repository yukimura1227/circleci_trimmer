require 'thor'

module CircleciTrimmer
  # define commands
  class Command < Thor
    def self.token_path
      path_base = ENV['TEST_FLAG'] ? '~/.circleci_token_test' : '~/.circleci_token'
      File.expand_path(path_base).freeze
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
