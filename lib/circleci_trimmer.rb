require 'circleci_trimmer/version'
require 'circleci_trimmer/command'

# namespace
module CircleciTrimmer
  CircleciTrimmer::Command.start(ARGV)
end
