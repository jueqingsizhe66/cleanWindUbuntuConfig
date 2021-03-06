![VIM](https://dnp4pehkvoo6n.cloudfront.net/43c5af597bd5c1a64eb1829f011c208f/as/Ultimate%20Vimrc.svg)

## funny

## Theory
```
#!/bin/bash

cd $(dirname $BASH_SOURCE)
BASE=$(pwd)

export GIT_SSL_NO_VERIFY=true
mkdir -p ~/.vim/autoload
curl --insecure -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim

```

`vim +PlugInstall +qall`
## Application

1. rainbow_paratheses的好处是让括号好看些
2. 更快的ctrlp配置`F2`,`F1`和`,o`的bufferexplorer命令一样
3. 增加了nerdcomment方便注释`(,cc)`, 替换掉vim-commentary
4. Comfortable-motion也是挺有用的`<C-f><C-d><C-u><C-b>`
5. 增加我的`,a 搜索光标下单词 和<space>/打开Ag`,`,cad`调用calendar,然后写wiki,`,wi`写日记也是可以的,`[[#]]`在#之后可以使用`Ctrl-X Ctrl-o`会弹出一个列表
    不忍放弃vim的一个原因，很方便; 摁下`+`表示增加header，`-`表示较少header
6. `C:\Users\yzl`的.NERDTreeBookmarks nerdtree的`:Bookmark`对应的文件夹名名字,`_vim_mru_files`保存着最近访问的文件,`_vimtags`保存着所有tag相关的记录.
7. `C-s`变成加入光标, `Alt-S`变成添加符合全部单词下的光标,`ESC`推出MC(multiple cursors)模式
[[#pringout]]
8. `gf` open file under cursor,如果是路径的话(配合上vimwiki).
9. easymotion的<leader>j和k可以正常于运行
10. 添加了TODO,FIXME等关键字的高亮，`F7` 添加TODO(yzl),`,g`调用`:ACK` 然后写上TODO就可以过滤项目中所有具有TODO字段的行了(习惯性地添加TODO,FIXME,BUG等) [TODO高亮](https://www.jb51.net/article/115922.htm)
11. `,fu`查看当前代码文件的所有函数  `,fU`跳转到指定函数中
12.  `F8`添加so what 总结性声明.
13. 编写perl文件常用命令，读取文件`\ii`,输出文件`\io`,while循环`\sw`,for循环`\sfe`, 另外你不能忘记的三个数据结构,标量`\id`,数组`\ia`,字典`\ih`
14. Interesting,不妨试试! `,z`打开goyo界面，很好看
15. 先设置一个mark`mA`,然后由于大写字母支持文件间跳转，于是`~A`也是可以跳转到先前的位置 很方便
16. 修改了vimwiki配置到vim_runtime.
17. 搞清楚[ vim-snipmate ][3]和[ vim-snippets ][2]的关系
不断去学习[ vim-snippets ][2], [vim-snipmate设计理念][4]
18. vim-mark `,m`对单词着色，`,n`取消单词着色,`,r`按照正则表达式着色

### important hierarchy file structure

#### .vimrc, become very simple!

```

#!/bin/sh

set runtimepath+=~/.vim

source ~/.vim/yzl/cleanPlug.vim
source ~/.vim/yzl/cleanWind.vim
```

####  cleanWind.vim, become very modular

```


let mapleader=","


colorscheme srcery


""""""""""""""""""""""""""""""""Startify"""""""""""""""""""""""
source ~/.vim/yzl/config/config-startify.vim
"""""""""""""""""""""""""""""""Textobj"""""""""""""""""""""""""""""""""
source ~/.vim/yzl/config/config-textobj.vim

""""""""""""""""""""""""""""""""""Easy motion""""""""""""""""""""""""""""""""""
source ~/.vim/yzl/config/config-easymotion.vim

""""""""""""""""""""""""""""" Goyo """""""""""""""""""""""""""""
source ~/.vim/yzl/config/config-goyo.vim

""""""""""""""""""""""""""""""""" Ctrlp """"""""""""""""""""""""""""""""
"" ctrlp  ag  /"

source ~/.vim/yzl/config/config-ctrlp.vim


"""""""""""""""""""""""""""""""" Window  """"""""""""""""""""""""""""""""
source ~/.vim/yzl/config/config-window.vim

""""""""""""""""""""""""""""""""" TAG """""""""""""""""""""""""""""""""
source ~/.vim/yzl/config/config-tab.vim

"""""""""""""""""""""""""""""""""""""""""""""""
source ~/.vim/yzl/config/config-rainbow-parenthese.vim
"""""""""""""""""""""""""""""""""""""""""""""""
""" for unite
""""""""""""""""""""""""""" Unite """"""""""""""""""""
source ~/.vim/yzl/config/config-unite.vim


"""""""""""""""""""""""""" Vimwiki  """"""""""""""""""""""""""
source ~/.vim/yzl/config/config-vimwiki.vim

""""""""""""""""""""""""""  My self """""""""""""""""""""""
source ~/.vim/yzl/config/config-myself.vim


"""""""""""""""""""""""""" Basic setting """"""""""""""""""""""""""
source ~/.vim/yzl/config/config-set.vim
source ~/.vim/yzl/config/config-filetype.vim
source ~/.vim/yzl/config/config-xdate.vim
source ~/.vim/yzl/config/config-status.vim
"""""""""""""""""""""""""""""""" Xdate """"""""""""""""""""""""""""""""""""

set nocompatible
filetype plugin on
syntax on
filetype indent on



```

#### Tmux

Good window folding tools, try to learn and use it


The best feature for tmux: [ write code and run code in the same panel ][5].
Panel tag operation:

`Ctrl+b %`  horizontal into two windows
`Ctrl+b ""`  vertical into two windows
`Ctrl+b <-`  left cursor into panel
`Ctrl+b ->`  right cursor into panel
`Ctrl+b ^`  up cursor into panel
`Ctrl+b o ` change to other panel

Window operation:
`Ctrl+b s`

`Ctrl+b c` new tmux session
`Ctrl+b n` next session
`Ctrl+b p` before session

Exit tmux

`Ctrl+b d` exit tmux

[Tmux config files][6]

```
# base
set -g default-terminal "screen"
set -g display-time 3000
set -g history-limit 65535

# the default panel split with " and %,  hard to remember,use - and | instead
unbind '"'
bind - splitw -v 
unbind %
bind | splitw -h 

# select splited panel
bind k selectp -U 
bind j selectp -D 
bind h selectp -L 
bind l selectp -R 

# adjust window size
bind ^k resizep -U 10
bind ^j resizep -D 10
bind ^h resizep -L 10
bind ^l resizep -R 10

# swap windows
bind ^u swapp -U
bind ^d swapp -D

bind ^a last
bind q killp

bind '~' splitw htop
bind ! splitw ncmpcpp
bind m command-prompt "splitw -h 'exec man %%'"
unbind s


# staus customization

set -g status-left "#[fg=white,bg=blue] > #I < #[default] |" # 0:bash 
#set -g status-left "#[fg=white,bg=blue] > #I < #[default] |" # session-name 
set -g status-right "#[fg=yellow,bright][ #[fg=cyan]#W #[fg=yellow]]#[default] #[fg=yellow,bright]- %Y.%m.%d #[fg=green]%H:%M #[default]" 
set -g status-right-attr bright 
set -g status-bg black 
set -g status-fg white 
set -g set-clipboard on 

setw -g window-status-current-attr bright 
#setw -g window-status-current-bg red 
setw -g window-status-current-bg green 
setw -g window-status-current-fg white 
#set -g status-utf8 on 
set -g status-interval 1 
#set -g visual-activity on 
#setw -g monitor-activity on 
set -g status-keys vi 
#---------------------------------------------- 
setw -g mode-keys vi 
#setw -g mode-mouse on 
#setw -g mouse-resize-pane on 
#setw -g mouse-select-pane on 
#setw -g mouse-select-window on 
# move x clipboard into tmux paste buffer 
bind C-p run "tmux set-buffer \"$(xclip -o -sel clipbaord)\"; tmux paste-buffer" 
# move tmux copy buffer into x clipboard 
bind C-y run "tmux show-buffer | xclip -i -sel clipbaord" 

```

#### FZF and FZF.vim

fzf your things!

good work ,fzf!

insert mode, use `Ctrl-x Ctrl+f` to insert file path, use `Ctrl+x ctrl+j` to insert file name
use `c-x c-k` to finish your word, use `C-x c-l` to finish one line.

--------------------

![Vim-features][1]

#### Install RBF

前提条件:
``` java
apt-get install python-tk
pip3 install cython
pip3 install sympy
pip3 install rtree

apt-get install libspatialindex-c5

```

安装步骤
1. `git clone https://github.com/treverhines/RBF `
2. `cd RBF; python3 setup.py install`

测试与否无所谓，只要能运行RBF文件夹下README.md的三个程序即可。

# The Ultimate vimrc

Over the last 10 years, I have used and tweaked Vim. This configuration is the ultimate vimrc (or at least my version of it).

There are two versions:

* **The Basic**: If you want something small just copy [basic.vim](https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim) into your ~/.vimrc and you will have a good basic setup
* **The Awesome**: Includes a ton of useful plugins, color schemes, and configurations

I would, of course, recommend using the awesome version.


## How to install the Awesome version?
### Install for your own user only
The awesome version includes a lot of great plugins, configurations and color schemes that make Vim a lot better. To install it simply do following from your terminal:

	git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
	sh ~/.vim_runtime/install_awesome_vimrc.sh
	
### Install for multiple users
To install for multiple users, the repository needs to be cloned to a location accessible for all the intended users.

	git clone --depth=1 https://github.com/amix/vimrc.git /opt/vim_runtime
	sh ~/.vim_runtime/install_awesome_parameterized.sh /opt/vim_runtime user0 user1 user2
	# to install for all users with home directories
	sh ~/.vim_runtime/install_awesome_parameterized.sh /opt/vim_runtime --all
	
Naturally, `/opt/vim_runtime` can be any directory, as long as all the users specified have read access.

## Fonts

I recommend using [IBM Plex Mono font](https://github.com/IBM/plex) (it's an open-source and awesome font that can make your code beautiful). The Awesome vimrc is already setup to try to use it.

Some other fonts that Awesome will try to use:

* [Hack](http://sourcefoundry.org/hack/)
* [Source Code Pro](https://adobe-fonts.github.io/source-code-pro/)

## How to install the Basic version?

The basic version is just one file and no plugins. Just copy [basic.vim](https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim) and paste it into your vimrc.

The basic version is useful to install on remote servers where you don't need many plugins, and you don't do many edits.

	git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
	sh ~/.vim_runtime/install_basic_vimrc.sh


## How to install on Windows?

Use [gitforwindows](http://gitforwindows.org/) to checkout the repository and run the installation instructions above. No special instructions needed ;-)


## How to install on Linux

If you have vim aliased as `vi` instead of `vim`, make sure to either alias it: `alias vi=vim`. Otherwise, `apt-get install vim`


## How to update to latest version?

Just do a git rebase!

    cd ~/.vim_runtime
    git pull --rebase


## Some screenshots

Colors when editing a Python file:

![Screenshot 1](https://dnp4pehkvoo6n.cloudfront.net/07583008e4da885801657e8781777844/as/Python%20editing.png)

Opening recently opened files with the [mru.vim](https://github.com/vim-scripts/mru.vim) plugin:

![Screenshot 2](https://dnp4pehkvoo6n.cloudfront.net/1d49a88f9bd5d013c025bb1e1272a7d8/as/MRU%20plugin.png)

[NERD Tree](https://github.com/scrooloose/nerdtree) plugin in a terminal window:
![Screenshot 3](https://dnp4pehkvoo6n.cloudfront.net/ae719203166585d64728f28398f4b1b7/as/Terminal%20usage.png)

Distraction free mode using [goyo.vim](https://github.com/junegunn/goyo.vim) and [vim-zenroom2](https://github.com/amix/vim-zenroom2):
![Screenshot 4](https://dnp4pehkvoo6n.cloudfront.net/f0dcc4c9739148c56cbf8285a910ac41/as/Zen%20mode.png)


## Included Plugins

I recommend reading the docs of these plugins to understand them better. Each plugin provides a much better Vim experience!

* [ack.vim](https://github.com/mileszs/ack.vim): Vim plugin for `the_silver_searcher` (ag) or ack -- a wicked fast grep
* [bufexplorer.zip](https://github.com/vim-scripts/bufexplorer.zip): Quickly and easily switch between buffers. This plugin can be opened with `<leader+o>`
* [ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim): Fuzzy file, buffer, mru and tag finder. It's mapped to `<Ctrl+F>`, 修正ctrl+F，和comfortable-motion重合
* [goyo.vim](https://github.com/junegunn/goyo.vim) and [vim-zenroom2](https://github.com/amix/vim-zenroom2): 
* [lightline.vim](https://github.com/itchyny/lightline.vim): A light and configurable statusline/tabline for Vim
* [NERD Tree](https://github.com/scrooloose/nerdtree): A tree explorer plugin for vim
* [mru.vim](https://github.com/vim-scripts/mru.vim): Plugin to manage Most Recently Used (MRU) files. This plugin can be opened with `<leader+f>` 删掉他，ctrlp已经集成了MRU功能，多余
* [open_file_under_cursor.vim](https://github.com/amix/open_file_under_cursor.vim): Open file under cursor when pressing `gf`
* [pathogen.vim](https://github.com/tpope/vim-pathogen): Manage your vim runtimepath 
* [snipmate.vim](https://github.com/garbas/vim-snipmate): snipmate.vim aims to be a concise vim script that implements some of TextMate's snippets features in Vim,vim-snipmate default [snippets][2] (Previously snipmate-snippets) 
    也就是说vim-snipmate回去读取vim-snippets项目的snippets.
* [ale](https://github.com/w0rp/ale): Syntax and lint checking for vim (async)
* [vim-commentary](https://github.com/tpope/vim-commentary): Comment stuff out.  Use `gcc` to comment out a line (takes a count), `gc` to comment out the target of a motion. `gcu` uncomments a set of adjacent commented lines.(使用nerdcommenter替换他!!!!!)
* [vim-expand-region](https://github.com/terryma/vim-expand-region): Allows you to visually select increasingly larger regions of text using the same key combination
* [vim-fugitive](https://github.com/tpope/vim-fugitive): A Git wrapper so awesome, it should be illegal
* [vim-indent-object](https://github.com/michaeljsmith/vim-indent-object): Defines a new text object representing lines of code at the same indent level. Useful for python/vim scripts
* [vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors): Sublime Text style multiple selections for Vim, CTRL+N is remapped to CTRL+S (due to YankRing)
* [vim-yankstack](https://github.com/maxbrunsfeld/vim-yankstack): Maintains a history of previous yanks, changes and deletes
* [vim-zenroom2](https://github.com/amix/vim-zenroom2) Remove all clutter and focus only on the essential. Similar to iA Writer or Write Room


## Included color schemes

* [peaksea](https://github.com/vim-scripts/peaksea): The default
* [vim-colors-solarized](https://github.com/altercation/vim-colors-solarized)
* [vim-irblack](https://github.com/wgibbs/vim-irblack)
* [mayansmoke](https://github.com/vim-scripts/mayansmoke)
* [vim-pyte](https://github.com/therubymug/vim-pyte)


## Included modes

* [vim-coffee-script](https://github.com/kchmck/vim-coffee-script)
* [vim-less](https://github.com/groenewege/vim-less)
* [vim-bundle-mako](https://github.com/sophacles/vim-bundle-mako)
* [vim-markdown](https://github.com/tpope/vim-markdown)
* [nginx.vim](https://github.com/vim-scripts/nginx.vim): Highlights configuration files for nginx
* [vim-go](https://github.com/fatih/vim-go)


## How to include your own stuff?

After you have installed the setup, you can create **~/.vim_runtime/my_configs.vim** to fill in any configurations that are important for you. For instance, my **my_configs.vim** looks like this:

	~/.vim_runtime (master)> cat my_configs.vim
	map <leader>ct :cd ~/Desktop/Todoist/todoist<cr>
	map <leader>cw :cd ~/Desktop/Wedoist/wedoist<cr> 

You can also install your plugins, for instance, via pathogen you can install [vim-rails](https://github.com/tpope/vim-rails):

	cd ~/.vim_runtime
	git clone git://github.com/tpope/vim-rails.git my_plugins/vim-rails


## Key Mappings

The [leader](http://learnvimscriptthehardway.stevelosh.com/chapters/06.html#leader) is `,`, so whenever you see `<leader>` it means `,`.


### Plugin related mappings

Open [bufexplorer](https://github.com/vim-scripts/bufexplorer.zip) to see and manage the current buffers (`<leader>o`):
    
    map <leader>o :BufExplorer<cr>

Open [MRU.vim](https://github.com/vim-scripts/mru.vim) to see the recently open files (`<leader>f`):

    map <leader>f :MRU<CR>

Open [ctrlp.vim](https://github.com/kien/ctrlp.vim) plugin to quickly find a file or a buffer (`<leader>j` or `<ctrl>f`):
    
    let g:ctrlp_map = '<c-f>'

[NERD Tree](https://github.com/scrooloose/nerdtree) mappings:

    map <leader>nn :NERDTreeToggle<cr>
    map <leader>nb :NERDTreeFromBookmark 
    map <leader>nf :NERDTreeFind<cr>

[goyo.vim](https://github.com/junegunn/goyo.vim) and [vim-zenroom2](https://github.com/amix/vim-zenroom2) lets you only focus on one thing at a time. It removes all the distractions and centers the content. It has a special look when editing Markdown, reStructuredText and textfiles. It only has one mapping. (`<leader>z`)

    map <leader>z :Goyo<cr>


### Normal mode mappings

Fast saving of a buffer (`<leader>w`):

	nmap <leader>w :w!<cr>
	
Map `<Space>` to `/` (search) and `<Ctrl>+<Space>` to `?` (backwards search):
	
	map <space> /
	map <c-space> ?
	map <silent> <leader><cr> :noh<cr>

Disable highlights when you press `<leader><cr>`:
	
	map <silent> <leader><cr> :noh<cr>

Smart way to move between windows (`<ctrl>j` etc.):
	
	map <C-j> <C-W>j
	map <C-k> <C-W>k
	map <C-h> <C-W>h
	map <C-l> <C-W>l

Closing of the current buffer(s) (`<leader>bd` and (`<leader>ba`)):
	
	" Close current buffer
	map <leader>bd :Bclose<cr>
	
	" Close all buffers
	map <leader>ba :1,1000 bd!<cr>
	
Useful mappings for managing tabs:
	
	map <leader>tn :tabnew<cr>
	map <leader>to :tabonly<cr>
	map <leader>tc :tabclose<cr>
	map <leader>tm :tabmove 
	
	" Opens a new tab with the current buffer's path
	" Super useful when editing files in the same directory
	map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
	
Switch [CWD](http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file) to the directory of the open buffer:
	
	map <leader>cd :cd %:p:h<cr>:pwd<cr>
	
Open `ack.vim` for fast search:
	
	map <leader>g :Ack 

Quickly open a buffer for scripbble:
	
	map <leader>q :e ~/buffer<cr>

Toggle paste mode on and off:
	
	map <leader>pp :setlocal paste!<cr>


### Visual mode mappings

Visual mode pressing `*` or `#` searches for the current selection:

	vnoremap <silent> * :call VisualSelection('f')<CR>
	vnoremap <silent> # :call VisualSelection('b')<CR>

When you press gv you `Ack.vim` after the selected text:

	vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

When you press `<leader>r` you can search and replace the selected text:

	vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

Surround the visual selection in parenthesis/brackets/etc.:

    vnoremap $1 <esc>`>a)<esc>`<i(<esc>
    vnoremap $2 <esc>`>a]<esc>`<i[<esc>
    vnoremap $3 <esc>`>a}<esc>`<i{<esc>
    vnoremap $$ <esc>`>a"<esc>`<i"<esc>
    vnoremap $q <esc>`>a'<esc>`<i'<esc>
    vnoremap $e <esc>`>a"<esc>`<i"<esc>


### Insert mode mappings

Quickly insert parenthesis/brackets/etc.:

    inoremap $1 ()<esc>i
    inoremap $2 []<esc>i
    inoremap $3 {}<esc>i
    inoremap $4 {<esc>o}<esc>O
    inoremap $q ''<esc>i
    inoremap $e ""<esc>i
    inoremap $t <><esc>i

Insert the current date and time (useful for timestamps):

    iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


### Command line mappings

$q is super useful when browsing on the command line. It deletes everything until the last slash:

    cno $q <C-\>eDeleteTillSlash()<cr>

Bash like keys for the command line:

    cnoremap <C-A>		<Home>
    cnoremap <C-E>		<End>
    cnoremap <C-K>		<C-U>

    cnoremap <C-P> <Up>
    cnoremap <C-N> <Down>

Write the file as sudo (works only on Unix). Super useful when you open a file and you don't have permissions to save your changes. [Vim tip](http://vim.wikia.com/wiki/Su-write):

    :W 


### Spell checking
Pressing `<leader>ss` will toggle spell checking:

    map <leader>ss :setlocal spell!<cr>

Shortcuts using `<leader>` instead of special characters:

    map <leader>sn ]s
    map <leader>sp [s
    map <leader>sa zg
    map <leader>s? z=


### Cope
Query `:help cope` if you are unsure what cope is. It's super useful!

When you search with `Ack.vim`, display your results in cope by doing:
`<leader>cc`

To go to the next search result do:
`<leader>n`

To go to the previous search results do:
`<leader>p`

Cope mappings:

    map <leader>cc :botright cope<cr>
    map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
    map <leader>n :cn<cr>
    map <leader>p :cp<cr>


## How to uninstall
Just do following:
* Remove `~/.vim_runtime`
* Remove any lines that reference `.vim_runtime` in your `~/.vimrc`

[1]: https://github.com/jueqingsizhe66/windowVimFaster/tree/develop/img/vimFeatures.png
[2]:https://github.com/honza/vim-snippets 
[3]:https://github.com/garbas/vim-snipmate 
[4]:http://vim-wiki.mawercer.de/wiki/topic/text-snippets-skeletons-templates.html 
[5]:https://www.cnblogs.com/maoxiaolv/p/5526602.html 
[6]:https://blog.csdn.net/gatieme/article/details/49301037 
