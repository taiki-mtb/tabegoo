threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count
port        ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { "development" }
plugin :tmp_restart

app_root = File.expand_path("../..", __FILE__)
bind "unix://#{app_root}/tmp/sockets/puma.sock"

rails_env = ENV.fetch("RAILS_ENV") { "production" }
if rails_env == "production"
  daemonize true
  stdout_redirect "/var/log/puma/puma.stdout.log", "/var/log/puma/puma.stderr.log", true
end
environment rails_env
