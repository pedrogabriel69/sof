role :app, %w{dev@104.236.113.199}
role :web, %w{dev@104.236.113.199}
role :db,  %w{dev@104.236.113.199}

set :rails_env, :production
set :stage, :production

server '104.236.113.199', user: 'dev', roles: %w{web app db}, primary: true

set :ssh_options, {
 keys: %w(~/.ssh/id_rsa),
 forward_agent: true,
 auth_methods: %w(publickey password),
 port: 4321
}
