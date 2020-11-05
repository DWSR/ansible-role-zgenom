# zgenom [![Build Status](https://github.com/DWSR/ansible-role-zgenom/workflows/CI/badge.svg?branch=master)](https://github.com/DWSR/ansible-role-zgenom/actions?query=workflow%3ACI)

An Ansible role to install [zgenom](https://github.com/jandamm/zgenom) for the current user

## Requirements

### Control Node

None

### Remote Node

* `git` installed. You can use [Jeff Geerling's git role](https://galaxy.ansible.com/geerlingguy/git)
  to install it on Linux systems.

## Role Defaults

| Variable                            |   Type  |              Default Value            | Description |
|-------------------------------------|:-------:|:-------------------------------------:|-------------|
| `zgenom_path`                       | `str`   | `"{{ ansible_user_dir }}/.zgen"`      | The path to save zgenom to.
| `zgenom_branch`                     | `str`   | `"main"`                              | The branch of the zgenom repo to clone.
| `zgenom_update`                     | `bool`  | `false`                               | Whether or not to update the repository on each Ansible run.
| `zgenom_modify_zshrc`               | `bool`  | `true`                                | Whether or not to modify `.zshrc` to load zgenom.
| `zgenom_zsh_path`                   | `str`   | `"{{ ansible_user_shell }}`           | The path to `zsh`
| `zgenom_reset_zgen`                 | `bool`  | `true`                                | Whether or not to reset `init.zsh` when modifying `.zshrc`.
| `zgenom_zgen_plugins`               | `list`  | See `defaults/main.yml`               | A list of ZSH plugins to load.

## Dependencies

### Roles

None

### Collections

None

## Example Playbook

```yaml
- hosts: my-workstation
  roles:
    - zgenom
  vars:
    # Add additional plugins
    zgenom_zgen_plugins:
      - unixorn/fzf-zsh-plugin
      - zsh-users/zsh-completions
      - zsh-users/zsh-autosuggestions
      - zsh-users/zsh-syntax-highlighting
      - zsh-users/zsh-history-substring-search
      - unixorn/tumult.plugin.zsh
      - sparsick/ansible-zsh
      - chrissicool/zsh-256color
      - qoomon/zjump
```

## License

MPL-2.0

## Author Information

This role was created in 2020 by [Brandon McNama](https://github.com/dwsr).

## Development

### Dev Requirements

* Ruby `2.7` or later
* Python `3.8` or later
* Poetry `1.1` or later

This repository supports [asdf](https://asdf-vm.com) for language selection.

### Installation

`bundle install --path vendor/bundle --jobs 2 --clean && poetry install --remove-untracked`

### Running linters

`poetry run pre-commit`

### Running tests

This role uses [Test Kitchen](https://kitchen.ci) and [Inspec](https://inspec.io) for testing
instead of Molecule. This is done in order to more easily support multiple testing drivers (both
`docker` and `exec`) to ease testing on multiple operating systems.

To run tests, run `bundle exec poetry run kitchen test <suite name>`.
