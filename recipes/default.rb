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
  ipa-server-install -U --selfsign -a default["freeipa"]["ipa_admin_password"] --hostname=default["freeipa"]["hostname"] -n default["freeipa"]["domain"] -p default["freeipa"]["dir_manager_password"] -r default["freeipa"]["realm_name"]
  EOH
end
