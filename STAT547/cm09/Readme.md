-   [Lecture content](#lecture-content)
    -   [NON-interactive programming](#non-interactive-programming)
    -   [pipeline](#pipeline)
    -   [Test drive make](#test-drive-make)
    -   [pipeline examples](#pipeline-examples)

Lecture content
===============

NON-interactive programming
---------------------------

-   source button on R script
-   rmarkdown::render()/knit button
-   Command line: Rscript (...).R
-             Rscript -e

-   put multiple line: like Rscript -e 5\*5; 5^2

pipeline
--------

-   [Pipeline](http://stat545.com/automation01_slides/index.html#/shell-and-rscript)

Test drive make
---------------

-   Make file structure:
-     plot.png: foo.R
          Rscript foo.R
          //typing in terminal
          make plot.png

pipeline examples
-----------------

-   R automation examples
