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

