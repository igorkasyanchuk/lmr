$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"    # Load RVM's capistrano plugin.
#set :rvm_ruby_string, '1.9.3-p125'   # Or whatever env you want it to run in.
set :rvm_type, :system     # I really mean :system here. Not :user.

# bundler bootstrap
require "bundler/capistrano"
#set :bundle_without, [:test, :development]

# main details
set :application, "lmr"  
role :web, "192.168.242.118"   # #{application}.cloud.voupe.net
role :app, "192.168.242.118"
role :db,  "192.168.242.118", :primary => true

set :default_environment, {
  'PATH' => "/usr/local/rvm/gems/ruby-1.9.3-p194:/usr/local/rvm/gems/ruby-1.9.3-p194/bin:/usr/local/rvm:$PATH",
  'RUBY_VERSION' => 'ruby 1.9.3p194'
}

# server details
#default_run_options[:pty] = true
#ssh_options[:forward_agent] = true
set :deploy_to, "/www/#{application}"
set :deploy_via, :remote_cache
set :user, "root"
set :password, "root"
set :ruby, "/usr/local/rvm/gems/ruby-1.9.3-p194/bin/ruby"
#set :use_sudo, true

#set :bundle_cmd, 'source $HOME/.bash_profile && bundle'

# repo details
set :scm, :git
set :repository, "git@github.com:igorkasyanchuk/lmr.git"
set :branch, "staging"

namespace :deploy do
  desc "Tell Passenger to restart."
  task :restart, :roles => :web do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end

  desc "Do nothing on startup so we don't get a script/spin error."
  task :start do
    puts "You may need to restart Apache."
  end

  desc "Symlink extra configs and folders."
  task :symlink_extras do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/portal.pem #{release_path}/portal.pem"
  end

  desc "Setup shared directory."
  task :setup_shared do
    run "mkdir #{shared_path}/config"
    put File.read("config/examples/database.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end

  desc "Make sure there is something to deploy"
  task :check_revision, :roles => :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/staging`
      puts "WARNING: HEAD is not the same as origin/staging"
      puts "Run `git push` to sync changes."
      exit
    end
  end

  desc "Compile assets"
  task :assets_precompile, :roles => :app do
    run "cd #{release_path}; RAILS_ENV=production bundle exec rake assets:precompile"
  end
end

before "deploy", "deploy:check_revision"
after "deploy", "deploy:cleanup" # keeps only last 5 releases
after "deploy:setup", "deploy:setup_shared"
after "deploy:update_code", "deploy:symlink_extras"
after "deploy:symlink_extras", "deploy:assets_precompile"
        require './config/boot'
        require 'airbrake/capistrano'
