inFile = open("in.txt", "r") ## open the input file in read-only mode
outFile = open("out.txt", "w") ## open the output file in write-only mode

### this function takes in a string formatted something like "NV 24: 16 bytes. Dec data: 1 3 49 196 10 180 10 185 10 182 0 35 0 0 180 10 3 20 0 0 35 0 0 60 3 3 148 0 0 20"
### it drops the text prefix so only the hex numbers remain. Then it converts those hex numbers one by one to decimal
### then it reattaches the text prefix with "Dec data: " instead of "Hex data: " and return that line
def convertLine(line):
    hexDataIndex = line.find("Hex data: ") + 10 # find the location of the text "Hex Data: " and then add 10 because that's how long that search phrase is
    hexNumbersString = line[hexDataIndex:] # take from this index to the end of the string
    #now hexNumbersString contains just the hex numbers each with one space after it

    #now grab each hex number one by one and convert it to decimal
    decimalNumbersString = ""
    while len(hexNumbersString) > 2:
        #grab the first number
        hexNumber = hexNumbersString[:2]
        
        # and remove it from the beginning of hexNumberString
        hexNumbersString = hexNumbersString[3:]

        # save this result in the decimal number string 
        decimalNumbersString += convertHexStringToDec(hexNumber) + " "
    # grab the original prefix of the line but replace "Hex data: " with "Dec data: " and then concatenate it with the decimal string we just generated. Return this resulting line
    # this should be the original line with each number converted and the word "Hex" switched to "Dec" and an extra space at the end
    decDataLine = line[:(hexDataIndex - 10)] + "Dec data: " + decimalNumbersString
    # now we need to get rid of the space at the end and replace it with a "\n" (newline) character instead cause that's what the orignal line looked like
    decDataLine = decDataLine[:-1] + "\n"
    return decDataLine

### this function takes in a non prefixed hex string like "2a" and converts it to a decimal string like "42" and returns it
def convertHexStringToDec(x):
    print(x)
    print("0x" + x)
    # string needs to start with "0x" to work, so I append that to the number string here
    hex = "0x" + x
    # the "int()" method will convert to decimal automatically but as an integer
    i = int(hex, 0)
    # "str(i)" converts it back to a string type
    return (str(i))





#######################
##PROGRAM STARTS HERE##
#######################
lineNumber = 0
i = inFile.readline() # read the first line
while i != "": # if we've reached the end of the file, then readline() returns an empty string, so stop the loop
    if i.startswith("NV 24:"):  # check to see if the line starts with what we're searching for (in this case: "NV 24:")
        ##this is the right line, so let's convert it
        print("Converting line ", end='')
        print(lineNumber) # inform the user which line is being converted
        
        i = convertLine(i) # use the conversion method on this line
    #####
    outFile.write(i) # print the line to the output file
    #This preserves the 'irrelevant' data lines as well (i.e. even the lines that don't contain hex data)
    #
    #If you only want the hex data in your output you can move this 'outfile.write(i)' statement into the last line of the while statement just above it
    #####
    i = inFile.readline() #read the next line
    lineNumber += 1 
print("Done! Saved to out.txt")

