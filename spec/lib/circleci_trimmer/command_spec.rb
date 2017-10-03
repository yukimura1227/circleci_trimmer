require 'spec_helper'

RSpec.describe CircleciTrimmer::Command do
  let(:command) { described_class.new }
  it do
    expect(described_class.to_s).to eq 'CircleciTrimmer::Command'
  end
  it '#example' do
    # test sample this means do [bin/circleci_trim example] on console
    output = capture(:stdout) { described_class.start(%w(example)) }
    expect(output.chomp).to eq "I'm a thor task!"
  end
  describe 'show token' do
    context 'no token file' do
      before do
        if File.exist?(CircleciTrimmer::Setting::TOKEN_PATH_FOR_TEST)
          File.delete(CircleciTrimmer::Setting::TOKEN_PATH_FOR_TEST)
        end
      end
      it 'show warning message cause yet token registered' do
        expect { described_class.start(%w(show_token)) }.to raise_error(
          /there is no registered token. please register token/
        )
      end
    end
    context 'exists token file' do
      before do
        File.open(CircleciTrimmer::Setting::TOKEN_PATH_FOR_TEST, 'w') do |f|
          f.write('dummy')
        end
      end
      it 'show registered token value' do
        output = capture(:stdout) { described_class.start(%w(show_token)) }
        expect(output.chomp).to eq \
          'dummy'
      end
    end
  end
  describe 'token [api_token_value]' do
    before do
      if File.exist?(CircleciTrimmer::Setting::TOKEN_PATH_FOR_TEST)
        File.delete(CircleciTrimmer::Setting::TOKEN_PATH_FOR_TEST)
      end
    end
    it 'store api_token_value' do
      described_class.start(%w(token dummy_token_value))
      stored_token =
        File.open(CircleciTrimmer::Setting::TOKEN_PATH_FOR_TEST, 'r', &:read)
      expect(stored_token.chomp).to eq 'dummy_token_value'
    end
  end
  describe 'call_projects' do
    # TODO: using stub (now executing real api)
    before do
      File.open(CircleciTrimmer::Setting::TOKEN_PATH_FOR_TEST, 'w') do |f|
        f.write(ENV['CIRCLECI_API_TOKEN'])
      end
    end
    it 'show user names' do
      output = capture(:stdout) { described_class.start(%w(call_projects)) }
      expect(output.chomp).to match(/yukimura1227/)
    end
  end
  describe 'list_user_names' do
    # TODO: using stub (now executing real api)
    before do
      File.open(CircleciTrimmer::Setting::TOKEN_PATH_FOR_TEST, 'w') do |f|
        f.write(ENV['CIRCLECI_API_TOKEN'])
      end
    end
    it 'show user names' do
      output = capture(:stdout) { described_class.start(%w(list_user_names)) }
      expect(output.chomp).to match(/yukimura1227/)
    end
  end
  describe 'call_user_repo_branch' do
    # TODO: using stub (now executing real api)
    before do
      File.open(CircleciTrimmer::Setting::TOKEN_PATH_FOR_TEST, 'w') do |f|
        f.write(ENV['CIRCLECI_API_TOKEN'])
      end
    end
    context 'no optional args' do
      it 'call_user_repo_branch' do
        output = capture(:stdout) do
          described_class.start(
            %w(
              call_user_repo_branch -u=yukimura1227 -r=codecov_sample -b=master
            )
          )
        end
        expect(output.chomp).to match(/yukimura1227/)
      end
    end
    context 'with optional args(start_at_from and start_at_to' do
      # TODO: it should check for filtering but 9999-12-31 is meaningless
      it 'call_user_repo_branch' do
        output = capture(:stdout) do
          described_class.start(
            ['call_user_repo_branch',
             '-u=yukimura1227', '-r=codecov_sample', '-b=master',
             "--start_at_from='9999-12-31'", "--start_at_to='9999-12-31'"]
          )
        end
        expect(output.chomp).to eq ''
      end
    end
  end
end
