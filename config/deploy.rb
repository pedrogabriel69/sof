# config valid only for current version of Capistrano
lock "3.7.2"

set :application, "sof"
set :repo_url, "git@github.com:pedrogabriel69/sof.git"

set :deploy_to, "/home/dev/sof"
set :deploy_user, "dev"

append :linked_files, "config/database.yml", ".env", "config/production.sphinx.conf"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/uploads"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # execute :touch, release_path.join('tmp/restart.txt')
      invoke 'unicorn:restart'
    end
  end

  after :publishing, :restart
end

after :deploy, 'thinking_sphinx:rebuild'
