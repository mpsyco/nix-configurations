# Put this file in ~/.nixpkgs/config.nix
# This can be installed with nix-env -i myPackages
{

  imports = [ ./local.nix ];

  allowUnfree = true; # For dropbox

  vim.python = true;

  packageOverrides = pkgs_: with pkgs_; {

    myVim = vim_configurable.customize {
      name = "vim";

      vimrcConfig.customRC = ''
set tabstop=2
set expandtab
set shiftwidth=2
set clipboard=unnamed

" don't forget to mkdir that file
set directory=$HOME/.vim/swapfile//

set number
set relativenumber

syntax on
set bg=dark

set hidden
set hlsearch

let mapleader = " "

" windows!
map <leader>w <C-w>

iabbrev sl ls
iabbrev dc cd
iabbrev teh the
iabbrev paht path
iabbrev PAHT PATH
iabbrev lits list
iabbrev lenght length
iabbrev widht width
iabbrev height heigth

" insert date
" imap <expr> //date strftime("%Y-%m-%d")

" Type //sh or //bash to insert corresponding shebang
" nmap //sh ggO#!/usr/bin/env sh<Esc><C-o>
" nmap //bash ggO#!/usr/bin/env bash<Esc><C-o>

""" <leader>c  Bindings for c programming
" Switch between header and source files
nmap <leader>cs :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
'';

      vimrcConfig.vam = {
        knownPlugins = pkgs.vimPlugins;
        pluginDictionaries = [
          {names = [
              "Syntastic"
              "colors-solarized"
              "ctrlp"
              "rainbow_parentheses"
              "sensible"
              "vim-colorschemes"
              "vim-css-color"
              "vim-startify"
              "youcompleteme"
           ];}
        ];
      };
    };


    myPackages = with pkgs; buildEnv {
      name = "myPackages";
      paths = [
        myVim
        emacs25

        #lisp-quicklisp-2016-01-21

        # Spell-checking
        hunspell
        hunspellDicts.fr-moderne
        hunspellDicts.fr-any
        hunspellDicts.en-gb-ize
        # hunspellDicts.es-cu

        # asciinema is a tool to record (and share) terminal sessions
        asciinema
      ];
    };
  };
}
