name             'gogs'
maintainer       'Eddie Hurtig'
maintainer_email 'eddie@hurtigtechnologies.com'
license          'Apache-2.0'
description      'Installs and Configures a Go Git Service Server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/EdHurtig/chef-gogs'
issues_url       'https://github.com/EdHurtig/chef-gogs/issues'
chef_version     '>= 12.0'
version          '0.1.1'

supports 'ubuntu', '>= 12.04'

depends 'chef-sugar'
depends 'ark'
depends 'apt'
depends 'supervisord', '~> 1.0.0'
