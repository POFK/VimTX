# VimTX

Forked from [vimplus](https://github.com/chxuan/vimplus) and customized according 
to my habits. This configuration doesn't need `sudo` authority.

## install

    bash install

## Tips

### code autocomplete

-   YouCompleteMe
-   For those code needs special C lib, run `:YcmGenerateConfig` to create 
    `/.ycm_extra_conf.py` in the root directory of this project. In this case, 
    you need the Makefile to identify C flags. (has mapped to F8).
-   You can type `F4` to see to see if any errors or warnings were detected 
    in your file, and `,ff` try to fix it.
-   `,o` go to include
-   If there are some ploblems about the fonts, see [here](https://bbs.archlinux.org/viewtopic.php?pid=1801925#p1801925).

### To Do

-   \[x] customize it
-   \[x] check the script from vimplus, remove apt-get install...
-   \[x] the usage tips for this vim configuration
-   \[x] add header for my code file

