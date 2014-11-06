#
# Cookbook Name:: freeipa
# Recipe:: default
#
# Copyright 2014, Webhosting.coop
#
#
ipa_admin_password = node.default["freeipa"]["ipa_admin_password"]
hostname = node.default["freeipa"]["hostname"] 
domain = node.default["freeipa"]["domain"] 
dir_manager_password = node.default["freeipa"]["dir_manager_password"] 
realm_name = node.default["freeipa"]["realm_name"]

hostsfile_entry node['ipaddress'] do
    hostname  node.default["freeipa"]["hostname"]
    comment   'added by freeipa recipe'
    action    :append
end
package "freeipa-server" do
  retries 3
  retry_delay 10
  action [:install]
end

script "install freeipa" do
  interpreter "bash"
  user "root"
  group "root"
  cwd "/tmp"
  code <<-EOH
  ipa-server-install -U --no-host-dns -a #{ipa_admin_password} --hostname=#{hostname} -n #{domain} -p #{dir_manager_password} -r #{realm_name}
  EOH
end
