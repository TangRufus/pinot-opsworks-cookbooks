# Overwrite this in your cookbook

include_attribute 'deploy'
include_attribute 'nginx::nginx'

node[:deploy].each do |application, deploy|
  rails_logs = "#{deploy[:deploy_to]}/shared/log/*.log"
  nginx_logs = "#{node[:nginx][:log_dir].to_s}/*.log"
  newrelic_logs = '/var/log/newrelic/*.log'
  logs = node[:papertrail][:logs]

  normal['remote_syslog2']['config']['files'] = [rails_logs, nginx_logs, newrelic_logs, logs].reject(&:nil?).reject(&:empty?)
end

normal['remote_syslog2']['config']['exclude_files'] = node[:papertrail][:exclude_files].split(',')
normal['remote_syslog2']['config']['exclude_patterns'] = node[:papertrail][:exclude_patterns].split(',')
normal['remote_syslog2']['config']['hostname'] = node[:opsworks][:instance][:hostname]
normal['remote_syslog2']['config']['destination']['host'] = node[:papertrail][:host]
normal['remote_syslog2']['config']['destination']['port'] = node[:papertrail][:port].to_i
