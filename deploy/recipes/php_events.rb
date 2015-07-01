#
# Cookbook Name:: deploy
# Recipe:: php_events 
#

node[:deploy].each do |application, deploy|
  templates_dir = "#{deploy[:deploy_to]}/current/smarty/templates_c"
  execute "chmod 777 #{templates_dir}" do
  end
end
