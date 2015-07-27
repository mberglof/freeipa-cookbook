#
# Cookbook Name:: freeipa
# Recipe:: default
#
# Copyright 2014, Webhosting.coop
#
#
ipa_admin_password = node["freeipa"]["ipa_admin_password"]
hostname = node["freeipa"]["hostname"] 
domain = node["freeipa"]["domain"] 
dir_manager_password = node["freeipa"]["dir_manager_password"] 
realm_name = node["freeipa"]["realm_name"]

if platform?("centos")
  ipa_package = "ipa-server"
elsif platform?("fedora")
  ipa_package = "freeipa-server"
end

hostsfile_entry "127.0.0.1" do
  hostname    "localhost"
  aliases     ['localhost.localdomain']
  comment     'added by freeipa recipe'
  retries     3
  retry_delay 15
  action      :create
end

hostsfile_entry node['ipaddress'] do
    hostname  node["freeipa"]["hostname"]
    comment   'added by freeipa recipe'
    retries 3
    retry_delay 15
    action    :append
end

package "selinux-policy" do
  retries 3
  timeout 1800
  retry_delay 10
  action [:upgrade]
end

package "#{ipa_package}" do
  retries 3
  timeout 1800
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
