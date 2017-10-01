# frozen_string_literal: true

module CircleciTrimmer
  # define setting manager
  module Setting
    TOKEN_PATH          = File.expand_path('~/.circleci_token').freeze
    TOKEN_PATH_FOR_TEST = File.expand_path('~/.circleci_token_test').freeze
    def self.token_path
      ENV['TEST_FLAG'] ? TOKEN_PATH_FOR_TEST : TOKEN_PATH
    end

    def self.token
      if File.exist?(token_path)
        File.open(token_path, 'r', &:read)
      else
        fail 'there is no registered token. please register token'
      end
    end

    def self.token=(token)
      File.open(token_path, 'w') { |f| f.puts(token) }
    end
  end
end
