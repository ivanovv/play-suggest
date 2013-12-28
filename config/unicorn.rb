#setup user environment
worker_processes(1)
preload_app true
user('deploy')
timeout 40
app_path = '/home/deploy/apps/ebay_suggest/current'

listen "/tmp/unicorn_ebay_suggest.sock"
working_directory app_path
pid "#{app_path}/tmp/pids/unicorn.pid"
stderr_path "#{app_path}/log/unicorn.stderr.log"
stdout_path "#{app_path}/log/unicorn.stdout.log"

GC.respond_to?(:copy_on_write_friendly=) and
GC.copy_on_write_friendly = true


before_fork do |server, worker|
   old_pid = "#{server.config[:pid]}.oldbin"
   if File.exists?(old_pid) && server.pid != old_pid
      begin
         Process.kill("QUIT", File.read(old_pid).to_i)
      rescue Errno::ENOENT, Errno::ESRCH
      end
   end
end

after_fork do |server, worker|
  # reset rails cache to not share memcached
  Rails.cache.reset if Rails.cache.respond_to? :reset
  # PG errors (not for Mongo)
  ActiveRecord::Base.connection.reconnect! if (Gem.loaded_specs['mongo'].nil? && Gem.loaded_specs['mongoid'].nil?)
end

