# frozen_string_literal: true

module CircleciTrimmer
  # define setting manager
  module Setting
    TOKEN_PATH          = File.expand_path('~/.circleci_token').freeze
    TOKEN_PATH_FOR_TEST = File.expand_path('~/.circleci_token_test').freeze
    def self.token_path
      ENV['TEST_FLAG'] ? TOKEN_PATH_FOR_TEST : TOKEN_PATH
    end
  end
end
