#
# Cookbook Name:: gogs
# Recipe:: default
#
# Copyright 2015 Eddie Hurtig
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe 'apt'

include_recipe 'chef-sugar'

include_recipe 'supervisord'

os = 'linux' if linux?
os = 'darwin' if osx?
os = 'windows' if windows?

fail 'Platform Distribution of gogs could not be determined' if os.empty?

directory node['gogs']['install_dir']

package 'unzip'
package 'git'

[
  "#{node['gogs']['install_dir']}/gogs/custom/conf",
  node['gogs']['config']['repository']['ROOT']
].each do |dir|
  directory dir do
    owner node['gogs']['config']['global']['RUN_USER']
    group node['gogs']['config']['global']['RUN_USER']
    mode '0755'
    action :create
    recursive true
  end
end

user node['gogs']['config']['global']['RUN_USER'] do
  action :create
  comment 'Gogs User'
  home "/home/#{node['gogs']['config']['global']['RUN_USER']}"
  supports manage_home: true
end

ark 'gogs' do
  path node['gogs']['install_dir']
  url "https://github.com/gogits/gogs/releases/download/v#{node['gogs']['version']}/#{os}_amd64.zip"
  action :put
end

template "#{node['gogs']['install_dir']}/gogs/custom/conf/app.ini" do
  source 'app.ini.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables config: JSON.parse(node['gogs']['config'].to_json)
end

supervisord_program 'gogs' do
  command "#{node['gogs']['install_dir']}/gogs/gogs web"
  autorestart true
  startretries 10
  user node['gogs']['config']['global']['RUN_USER']
  stderr_logfile "#{node['gogs']['install_dir']}/gogs/supervisord_gogs.err.log"
  stdout_logfile "#{node['gogs']['install_dir']}/gogs/supervisord_gogs.out.log"
  action [:supervise, :start]
end
