node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping rails::precomplie application #{application} as it is not an Rails app")
    next
  end

  rails_env = deploy[:rails_env]
  environment_variables  = deploy[:environment_variables].merge(rails_env: rails_env)
  current_path = deploy[:current_path]

  Chef::Log.info("Precompiling Rails assets with environment #{rails_env}")

  execute 'rake assets:precompile' do
    cwd current_path
    user 'deploy'
    command 'bundle exec rake assets:precompile'
    environment environment_variables
  end
end
