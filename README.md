vim-reveal
==========

vim plugin that use markdown and reveal.js to generate presentations.

### Installation

1. Install with whatever the package managing plugin you are using.
2. Download or clone [reveal.js](https://github.com/hakimel/reveal.js/)
   somewhere.
3. Configure as needed

### Vim Configuration

```vim
let g:reveal_config = {
    \'path': 'your-reveal.js-path', " '$HOME/reveal.js/' will be used if not specified.
    \'filename': 'reveal', " The name of generated html file will be 'reveal.html'
    \'key1': 'value1',
    \'key2': 'value2',
    \ ...}
```
If no filename is configured, the title will be ascii-fied and used as
the filename. That may be nicer than setting a global option.

### Syntax / File Example

Your presentations is written using standard markdown syntax.  You use the
following comment styles to specify the sections and reveal.js options.

```
<!--Meta key1:value1 key2:value2 [...]--> // Options for reveal.js
<!--Meta key3:value3 key4:value4 --> // These lines can occur multiple times and should be at the top of the file

// The start of a markdown section.
<!--sec 1-->
// this is a normal slide

# Standard Markdown

goes here

<!--secp 2.1-->
// this is an html formatted slide.  The number after the decimal point
// sets up vertical slide nesting.  This is the first slide.

<h3>Title</h3>

<p>words words words</p>

// Markdown syntax is ignored here.  This is useful for presentations
// that use [MathJax](https://github.com/mathjax/mathjax)

<!--sec 2.2-->
// This is the next nested slide.  Notice this one is not using the same
// syntax and has switched to markdown.

# Standard Markdown

goes here

<!--sec 3 bg='#123' tr='cube' bgtr='linear'-->
// This slide has reveal.js section options.
// 'bg' : 'background'
// 'tr' : 'transition'
// 'bgtr' : 'background-transition'
// 'bgrp' : 'background-repeat'
// 'bgsz' : 'background-size'.
```

### Generate the html file

Use the `:RevealIt` command to generate the html file.

It accepts several options:
* `:RevealIt` or `:RevealIt default` - Replace the existing buffer with
  the generated code.  Saving this will overwrite your markdown file.
* `:RevealIt new` - Open a new buffer editing the generated file.
* `:RevealIt md` - Generate the file and save it, but stay in markdown
  file.

