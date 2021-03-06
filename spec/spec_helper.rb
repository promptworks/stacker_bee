require 'simplecov'

require File.expand_path('../../lib/stacker_bee', __FILE__)

require 'yaml'

default_config_file = File.expand_path('../../config.default.yml', __FILE__)
config_file         = File.expand_path('../../config.yml', __FILE__)

CONFIG = YAML.load(File.read(default_config_file))
CONFIG.merge!(YAML.load(File.read(config_file))) if File.exist?(config_file)

require 'webmock/rspec'

support_files = Dir[File.join(
  File.expand_path('../../spec/support/**/*.rb', __FILE__)
)]
support_files.each { |f| require f }

RSpec.configure do |config|
  config.raise_errors_for_deprecations!
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.before :each do
    StackerBee::Client.reset!
  end
end

require 'rspec/its'
