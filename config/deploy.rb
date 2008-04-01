set :user, "timetrackr.newminds.nl"
set :application, "s013725.railsnet.nl"

default_run_options[:pty] = true
set :deploy_to, "~"
set :use_sudo, false
set :group_writable, false

set :repository, "git://github.com/mlangenberg/timetrackr.git"
set :scm, "git"
set :deploy_via, :remote_cache

role :web, application
role :app, application
role :db, application, :primary => true

namespace :deploy do
  task :start, :roles => :app do
    sudo "mongrel_manager start", :as => "manager"
  end
  task :stop, :roles => :app do
    sudo "mongrel_manager stop", :as => "manager"
  end
  task :restart, :roles => :app do
    sudo "mongrel_manager restart", :as => "manager"
  end

  task :default do
    update
    backgroundrb.restart
    restart
  end
  
  namespace :backgroundrb do
    task :start do
      run "backgroundrb_manager start"
    end
    task :stop  do
      run "backgroundrb_manager stop"
    end

    task :restart do 
      stop
      start
    end
  end
end

desc "Link in the production sqlite3 database"
task :after_update_code do
  run "ln -nfs #{shared_path}/db/production.sqlite3 #{release_path}/db/production.sqlite3"
end