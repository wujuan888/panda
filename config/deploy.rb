require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
# require 'mina/unicorn'
require 'mina_sidekiq/tasks'

set :deploy_to, '/data/project/panda'

set :repository, 'git@github.com:wujuan888/panda.git'

set :shared_paths, %w(config/database.yml config/yetting.yml log)
# 设置git地址及分支

# 设置sidekiq unicorn 的进程保存地址
set :sidekiq_pid, "#{deploy_to}/tmp/pids/sidekiq.pid"

set :unicorn_pid, "#{deploy_to}/tmp/pids/unicorn.pid"

task :environment do
  invoke :'rvm:use[ruby-2.6.3@rails602]'
end

task :setup => :environment do
  # unicorn and sidekiq needs a place to store its pid file
  queue %[mkdir -p "#{deploy_to}/tmp/sockets/"]
  queue %[mkdir -p "#{deploy_to}/tmp/pids/"]

  #fileupload tmp file
  queue %[mkdir -p "#{deploy_to}/#{shared_path}/uploads/cache/"]

  queue %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue %[mkdir -p "#{deploy_to}/#{shared_path}/config"]

  queue %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue %[touch "#{deploy_to}/#{shared_path}/config/yetting.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml'"]

  queue %[
    repo_host=`echo $repo | sed -e 's/.*@//g' -e 's/:.*//g'` &&
    repo_port=`echo $repo | grep -o ':[0-9]*' | sed -e 's/://g'` &&
    if [ -z "${repo_port}" ]; then repo_port=22; fi ]
  end

task :production do
  set :domain, '47.97.105.129'
  set :user, 'deployer'
  set :port, '22'
  set :rails_env, 'production'
  set :unicorn_env, 'production'
  set :branch, 'master'
end
task :development do
  set :domain, '47.97.105.129'
  set :user, 'deployer'
  set :port, '22'
  set :rails_env, 'production'
  set :unicorn_env, 'production'
  set :branch, 'master'
end

desc 'Deploys the current version to the server.'
task :deploy => :environment do
  to :before_hook do
  end
  deploy do
    invoke :'sidekiq:quiet'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
   # invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
       invoke :'sidekiq:restart'
       invoke :'unicorn:restart'
    end
  end
end

desc 'Deploys unicorn current version to the server.'
task :deploy_unicorn => :environment do
  to :before_hook do
  end
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      invoke :'unicorn:restart'
    end
  end
end

desc 'Deploys sidekiq current version to the server.'
task :deploy_sidekiq => :environment do
  to :before_hook do
  end
  deploy do
    invoke :'sidekiq:quiet'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      invoke :'sidekiq:restart'
    end
  end
end

namespace :unicorn do
  set :unicorn_pid, "#{deploy_to}/tmp/pids/unicorn.pid"

  desc 'Start Unicorn'
  task :start => :environment do
    queue 'echo "-----> Start Unicorn"'
    queue! %{
      cd #{deploy_to}/#{current_path} && bundle exec unicorn_rails -c config/unicorn.rb -E production -D
    }
  end

  desc 'Stop Unicorn'
  task :stop do
    queue 'echo "-----> Stop Unicorn"'
    queue! %{
      kill -QUIT `cat "#{unicorn_pid}"` && rm -rf "#{unicorn_pid}" && echo "Stop Ok" && exit 0
      echo >&2 "Not running"
    }
  end

  desc 'Restart unicorn'
  task :restart => :environment do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end
end



