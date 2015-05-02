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

ark 'gogs' do
  path node['gogs']['install_dir']
  url "https://github.com/gogits/gogs/releases/download/v#{node['gogs']['version']}/#{os}_amd64.zip"
  action :put
end

directory "#{node['gogs']['install_dir']}/gogs/custom/conf/" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  recursive true
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
  action [:supervise, :start]
end
