vim-reveal
==========

vim plugin that use markdown and reveal.js to generate presentations.

### Installation

* Whatever the package managing plugin you are using.
* Download or clone [reveal.js](https://github.com/hakimel/reveal.js/) somewhere.
* Configuration

### Vim configuration

```vim
let g:reveal_root_path = 'your-reveal.js-path' " '$HOME/reveal.js/' will be used if not specified.
let g:reveal_config = {
    \'filename': 'reveal',                       " The name of generated html file will be 'reveal.html'
    \'key1': 'value1',
    \'key2': 'value2',
    \ ...}                                     " Default options for reveal.js.
```
If no filename is given, the given title will be ascii-fied and used as filename. That's nicer than setting a global option.

Note: `/` needs to be escaped in your `.vimrc` as `\/`

### Syntax

Besides default markdown syntax, you need something else to specify the sections each of which will take care of a single
page in the final presentation.
And you need something to customize the reveal.js options.

```
<!--Meta key1:value1 key2:value2 [...]--> // Options,these lines should be in the head of the file.

// The start of a markdown section.
<!--sec 1-->
// Secp means plain html section.In other words,markdown syntax is ignored(mainly for [MathJax](https://github.com/mathjax/mathjax)).
<!--secp 2.1-->
// The number after the decimal point means that this is a nested section.
<!--sec 2.2-->
// Section options.'bg' : 'background', 'tr' : 'transition', 'bgtr' : 'background-transition', 'bgrp' : 'background-repeat', 'bgsz' : 'background-size'.
<!--sec 3 bg='#123' tr='cube' bgtr='linear'-->
```

### Generate the html file

Use the `:RevealIt` command to generate the html file.

It accepts several options:
* `:RevealIt default` open generated file (same as `:RevealIt`)
* `:RevealIt new` open generated file in new window
* `:RevealIt md` stay in markdown file

### Advanced Configuration

#### Change Presentation Output Directory Name

By default `vim-reveal` saves your presentation in the reveal.js directory
in a directory called `presentations`.  This directory can be changed
using the following configuration:


```
let g:reveal_config = {
    \'outputPathDirname': 'newPresentationDirectoryName'
    }
```

Setting `outputPathDirname` to `''` will cause the presentation to be
output to the reveal.js directory.  If you do this, you will need to modify the `revealWebPath` as is described below.

#### Change the reveal.js Relative Location

In some cases, moving your presentation output directory will require the
output to be updated with a new relative path.  By default, `vim-reveal`
assumes your presentation is stored in a subdirectory of the reveal.js
code directory and therefore uses a relative path of `..` for accessing
things like css files.

If you move the directory, you can adjust the relative path using the
`relativeWebPath` configuration as shown below:

```
let g:reveal_config = {
    \'outputPathDirname': 'presentations\/preso1\/',
    \'relativeWebPath': '..\/..\/'
    }
```

#### Storing reveal.js in a Subdirectory

Some users may wish to have their presentation folders structured
as follows:

```
Arbitrary Path on Disk
                     ├── presentation.html
                     ├── presentation.md
                     └── reveal.js
                         ├── All of reveal.js
```

This can be accomplished with this configuration.

In `.vimrc`
```
let g:reveal_config = {
            \'outputPathDirname': '',
            \'revealWebPath': 'reveal.js\/',
            \'path': ''}
```

`outputPathDirname` sets the presentation output directory to same
directory as the root path used by `vim-reveal`.

`revealWebPath` sets the relative path for the reveal.js files to the
reveal.js subdirectory.  Notice the trailing slash and how it is escaped.

`path` sets the root path to be used by `vim-reveal` to nothing which
is interpreted as the current working directory in the code.
