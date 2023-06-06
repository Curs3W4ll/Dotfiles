# Dotfiles

Hey you, what's up? :wave:

If you are here, you probably want to check my configuration for one of the tools I use (zsh, neovim...). :computer:  
Here are some things you should know before diving in. :bath:

First, you should know this repository comes from [Github](https://github.com/Curs3W4ll/Dotfiles) :octocat:, if you are already on Github jump to the next paragraph. 
The GitHub repository provides more features and links (wiki...) so it is recommended to see [this repository on Github](https://github.com/Curs3W4ll/Dotfiles).

I manage my dotfiles using [chezmoi](https://www.chezmoi.io/). :house:  
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

I'm maintaining these configurations (except for the old Neovim vimscript one), so you can [report bugs](todo) and [see what I plan to do](todo) (help is welcomed :love_letter:). <!-- TODO: Add correct links -->

## What's in this?

In this Dotfiles repository, you will find configurations I use, for instance:
- Neovim configuration ([vimscript](todo) (old, not maintained) and [lua](todo)) <!-- TODO: Add link to file/folder -->
- [Terminator configuration](todo) <!-- TODO: Add link to file/folder -->
- [Zsh configuration](todo) <!-- TODO: Add link to file/folder -->

You will also find some documentation about common topics [in the wiki](todo). <!-- TODO: Add correct link -->

### Installers per configuration

To help you install only the configurations you want, you can use the following commands:

<details>
<summary>Neovim</summary>

#### Neovim

Execute the following command to install my Neovim configuration (Lua version).  
See [configuration details](todo). <!-- TODO: Add correct link -->
```sh
sh -c 'rm -f /tmp/nvimLuaInstaller.sh && curl -H "Cache-Control: no-cache, no-store" -fLo /tmp/nvimLuaInstaller.sh --create-dirs "https://raw.githubusercontent.com/Curs3W4ll/Dotfiles/master/installers/nvim_lua.sh" && chmod +x /tmp/nvimLuaInstaller.sh && /tmp/./nvimLuaInstaller.sh'
```

##### Old Vimscript version

If you want to install the older version of my Neovim configuration (using Vimscript), execute the following command.  
See [configuration details](todo). <!-- TODO: Add correct link -->

**:warning: This configuration is not maintained anymore, use it at your own risk**
```sh
sh -c 'rm -f /tmp/nvimVSInstaller.sh && curl -H "Cache-Control: no-cache, no-store" -fLo /tmp/nvimVSInstaller.sh --create-dirs "https://raw.githubusercontent.com/Curs3W4ll/Dotfiles/master/installers/nvim_lua.sh" && chmod +x /tmp/nvimVSInstaller.sh && /tmp/./nvimVSInstaller.sh'
```

</details>

<details>
<summary>Terminator</summary>

#### Terminator

Execute the following command to install my Terminator configuration.  
See [configuration details](todo). <!-- TODO: Add correct link -->
```sh
sh -c 'rm -f /tmp/terminatorInstaller.sh && curl -H "Cache-Control: no-cache, no-store" -fLo /tmp/terminatorInstaller.sh --create-dirs "https://raw.githubusercontent.com/Curs3W4ll/Dotfiles/master/installers/terminator.sh" && chmod +x /tmp/terminatorInstaller.sh && /tmp/./terminatorInstaller.sh'
```

</details>

<details>
<summary>ZSH</summary>

#### ZSH

Execute the following command to install my ZSH configuration.  
See [configuration details](todo). <!-- TODO: Add correct link -->
```sh
sh -c 'rm -f /tmp/zshInstaller.sh && curl -H "Cache-Control: no-cache, no-store" -fLo /tmp/zshInstaller.sh --create-dirs "https://raw.githubusercontent.com/Curs3W4ll/Dotfiles/master/installers/zsh.sh" && chmod +x /tmp/zshInstaller.sh && /tmp/./zshInstaller.sh'
```

</details>
