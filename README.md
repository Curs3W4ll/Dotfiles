<div align="center">

# Dotfiles

![Latest commit](https://img.shields.io/github/last-commit/Curs3W4ll/Dotfiles?style=flat)

Personal Dotfiles. More information is in the [wiki](https://github.com/Curs3W4ll/Dotfiles/wiki)  
[Deployment](#deployment) • [Zsh](#zsh) • [Neovim](#neovim) • [Terminator](#terminator)  
[Screenshots](https://github.com/Curs3W4ll/Dotfiles/wiki/Screenshots)

</div>

Hey you, what's up? :wave:

If you are here, you probably want to check my configuration for one of the tools I use (zsh, neovim...). :computer:  
Here are some things you should know before diving in. :bath:

First, you should know this repository comes from [Github](https://github.com/Curs3W4ll/Dotfiles) :octocat:, if you are already on Github jump to the next paragraph. 
The GitHub repository provides more features and links (wiki...) so it is recommended to see [this repository on Github](https://github.com/Curs3W4ll/Dotfiles).

I manage my dotfiles using [chezmoi](https://www.chezmoi.io/). :house:  
More information in the [deployment section](#deployment).

I'm maintaining these configurations (except for the old Neovim vimscript one), so you can [report bugs](https://github.com/Curs3W4ll/Dotfiles/issues/new/choose) and [see what I plan to do](https://github.com/Curs3W4ll/Dotfiles/issues?q=is%3Aissue+is%3Aopen+label%3Acoming) (help is welcomed :love_letter:).

## Deployment

### `chezmoi`

As said before, I use `chezmoi` to manage my configuration.  
`chezmoi` is a Dotfiles manager CLI with many cool features, it can handle files, templates, secrets and more.  
If you just want to use one of my configuration without syncing all of them, do not use `chezmoi` and use [installers per configuration](#installers-per-configuration).

<details>
<summary>More information and tips for chezmoi</summary>

### How does `chezmoi` works?

`chezmoi` is just an add-on script on top of a Git repository.  
It will be linked to a Git repository and will sync your files and more using this repository.

Using `chezmoi`, you can't select the files you want to sync, but you can do this using [installers per configuration](#installers-per-configuration)

### Install `chezmoi`

```sh
sh -c "$(curl -fsLS get.chezmoi.io)"
```

See [official installation methods](https://www.chezmoi.io/install/).

### Use these dotfiles on a new machine

```sh
chezmoi init --apply Curs3W4ll
```

As `Curs3W4ll` is my username, so `chezmoi` will retrieve my `Dotfiles` repository on my account.

### Sync to the latest dotfiles version

```sh
chezmoi update
```

### See changes with the latest dotfiles version without applying any change

```sh
chezmoi git pull -- --autostash --rebase && chezmoi diff
```

And you can apply these changes using

```sh
chezmoi apply
```

</details>

### Installers per configuration

To help you install only the configurations you want, you can use the following commands:

<details>
<summary>ZSH</summary>

#### ZSH installer

Execute the following command to install my ZSH configuration.  
See [configuration details](#zsh).
```sh
sh -c 'rm -f /tmp/zshInstaller.sh && curl -H "Cache-Control: no-cache, no-store" -fLo /tmp/zshInstaller.sh --create-dirs "https://raw.githubusercontent.com/Curs3W4ll/Dotfiles/master/installers/zsh.sh" && chmod +x /tmp/zshInstaller.sh && /tmp/./zshInstaller.sh'
```

</details>

<details>
<summary>Neovim</summary>

#### Neovim installer

Execute the following command to install my Neovim configuration (Lua version).  
See [configuration details](#neovim).
```sh
sh -c 'rm -f /tmp/nvimLuaInstaller.sh && curl -H "Cache-Control: no-cache, no-store" -fLo /tmp/nvimLuaInstaller.sh --create-dirs "https://raw.githubusercontent.com/Curs3W4ll/Dotfiles/master/installers/nvim_lua.sh" && chmod +x /tmp/nvimLuaInstaller.sh && /tmp/./nvimLuaInstaller.sh'
```

##### Old Vimscript version

If you want to install the older version of my Neovim configuration (using Vimscript), execute the following command.  
See [configuration details](#neovim).

**:warning: This configuration is not maintained anymore, use it at your own risk**
```sh
sh -c 'rm -f /tmp/nvimVSInstaller.sh && curl -H "Cache-Control: no-cache, no-store" -fLo /tmp/nvimVSInstaller.sh --create-dirs "https://raw.githubusercontent.com/Curs3W4ll/Dotfiles/master/installers/nvim_lua.sh" && chmod +x /tmp/nvimVSInstaller.sh && /tmp/./nvimVSInstaller.sh'
```

</details>

<details>
<summary>Terminator</summary>

#### Terminator installer

Execute the following command to install my Terminator configuration.  
See [configuration details](#terminator).
```sh
sh -c 'rm -f /tmp/terminatorInstaller.sh && curl -H "Cache-Control: no-cache, no-store" -fLo /tmp/terminatorInstaller.sh --create-dirs "https://raw.githubusercontent.com/Curs3W4ll/Dotfiles/master/installers/terminator.sh" && chmod +x /tmp/terminatorInstaller.sh && /tmp/./terminatorInstaller.sh'
```

</details>

## What's in this?

In this Dotfiles repository, you will find configurations I use, more details below.

You will also find some documentation about common topics [in the wiki](https://github.com/Curs3W4ll/Dotfiles/wiki).

---
### ZSH

<!-- TODO: Describe more -->

[More information in the wiki](todo) <!-- TODO: Add wiki link -->

---
### Neovim

<!-- TODO: Describe more -->

[More information in the wiki](todo) <!-- TODO: Add wiki link -->

#### Old Vimscript version

[More information in the wiki](todo) <!-- TODO: Add wiki link -->

---
### Terminator

<!-- TODO: Describe more -->

[More information in the wiki](todo) <!-- TODO: Add wiki link -->
