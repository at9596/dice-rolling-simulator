# spec/spec_helper.rb
require 'rspec'

# Require all files in lib automatically
Dir[File.join(__dir__, '../lib/**/*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  # Optional configurations
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.warnings = true
  if config.files_to_run.one?
    config.default_formatter = "doc"
  end
  # config.profile_examples = 10 # Uncomment to see slow examples
  config.order = :random
  Kernel.srand config.seed
end