require 'rake'

namespace :prometheus do
  desc "run prometheus"
  task :run do
    sh 'docker-compose up -d'
    Rake::Task["docker:list"].invoke
  end

  desc "stop prometheus"
  task :stop do
    sh 'docker-compose down'
    Rake::Task["docker:list"].invoke
  end

  desc "login prometheus container"
  task :login do
    sh 'docker exec -it prometheus sh'
  end

  desc "build and up"
  task :build do
    sh 'docker-compose up -d --build'
    Rake::Task["docker:list"].invoke
  end
end

namespace :docker do
  desc "build containers"
  task :build do
    sh 'docker build ./ -t my-prometheus'
    # sh 'docker build ./ -t my-prometheus --no-cache'
  end

  desc "list containers"
  task :list do
    # sh 'docker container ls'
    # sh 'docker container ls -a'
    sh 'docker-compose ps'
  end

  desc "remove all containers"
  task :remove do
    Rake::Task["docker:list"].invoke
    sh 'docker container prune -f'
    Rake::Task["docker:list"].invoke
  end
end

namespace :inspec do
  desc "Run Inspec tests"
  task :default do
    Rake::Task["inspec:common"].invoke
    Rake::Task["inspec:prometheus"].invoke
    # Rake::Task["inspec:grafana"].invoke
  end

  desc "Blackbox test from host"
  task :common do
    sh 'inspec exec spec/common_spec.rb'
  end

  desc "Test prometheus"
  task :prometheus do
    sh 'inspec exec spec/prometheus_spec.rb -t docker://prometheus-test_prometheus_1'
  end

  desc "Test grafana"
  task :grafana do
    sh 'inspec exec spec/grafana_spec.rb -t docker://grafana'
  end

  desc "Tests host"
  task :host do
    sh 'inspec exec spec/host_spec.rb'
  end
end

namespace :ci do
  desc "build, test and scrap"
  task :default do
    Rake::Task["ci:running"].invoke
    Rake::Task["prometheus:stop"].invoke
  end

  desc "build and test and not stop"
  task :running do
    Rake::Task["prometheus:run"].invoke
    sleep 3
    Rake::Task["inspec:default"].invoke
  end

  desc "restart nad test"
  task :restart do
    Rake::Task["prometheus:stop"].invoke
    Rake::Task["ci:running"].invoke
  end
end
