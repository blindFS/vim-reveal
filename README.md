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

