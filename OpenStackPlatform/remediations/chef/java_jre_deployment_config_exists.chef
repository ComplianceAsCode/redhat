node.default['main']['java_root'] = "/etc/.java/deployment"

#create java root directory
directory node['main']['java_root'] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create_if_missing
end

file '/etc/.java/deployment/deployment.config' do
  mode '0644'
  owner 'root'
  group 'root'
end

