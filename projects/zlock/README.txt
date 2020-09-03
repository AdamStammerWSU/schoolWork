The comments in the program should help explain what's happening but essentially
 - loop through each line in the input file
 - if the line starts with "NV 24:" then convert it
	- drop the beginning of the line so it's only the hex numbers
	- loop through this list of hex numbers and convert each one from left to right
	- bring the "NV 24:...." prefix back but switch "Hex Data: " to "Dec Data: "
 - save the line to the output file

You may have to tweak some things like the input file name and the search parameter ("NV 24:") but this should be a good starting point!