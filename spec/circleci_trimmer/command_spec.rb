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
end
