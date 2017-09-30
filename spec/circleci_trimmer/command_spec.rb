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
        File.delete(CircleciTrimmer::Command.token_path)
      end
      it 'show warning message cause yet token registered' do
        output = capture(:stdout) { described_class.start(%w(show_token)) }
        expect(output.chomp).to eq \
          'there is no registered token. please register token'
      end
    end
    context 'exists token file' do
      before do
        File.open(CircleciTrimmer::Command.token_path, 'w') do |f|
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
      File.delete(CircleciTrimmer::Command.token_path)
    end
    it 'store api_token_value' do
      described_class.start(%w(token dummy_token_value))
      stored_token =
        File.open(CircleciTrimmer::Command.token_path, 'r', &:read)
      expect(stored_token.chomp).to eq 'dummy_token_value'
    end
  end
end
