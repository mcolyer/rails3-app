rvmrc = <<-RVMRC
rvm_gemset_create_on_use_flag=1
rvm use 1.9.2@#{app_name}
RVMRC

create_file ".rvmrc", rvmrc

gem "barista"
gem "compass"
gem "compass-susy-plugin"
gem "haml-rails"
gem "jquery-rails"
gem "rspec-rails", :group => :test
gem "factory_girl_rails", :group => :test
gem "capybara", :group => :test
gem "factory_girl_generator", :group => [:test, :development]
gem "fixture_builder", :group => [:test, :development]
gem "rails3-generators", :group => :development

generators = <<-GENERATORS

    config.generators do |g|
      g.fixture_replacement :factory_girl
      g.test_framework :rspec, :fixture => true, :views => false
      g.integration_tool :rspec, :fixture => true, :views => true
    end
GENERATORS

application generators

gsub_file 'config/application.rb', 'config.action_view.javascript_expansions[:defaults] = %w()', 'config.action_view.javascript_expansions[:defaults] = %w(jquery.js jquery-ui.js rails.js)'

create_file "log/.gitkeep"
create_file "tmp/.gitkeep"

git :init
git :add => "."

docs = <<-DOCS

Run the following commands to complete the setup of #{app_name.humanize}:

% cd #{app_name}
% bundle install
% rails generate rspec:install
% rails generate jquery:install
DOCS

log docs
