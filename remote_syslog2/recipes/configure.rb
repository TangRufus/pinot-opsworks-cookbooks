file node['remote_syslog2']['config_file'] do
  # Convert attribute classes to plain old ruby objects
  config = node['remote_syslog2']['config'] ? node['remote_syslog2']['config'].to_hash : {}
  config.each do |k, v|
    case v
    when Chef::Node::ImmutableArray
      config[k] = v.to_a
    when Chef::Node::ImmutableMash
      config[k] = v.to_hash
    end
  end

  content YAML::dump(config)
  mode '0644'
  notifies :restart, 'service[remote_syslog2]', :delayed
end
