#
# Cookbook Name:: freeipa
# Recipe:: default
#
# Copyright 2014, Webhosting.coop
#
#
package "freeipa-server" do
  action [:install]
end

script "install freeipa" do
  interpreter "bash"
  user "root"
  group "root"
  cwd node[:project][:project_path]
  code <<-EOH
  ipa-server-install
  EOH
end
