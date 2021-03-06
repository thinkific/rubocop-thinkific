# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubocop/thinkific/version'

Gem::Specification.new do |spec|
  spec.name          = 'rubocop-thinkific'
  spec.version       = RuboCop::Thinkific::VERSION
  spec.authors       = ['Kevin Blues']
  spec.email         = ['kbluescode@gmail.com']

  spec.summary       = "RuboCop Extension for Thinkific's Ruby and Rails Applications"
  spec.homepage      = 'https://github.com/thinkific/rubocop-thinkific'
  spec.required_ruby_version = '~> 2.6'

  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # => to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata['allowed_push_host'] = 'https://github.com'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # => The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'pry', '~> 0.14.0'
  spec.add_development_dependency 'rake', '~> 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'rubocop-rake', '~> 0.4.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.2.0'

  spec.add_runtime_dependency 'rubocop', '~> 1.9.1'
end
