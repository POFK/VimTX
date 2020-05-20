VimTX
=====

Forked from [vimplus](https://github.com/chxuan/vimplus) and customized
according to my habits. This configuration doesn't need `sudo`
authority.

install
-------

    bash install

Docker
-------
    docker pull txmao/vimtx
    docker build .  -t vimtx
    docker run -it -d --net=host --ipc=host --name vimtx txmao/vimtx:latest
    docker run -it -d -v /var/run/docker.sock:/var/run/docker.sock -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY --net=host --ipc=host -v $HOME/workspace:/home/workspace --name vimtx txmao:vimtx:latest
    docker exec  -it vimtx bash

    docker stop vimtx
    docker container rm  vimtx


Tips
----

### code autocomplete

-   YouCompleteMe
-   For those code needs special C lib, run `:YcmGenerateConfig` to
    create `/.ycm_extra_conf.py` in the root directory of this project.
    In this case, you need the Makefile to identify C flags. (has mapped
    to F8).
-   You can type `F4` to see to see if any errors or warnings were
    detected in your file, and `,ff` try to fix it.
-   `,o` go to include
-   If there are some ploblems about the fonts, see
    [here](https://bbs.archlinux.org/viewtopic.php?pid=1801925#p1801925).

### To Do

-   \[x\] customize it
-   \[x\] check the script from vimplus, remove apt-get install...
-   \[x\] the usage tips for this vim configuration
-   \[x\] add header for my code file

Plugin
------

### [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)

#### General Semantic Completion

You can use Ctrl+Space to trigger the completion suggestions anywhere,
even without a string prefix. This is useful to see which top-level
functions are available for use.

#### C-family Semantic Completion

1.  `F8`: For those code needs special C lib, run `:YcmGenerateConfig`
    (has mapped to `F8`) to create `.ycm_extra_conf.py` in the root
    directory of this project. In this case, you need a Makefile to
    identify C flags. Please restart vim after running `F8`.
2.  You can type `F4` to see to see if any errors or warnings were
    detected in your file, and `,ff` try to fix it.
3.  Notely, for python, you should

TO DO
-----

### plugin

#### YCM

-   @2019-05-18
    -   \[ \] write a note for the usage of YCM and shortcuts
    -   \[ \] python, how to configure the env to debug and find error
    -   \[ \] I have modified the vimrc and .ycm\_extra\_conf but
        without checking, check it later

插件相关
--------

    | 快捷键       | 说明                                 |
    | ------------ | ------------------------------       |
    | `,`          | Leader Key                           |
    | `<F2>`       | remove space lines                   |
    | `<F3>`       | 打开/关闭代码资源管理器              |
    | `<F4>`       | 显示语法错误提示窗口                 |
    | `<F5>`       | run files, see vimrc.local           |
    | `<F6>`       | auto format                          |
    | `<F8>`       | create .ycm_extra_conf.py file       |
    | `<F9>`       | 打开/关闭函数列表                    |
    | `<F10>`      | 启用markdown实时预览                 |
    | `<F11>`      | close markdown实时预览               |
    | `<leader>a`  | .h .cpp 文件切换                     |
    | `<leader>u`  | 转到函数声明                         |
    | `<leader>U`  | 转到函数实现                         |
    | `<leader>o`  | 打开include文件                      |
    | `<leader>y`  | 拷贝函数声明                         |
    | `<leader>p`  | 生成函数实现                         |
    | `<leader>w`  | 单词跳转                             |
    | `<leader>f`  | 搜索~目录下的文件                    |
    | `<leader>F`  | 搜索当前目录下的文本                 |
    | `<leader>g`  | 显示git仓库提交记录                  |
    | `<leader>G`  | 显示当前文件提交记录                 |
    | `<leader>gg` | 显示当前文件在某个commit下的完整内容 |
    | `<leader>ff` | 语法错误自动修复(FixIt)              |
    | `<c-p>`      | 切换到上一个buffer                   |
    | `<c-n>`      | 切换到下一个buffer                   |
    | `<leader>d`  | 删除当前buffer                       |
    | `<leader>D`  | 删除当前buffer外的所有buffer         |
    | `vim`        | 运行vim编辑器时,默认启动开始页面     |
    | `<leader>l`  | 按竖线对齐                           |
    | `<leader>=`  | 按等号对齐                           |
    | `Ya`         | 复制行文本到字母a                    |
    | `Da`         | 剪切行文本到字母a                    |
    | `Ca`         | 改写行文本到字母a                    |
    | `rr`         | 替换文本                             |
    | `<leader>r`  | 全局替换，目前只支持单个文件         |
    | `gcc`        | 注释代码                             |
    | `gcap`       | 注释段落                             |
    | `vif`        | 选中函数内容                         |
    | `dif`        | 删除函数内容                         |
    | `cif`        | 改写函数内容                         |
    | `vaf`        | 选中函数内容（包括函数名 花括号）    |
    | `daf`        | 删除函数内容（包括函数名 花括号）    |
    | `caf`        | 改写函数内容（包括函数名 花括号）    |
    | `fa`         | 查找字母a，然后再按f键查找下一个     |
    | `<c-x><c-o>` | Emoji:dog:补全                       |

\#\#LeaderF Once LeaderF is launched:

    | Command                    | Description                                                              |
    | -------------------------- | ------------------------------------------------------------------------ |
    | `<C-C>`<br>`<ESC>`         | quit from LeaderF                                                        |
    | `<C-R>`                    | switch between fuzzy search mode and regex mode                          |
    | `<C-F>`                    | switch between full path search mode and name only search mode           |
    | `<Tab>`                    | switch to normal mode                                                    |
    | `<C-V>`<br>`<S-Insert>`    | paste from clipboard                                                     |
    | `<C-U>`                    | clear the prompt                                                         |
    | `<C-J>`                    | move the cursor downward in the result window                            |
    | `<C-K>`                    | move the cursor upward in the result window                              |
    | `<Up>`/`<Down>`            | recall last/next input pattern from history                              |
    | `<2-LeftMouse>`<br>`<CR>`  | open the file under cursor or selected(when multiple files are selected) |
    | `<C-X>`                    | open in horizontal split window                                          |
    | `<C-]>`                    | open in vertical split window                                            |
    | `<C-T>`                    | open in new tabpage                                                      |
    | `<F5>`                     | refresh the cache                                                        |
    | `<C-LeftMouse>`<br>`<C-S>` | select multiple files                                                    |
    | `<S-LeftMouse>`            | select consecutive multiple files                                        |
    | `<C-A>`                    | select all files                                                         |
    | `<C-L>`                    | clear all selections                                                     |
    | `<BS>`                     | delete the preceding character in the prompt                             |
    | `<Del>`                    | delete the current character in the prompt                               |
    | `<Home>`                   | move the cursor to the begin of the prompt                               |
    | `<End>`                    | move the cursor to the end of the prompt                                 |
    | `<Left>`                   | move the cursor one character to the left in the prompt                  |
    | `<Right>`                  | move the cursor one character to the right in the prompt                 |
    | `<C-P>`                    | preview the result                                                       |

------------------------------------------------------------------------

插入模式
--------

    | 快捷键  | 说明                           |
    | ------- | ---------------                |
    | `i`     | 在光标处进入插入模式           |
    | `I`     | 在行首进入插入模式             |
    | `a`     | 在光标后进入插入模式           |
    | `A`     | 在行尾进入插入模式             |
    | `o`     | 在下一行插入新行并进入插入模式 |
    | `O`     | 在上一行插入新行并进入插入模式 |
    | `gi`    | 进入到上一次插入模式的位置     |
    | `<esc>` | 退出插入模式                   |

缓存操作
--------

    | 快捷键          | 说明               |
    | --------------- | ------------       |
    | `:e <filename>` | 新建buffer打开文件 |
    | `:bp`           | 切换到上一个buffer |
    | `:bn`           | 切换到下一个buffer |
    | `:bd`           | 删除当前buffer     |

窗口操作
--------

    | 快捷键            | 说明                   |
    | ----------------- | -----------            |
    | `:sp <filename>`  | 横向切分窗口并打开文件 |
    | `:vsp <filename>` | 竖向切分窗口并打开文件 |
    | `<c-w>h`          | 跳到左边的窗口         |
    | `<c-w>j`          | 跳到下边的窗口         |
    | `<c-w>k`          | 跳到上边的窗口         |
    | `<c-w>l`          | 跳到右边的窗口         |
    | `<c-w>c`          | 关闭当前窗口           |
    | `<c-w>o`          | 关闭其他窗口           |
    | `:only`           | 关闭其他窗口           |

光标移动
--------

    | 快捷键  | 说明                                     |
    | ------- | ---------------------                    |
    | `h`     | 上下左右移动                             |
    | `j`     | 上下左右移动                             |
    | `k`     | 上下左右移动                             |
    | `l`     | 上下左右移动                             |
    | `0`     | 光标移动到行首                           |
    | `^`     | 跳到从行首开始第一个非空白字符           |
    | `$`     | 光标移动到行尾                           |
    | `<c-o>` | 跳到上一个位置                           |
    | `<c-i>` | 跳到下一个位置                           |
    | `<c-b>` | 上一页                                   |
    | `<c-f>` | 下一页                                   |
    | `<c-u>` | 上移半屏                                 |
    | `<c-d>` | 下移半屏                                 |
    | `H`     | 调到屏幕顶上                             |
    | `M`     | 调到屏幕中间                             |
    | `L`     | 调到屏幕下方                             |
    | `:n`    | 跳到第n行                                |
    | `w`     | 跳到下一个单词开头(标点或空格分隔的单词) |
    | `W`     | 跳到下一个单词开头(空格分隔的单词)       |
    | `e`     | 跳到下一个单词尾部(标点或空格分隔的单词) |
    | `E`     | 跳到下一个单词尾部(空格分隔的单词)       |
    | `b`     | 上一个单词头(标点或空格分隔的单词)       |
    | `B`     | 上一个单词头(空格分隔的单词)             |
    | `ge`    | 上一个单词尾                             |
    | `%`     | 在配对符间移动, 可用于()、{}、\[]        |
    | `gg`    | 到文件首                                 |
    | `G`     | 到文件尾                                 |
    | `fx`    | 跳转到下一个为x的字符                    |
    | `Fx`    | 跳转到上一个为x的字符                    |
    | `tx`    | 跳转到下一个为x的字符前                  |
    | `Tx`    | 跳转到上一个为x的字符前                  |
    | `;`     | 跳到下一个搜索的结果                     |
    | `[[`    | 跳转到函数开头                           |
    | `]]`    | 跳转到函数结尾                           |

文本编辑
--------

    | 快捷键         | 说明                                                     |
    | -------------- | -------------------------------------                    |
    | `r`            | 替换当前字符                                             |
    | `R`            | 进入替换模式，直至 ESC 离开                              |
    | `s`            | 替换字符（删除光标处字符，并进入插入模式，前可接数量）   |
    | `S`            | 替换行（删除当前行，并进入插入模式，前可接数量）         |
    | `cc`           | 改写当前行（删除当前行并进入插入模式），同 S             |
    | `cw`           | 改写光标开始处的当前单词                                 |
    | `ciw`          | 改写光标所处的单词                                       |
    | `caw`          | 改写光标所处的单词，并且包括前后空格（如果有的话）       |
    | `ct,`          | 改写到逗号                                               |
    | `c0`           | 改写到行首                                               |
    | `c^`           | 改写到行首（第一个非零字符）                             |
    | `c$`           | 改写到行末                                               |
    | `C`            | 改写到行末（同 c$）                                      |
    | `ci"`          | 改写双引号中的内容                                       |
    | `ci'`          | 改写单引号中的内容                                       |
    | `ci)`          | 改写小括号中的内容                                       |
    | `ci]`          | 改写中括号中内容                                         |
    | `ci}`          | 改写大括号中内容                                         |
    | `cit`          | 改写 xml tag 中的内容                                    |
    | `cis`          | 改写当前句子                                             |
    | `ciB`          | 改写'{}'中的内容                                         |
    | `c2w`          | 改写下两个单词                                           |
    | `ct(`          | 改写到小括号前                                           |
    | `x`            | 删除当前字符，前面可以接数字，3x代表删除三个字符         |
    | `X`            | 向前删除字符                                             |
    | `dd`           | 删除当前行                                               |
    | `d0`           | 删除到行首                                               |
    | `d^`           | 删除到行首（第一个非零字符）                             |
    | `d$`           | 删除到行末                                               |
    | `D`            | 删除到行末（同 d$）                                      |
    | `dw`           | 删除当前单词                                             |
    | `dt,`          | 删除到逗号                                               |
    | `diw`          | 删除光标所处的单词                                       |
    | `daw`          | 删除光标所处的单词，并包含前后空格（如果有的话）         |
    | `di"`          | 删除双引号中的内容                                       |
    | `di'`          | 删除单引号中的内容                                       |
    | `di)`          | 删除小括号中的内容                                       |
    | `di]`          | 删除中括号中内容                                         |
    | `di}`          | 删除大括号中内容                                         |
    | `diB`          | 删除'{}'中的内容                                         |
    | `dit`          | 删除 xml tag 中的内容                                    |
    | `dis`          | 删除当前句子                                             |
    | `d2w`          | 删除下两个单词                                           |
    | `dt(`          | 删除到小括号前                                           |
    | `dgg`          | 删除到文件头部                                           |
    | `dG`           | 删除到文件尾部                                           |
    | `d}`           | 删除下一段                                               |
    | `d{`           | 删除上一段                                               |
    | `u`            | 撤销                                                     |
    | `U`            | 撤销整行操作                                             |
    | `CTRL-R`       | 撤销上一次 u 命令                                        |
    | `J`            | 连接若干行                                               |
    | `gJ`           | 连接若干行，删除空白字符                                 |
    | `.`            | 重复上一次操作                                           |
    | `~`            | 交换大小写                                               |
    | `g~iw`         | 替换当前单词的大小写                                     |
    | `gUiw`         | 将单词转成大写                                           |
    | `guiw`         | 将当前单词转成小写                                       |
    | `guu`          | 全行转为小写                                             |
    | `gUU`          | 全行转为大写                                             |
    | `gg=G`         | 缩进整个文件                                             |
    | `=a{`          | 缩进光标所在代码块                                       |
    | `=i{`          | 缩进光标所在代码块，不缩进"{"                            |
    | `<<`           | 减少缩进                                                 |
    | `>>`           | 增加缩进                                                 |
    | `==`           | 自动缩进                                                 |
    | `CTRL-A`       | 增加数字                                                 |
    | `CTRL-X`       | 减少数字                                                 |
    | `p`            | 粘贴到光标后                                             |
    | `P`            | 粘贴到光标前                                             |
    | `v`            | 开始标记                                                 |
    | `y`            | 复制标记内容                                             |
    | `V`            | 开始按行标记                                             |
    | `CTRL-V`       | 开始列标记                                               |
    | `y$`           | 复制当前位置到本行结束的内容                             |
    | `yy`           | 复制当前行                                               |
    | `Y`            | 复制当前行，同 yy                                        |
    | `yt,`          | 复制到逗号                                               |
    | `yiw`          | 复制当前单词                                             |
    | `3yy`          | 复制光标下三行内容                                       |
    | `v0`           | 选中当前位置到行首                                       |
    | `v$`           | 选中当前位置到行末                                       |
    | `vt,`          | 选中到逗号                                               |
    | `viw`          | 选中当前单词                                             |
    | `vi)`          | 选中小括号内的东西                                       |
    | `vi]`          | 选中中括号内的东西                                       |
    | `viB`          | 选中'{}'中的内容                                         |
    | `vis`          | 选中句子中的东西                                         |
    | `gv`           | 重新选择上一次选中的文字                                 |
    | `:set paste`   | 允许粘贴模式（避免粘贴时自动缩进影响格式）               |
    | `:set nopaste` | 禁止粘贴模式                                             |
    | `"?yy`         | 复制当前行到寄存器 ? ，问号代表 0-9 的寄存器名称         |
    | `"?p`          | 将寄存器 ? 的内容粘贴到光标后                            |
    | `"?P`          | 将寄存器 ? 的内容粘贴到光标前                            |
    | `:registers`   | 显示所有寄存器内容                                       |
    | `:[range]y`    | 复制范围，比如 :20,30y 是复制20到30行，:10y 是复制第十行 |
    | `:[range]d`    | 删除范围，比如 :20,30d 是删除20到30行，:10d 是删除第十行 |
    | `ddp`          | 交换两行内容：先删除当前行复制到寄存器，并粘贴           |

文件操作
--------

    | 快捷键               | 说明                                   |
    | -------------------- | -------------------                    |
    | `:w`                 | 保存文件                               |
    | `:w <filename>`      | 按名称保存文件                         |
    | `ZZ`                 | 保存文件（如果有改动的话），并关闭窗口 |
    | `:e <filename>`      | 打开文件并编辑                         |
    | `:saveas <filename>` | 另存为文件                             |
    | `:r <filename>`      | 读取文件并将内容插入到光标后           |
    | `:r !dir`            | 将dir命令的输出捕获并插入到光标后      |
    | `:close`             | 关闭文件                               |
    | `:q`                 | 退出                                   |
    | `:q!`                | 强制退出                               |
    | `:wa`                | 保存所有文件                           |
    | `:cd <path>`         | 切换Vim当前路径                        |
    | `:new`               | 打开一个新的窗口编辑新文件             |
    | `:enew`              | 在当前窗口创建新文件                   |
    | `:vnew`              | 在左右切分的新窗口中编辑新文件         |
    | `:tabnew`            | 在新的标签页中编辑新文件               |

使用外部程序
------------

    | 快捷键           | 说明                            |
    | ---------------- | -------------------             |
    | `!`              | 告诉vim正在执行一个过滤操作     |
    | `!5Gsort<Enter>` | 使用外部sort命令对1-5行文本排序 |
    | `!!`             | 对当前行执行过滤命令            |
    | `!!date<Enter>`  | 用"date"的输出代替当前行        |

宏录制
------

    | 快捷键      | 说明                        |
    | ----------- | --------------              |
    | `qa`        | 开始录制名字为a的宏         |
    | `q`         | 结束录制宏                  |
    | `@a`        | 播放名字为a的宏             |
    | `100@a`     | 播放名字为a的宏100次        |
    | `:normal@a` | 播放名字为a的宏直到自动结束 |

实用命令
--------

    | 快捷键               | 说明                                              |
    | -------------------- | --------------------------------                  |
    | `/pattern`           | 从光标处向文件尾搜索 pattern                      |
    | `?pattern`           | 从光标处向文件头搜索 pattern                      |
    | `n`                  | 向同一方向执行上一次搜索                          |
    | `N`                  | 向相反方向执行上一次搜索                          |
    | `*`                  | 向前搜索光标下的单词                              |
    | `#`                  | 向后搜索光标下的单词                              |
    | `:s/p1/p2/g`         | 替换当前行的p1为p2                                |
    | `:%s/p1/p2/g`        | 替换当前文件中的p1为p2                            |
    | `:%s/<p1>/p2/g`      | 替换当前文件中的p1单词为p2                        |
    | `:%s/p1/p2/gc`       | 替换当前文件中的p1为p2，并且每处询问你是否替换    |
    | `:10,20s/p1/p2/g`    | 将第10到20行中所有p1替换为p2                      |
    | `:%s/1\\2\/3/123/g`  | 将“1\\2/3” 替换为 “123”（特殊字符使用反斜杠标注） |
    | `:%s/\r//g`          | 删除 DOS 换行符 ^M                                |
    | `:g/^\s*$/d`         | 删除空行                                          |
    | `:g/test/d`          | 删除所有包含 test 的行                            |
    | `:v/test/d`          | 删除所有不包含 test 的行                          |
    | `:%s/^/test/`        | 在行首加入特定字符(也可以用宏录制来添加)          |
    | `:%s/$/test/`        | 在行尾加入特定字符(也可以用宏录制来添加)          |
    | `:sort`              | 排序                                              |
    | `:g/^\(.\+\)$\n\1/d` | 去除重复行(先排序)                                |
    | `:%s/^.\{10\}//`     | 删除每行前10个字符                                |
    | `:%s/.\{10\}$//`     | 删除每行尾10个字符                                |

帮助
----

    | 快捷键                 | 说明                         |
    | ---------------------- | ----------------             |
    | `h tutor`              | 入门文档                     |
    | `h quickref`           | 快速帮助                     |
    | `h index`              | 查询Vim所有键盘命令定义      |
    | `h summary`            | 帮助你更好的使用内置帮助系统 |
    | `h pattern.txt`        | 正则表达式帮助               |
    | `h eval`               | 脚本编写帮助                 |
    | `h function-list`      | 查看VimScript的函数列表      |
    | `h windows.txt`        | 窗口使用帮助                 |
    | `h tabpage.txt`        | 标签页使用帮助               |
    | `h tips`               | 查看Vim内置的常用技巧文档    |
    | `h quote`              | 寄存器                       |
    | `h autocommand-events` | 所有可能事件                 |
    | `h write-plugin`       | 编写插件                     |

其他
----

    | 快捷键                | 说明                              |
    | --------------------- | ------------------                |
    | `vim -u NONE -N`      | 开启vim时不加载vimrc文件          |
    | `vimdiff file1 file2` | 显示文件差异                      |
    | `<leader>e`           | 快速编辑vimrc文件                 |
    | `<leader>s`           | 重新加载vimrc文件                 |
    | `<leader>h`           | 打开vimplus帮助文档               |
    | `<leader>H`           | 打开当前光标所在单词的vim帮助文档 |
    | `<leader><leader>i`   | 安装插件                          |
    | `<leader><leader>u`   | 更新插件                          |
    | `<leader><leader>c`   | 删除插件                          |
