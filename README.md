vim-reveal
==========

vim plugin that use markdown and reveal.js to generate presentations.

### Installation

* Whatever the package managing plugin you are using.
* Download or clone [reveal.js](https://github.com/hakimel/reveal.js/) somewhere.
* Configuration

### Vim configuration

```vim
let g:reveal_root_path = 'your-reveal.js-path' ; '$HOME/reveal.js/' will be used if not specified.
let g:reveal_file_name = 'name.html' ; 'test.html' will be used if not specified.
let g:reveal_default_config = {
    \'key1': 'value1'
    \'key2': 'value2'
    \ ...} ; Default options.
```

### Syntax

Besides default markdown syntax,you need something else to specify the sections each of which will take care of a single
page in the final presentation.
And you need something to customize the reveal.js options.

```
// The start of a markdown section.
<!--sec 1-->
// Secp means plain html section.In other words,markdown syntax is ignored(mainly for [MathJax](https://github.com/mathjax/mathjax)).
<!--secp 2.1-->
// The number after the decimal point means that this is a nested section.
<!--sec 2.2-->
// Section options.'bg' : 'background', 'tr' : 'transition', 'bgtr' : 'background-transition', 'bgrp' : 'background-repeat', 'bgsz' : 'background-size'.
<!--sec 3 bg='#123' tr='cube' bgtr='linear'-->

<!--Meta key1:value1 key2:value2 [...]--> // Options,these lines should be in the head of the file.
```

### Generate the html file

After finish editing something like [this](https://raw.github.com/farseer90718/vim-reveal/master/test/test.md).
Use the `:RevealIt` command to generate the html file with the name of g:reveal_file_name in the g:reveal_root_path.
