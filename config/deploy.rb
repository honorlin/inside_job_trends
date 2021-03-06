# -*- encoding : utf-8 -*-
require "./config/boot"
require "bundler/capistrano"
require "whenever/capistrano"
require "cape"


default_environment["PATH"] = "/opt/ruby/bin:/usr/local/bin:/usr/bin:/bin"

set :application, "inside_job_trends"
set :repository,  "git@github.com:honorlin/#{application}.git"
set :deploy_to, "/home/deploy/#{application}"

set :branch, "master"
set :scm, :git

set :user, "deploy"
set :group, "deploy"

set :deploy_to, "/home/deploy/#{application}"
set :runner, "deploy"
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :use_sudo, false

set :whenever_command, "bundle exec whenever"
#set :hipchat_token, APP_CONFIG["production"]["hipchat_token"]
#set :hipchat_room_name, APP_CONFIG["production"]["hipchat_room_name"]
#set :hipchat_announce, false # notify users?

role :web, "eliving.co"                          # Your HTTP server, Apache/etc
role :app, "eliving.co"                         # This may be the same as your `Web` server
role :db,  "eliving.co"   , :primary => true # This is where Rails migrations will run

set :deploy_env, "production"
set :rails_env, "production"
set :scm_verbose, true
set :use_sudo, false


Cape do
  mirror_rake_tasks :dev do |recipies|
    recipies.env['RAILS_ENV'] = rails_env
  end

  mirror_rake_tasks :newspaper do |recipies|
    recipies.env['RAILS_ENV'] = rails_env
  end
end

namespace :deploy do

  desc "Restart passenger process"
  task :restart, :roles => [:web], :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
end


namespace :my_tasks do
  task :symlink, :roles => [:web] do
    run "mkdir -p #{deploy_to}/shared/log"
    run "mkdir -p #{deploy_to}/shared/pids"
    
    symlink_hash = {
      "#{shared_path}/config/database.yml.production"   => "#{release_path}/config/database.yml",
      "#{shared_path}/config/application.yml"   => "#{release_path}/config/application.yml",
      "#{shared_path}/uploads"              => "#{release_path}/public/uploads",
    }

    symlink_hash.each do |source, target|
      run "ln -sf #{source} #{target}"
    end
  end

end



namespace :remote_rake do
  desc "Run a task on remote servers, ex: cap staging rake:invoke task=cache:clear"
  task :invoke do
    run "cd #{deploy_to}/current; RAILS_ENV=#{rails_env} bundle exec rake #{ENV['task']}"
  end
end

after "deploy:finalize_update", "my_tasks:symlink"