First compose the text in a pdf using whatever means prefered (word, libreoffice, adobe acrobat, etc.)

Convert this pdf to png files using "convert -density 600 [input.pdf] [output-.png]". This requires ImageMagick and Ghostscript to be installed
----------   "-density [300+]" is required to get high res images. This will take some time to run -----------

Use Parvata to impose these images together as required.
java -jar parvata.jar -fi 16 -fo 4 input- output-
    -> this would start a signature on input-0016.png and start output at output-0004.png

Compile these images into an output pdf with ""

Impositioning Done! 