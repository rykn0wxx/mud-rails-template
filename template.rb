require "fileutils"
require "shellwords"
require "tmpdir"

RAILS_REQUIREMENT = "~> 5.2.0".freeze

def apply_template!
  assert_minimum_rails_version
  add_template_repository_to_source_path
  template 'Gemfile.tt', :force => true

  apply 'app/template.rb'

  apply 'lib/template.rb'

  run 'bundle install --without production'

  apply 'config/template.rb'

  git :init unless preexisting_git_repo?

  git :add => '.', :commit => '-m "Set up project"'
  git :checkout => "-b development"

  puts 'SUCCESS!'
end

def preexisting_git_repo?
  @preexisting_git_repo ||= (File.exist?(".git") || :nope)
  @preexisting_git_repo == true
end

def assert_minimum_rails_version
  requirement = Gem::Requirement.new(RAILS_REQUIREMENT)
  rails_version = Gem::Version.new(Rails::VERSION::STRING)
  return if requirement.satisfied_by?(rails_version)

  prompt = "This template requires Rails #{RAILS_REQUIREMENT}. You are using #{rails_version}. Continue anyway?"

  exit 1 if no?(prompt)
end

def gemfile_requirement(name)
  @original_gemfile ||= IO.read("Gemfile")
  req = @original_gemfile[/gem\s+['"]#{name}['"]\s*(,[><~= \t\d\.\w'"]*)?.*$/, 1]
  req && req.gsub("'", %(")).strip.sub(/^,\s*"/, ', "')
end

def add_template_repository_to_source_path
  source_paths.unshift(File.dirname(__FILE__))
end

apply_template!
