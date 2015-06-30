#
# Cookbook Name:: deploy
# Recipe:: php
#

include_recipe 'deploy'
include_recipe "mod_php5_apache2"
include_recipe "mod_php5_apache2::php"

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping deploy::php application #{application} as it is not an PHP app")
    next
  end

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end
end

node[:deploy].each do |application, deploy|
  templates_dir = "#{deploy[:deploy_to]}/current/smarty/templates_c"
  execute "chmod 777 #{templates_dir}" do
  end
end

node[:deploy].each do |application, deploy|
  brackets_dir = "#{deploy[:deploy_to]}/current/public/brackets"
  execute "chmod -R 777 #{brackets_dir}" do
  end
end



