threads 2,2
port  ENV.fetch("PORT") { 3060 }.to_i
environment ENV['RACK_ENV'] || 'development'
worker_timeout 60

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

#bind 'tcp://127.0.0.1:3030'
#bind "unix://#{application_path}/tmp/sockets/app.sock"

daemonize true
plugin :tmp_restart

preload_app!
