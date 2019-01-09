lock '~> 3.11.0'

set :application, 'api'

set :repo_url, '<PASTE_REPOSITORY_URL_HERE>'
set :branch, 'master'

set :user, 'ubuntu'
set :pty, true
set :ssh_options, {
    forward_agent: true,
    auth_methods: %w[publickey password],
    keys: %w[tmp/default.pem]
}

set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :keep_releases, 5

append :linked_dirs, 'src/log', 'src/storage', 'nginx/log'

namespace :deploy do
  task :init do
    invoke 'deploy'
    invoke 'db:setup'
  end

  after :published, :restart do
    invoke 'docker:build'
    invoke 'docker:up'
    invoke 'check:permissions'
  end
end

namespace :docker do
  task :build do
    on roles(:app) do
      within current_path do
        execute("docker-compose",
                "--project-name=#{fetch(:application)}",
                "-f", "docker-compose.yml",
                "-f", "docker-compose.prd.yml",
                "build"
        )
      end
    end
  end

  task :up do
    on roles(:app) do
      within current_path do
        execute("docker-compose",
                "--project-name=#{fetch(:application)}",
                "-f", "docker-compose.yml",
                "-f", "docker-compose.prd.yml",
                "up", "-d", "--remove-orphans"
        )
      end
    end
  end
end

namespace :db do
  task :setup do
    on roles(:app) do
      within current_path do
        execute("docker-compose",
                "--project-name=#{fetch(:application)}",
                "-f", "docker-compose.yml",
                "-f", "docker-compose.prd.yml",
                "exec", "-d", "app",
                "rake", "db:setup"
        )
      end
    end
  end

  task :migrate do
    on roles(:app) do
      within current_path do
        execute("docker-compose",
                "--project-name=#{fetch(:application)}",
                "-f", "docker-compose.yml",
                "-f", "docker-compose.prd.yml",
                "exec", "-d", "app",
                "rake", "db:migrate"
        )
      end
    end
  end
end

namespace :check do
  task :permissions do
    on roles(:app) do
      within deploy_path do
        execute("sudo", "chown", "${USER}:${USER}", ".", "-R")
      end
    end
  end
end
