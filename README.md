# gogs

[![Build Status](https://travis-ci.org/edhurtig/chef-gogs.svg)](https://travis-ci.org/edhurtig/chef-gogs)

Installs gogs (Go Git Service).  Which is essantailly a free self hosted Github.

Gogs will listen on port 3000.  Configuration file management through this cookbook is on the way

# Requirements

* `apt` cookbook
* `systemd` cookbook
* `ark` cookbook
* `chef-sugar` cookbook


# Recipes

## default

Short Description

1. Set up & updates apt using `apt::default`
2. Installs Git and Supervisord
3. Downloads and installs gogs from Github


# Usage

Include this recipe in a wrapper cookbook:

```
depends 'gogs', '~> 1.0'
```

```
include_recipe 'gogs::default'
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests with `kitchen test`, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Author:: Eddie Hurtig (eddie@hurtigtechnologies.com)
