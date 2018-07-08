insert_into_file 'config/application.rb', :before => /^  end/ do
  <<-'RUBY'
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.generators.javascript_engine = :js
    config.generators do |g|
      g.test_framework nil, fixture: false
      g.stylesheets false
      g.javascripts false
      g.jbuilder false
      g.helper false
      g.controller :test_framework => false, :helper => false, :assets => false
      g.view_specs false
      g.helper_specs false
      g.system_tests = nil
    end
  RUBY
end
