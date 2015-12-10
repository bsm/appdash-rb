require 'rake'
require 'bundler/gem_tasks'

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task default: :spec

namespace :protobuf do
  PROTO_ROOT = "./defs/appdash"

  task :fetch do
    target = "#{PROTO_ROOT}/collector.proto"
    sh %(mkdir -p #{PROTO_ROOT})
    sh %(curl -sSL https://raw.githubusercontent.com/sourcegraph/appdash/master/internal/wire/collector.proto | sed 's/package wire/package appdash/' > #{target})
  end

  task :compile do
    Dir[PROTO_ROOT+"/**/*.proto"].each do |file|
      sh "PB_NO_TAG_WARNINGS=1 protoc -I ./defs --ruby_out ./lib #{file}"
    end
  end

  desc "Rebuild protobuf definitions"
  task rebuild: [:fetch, :compile]

end
