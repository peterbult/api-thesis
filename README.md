
## The API thesis template

This template is a work in progress. It may still contain a few bugs, employs a
number of hacks and work-arounds, leaving plenty of room for improvement.
So, if you find and fix any bugs in this template or otherwise improve it, feel 
free to update it and send it around to the other (API) PhD students.

All files have been separated in folders by function:
 *  content/    - The actual chapters
 *  gfx/        - All plots and diagrams
 *  tab/        - Separate tables
 *  scripts/    - Compile scripts
 *  tex/        - LaTeX source files for layout and formatting


The main file is `tex/thesis.tex`, which links to all other tex files, 
figures, bibfiles ans style files.

Most packages you'll need to format your own style are already included
in the tex/apithesis.cls file.

Detailed instructions of how to use the template are given as comments 
throughout the tex files. 



## Compiling the thesis

There is a script to compile the thesis using dvips, which should be run
from the `tex/` subfolder
```
    ../scripts/makethesis.sh
```
or
```
    ../scripts/SetThesis.engine thesis.tex
```
This compiles the template, links the bibtex file and rebuilds twice to construct
all the references. If you just want to build once and keep all the temporary 
files, use
```
    ../scripts/PartialThesis.engine thesis.tex
```

Alternatively you can also use pdflatex or xelatex if you prefer. Although
you should then make sure that the resulting pdf has all fonts embedded
and good compatability settings.

> Note: If you are using TeXShop on Mac you can copy the *.engine files to 
>           `~/Library/TeXShop/Engines/`
>       which allows you to call the script using TeXShop's internal compile 
>       command.


The propositions are in a separate file `tex/propositions.tex`. Compile as
    pdflatex propositions.tex


This template makes use of customized latex packages. The relevant *.sty files
are found in `tex/` folder and are automatically linked to.

