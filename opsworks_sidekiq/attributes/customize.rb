node[:deploy].each do |application, deploy|
  override[:sidekiq][application.intern]['worker']['config']['logfile'] = "#{deploy[:deploy_to]}/shared/config/log/sidekiq_worker.log"
end
