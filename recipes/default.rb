#
# Cookbook Name:: freeipa
# Recipe:: default
#
# Copyright 2014, Webhosting.coop
#
#
hostsfile_entry node['ipaddress'] do
    hostname  default["freeipa"]["hostname"]
    action    :create_if_missing
end
package "freeipa-server" do
  action [:install]
end

script "install freeipa" do
  interpreter "bash"
  user "root"
  group "root"
  cwd "/tmp"
  code <<-EOH
  ipa-server-install -U --no-host-dns -a default["freeipa"]["ipa_admin_password"] --hostname=default["freeipa"]["hostname"] -n default["freeipa"]["domain"] -p default["freeipa"]["dir_manager_password"] -r default["freeipa"]["realm_name"]
  EOH
end
