lock '~> 3.11.0'

set :application, 'api'

set :repo_url, '<GIT_REPO>'
set :branch, 'master'

set :user, '<USER>'
set :pty, true
set :ssh_options, {
    forward_agent: true,
    auth_methods: %w[publickey password],
    keys: %w[tmp/default.pem]
}

set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :keep_releases, 5

append :linked_dirs, 'src/storage'

namespace :deploy do
  task :init do
    invoke 'deploy'
    invoke 'db:setup'
  end

  after :published, :restart do
    invoke 'build'
    invoke 'start'
  end
end

task :build do
  on roles(:app) do
    within current_path do
      execute("bash",
              "scripts/prd.sh",
              "build")
    end
  end
end

task :start do
  on roles(:app) do
    within current_path do
      execute("bash",
              "scripts/prd.sh",
              "start")
    end
  end
end

namespace :db do
  task :setup do
    on roles(:app) do
      within current_path do
        execute("bash",
                "scripts/prd.sh",
                "setup")
      end
    end
  end

  task :migrate do
    on roles(:app) do
      within current_path do
        execute("bash",
                "scripts/prd.sh",
                "migrate")
      end
    end
  end
end

task :logs do
  on roles(:app) do
    within current_path do
      execute("bash",
              "scripts/prd.sh",
              "logs")
    end
  end
end