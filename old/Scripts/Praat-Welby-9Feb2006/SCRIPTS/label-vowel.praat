#################################################################
## label-vowel.praat 
## 
## creates a TextGrid file with a segment and misc tier for each specified .wav file
## goes through files, prompting user to click on vowel beginning and vowel end
## adds boundaries at specified locations, displays the labelling to allow the user to make 
## any necessary corrections (for mis-clicks, for example)
##
## Pauline Welby
## welby@ling.ohio-state.edu
## January 12, 2003
##
## works with Praat 4.3.29
##
#################################################################

# brings up form that prompts the user to enter directory name
# creates variable

form Input Enter directory and output file name (without final slash)
    comment Enter directory where soundfiles are kept:
    sentence soundDir E:\PRAAT\TUTORIALS\SOUNDFILES\SET1
    comment Enter directory where TextGrid file will be saved:
    sentence textDir E:\PRAAT\TUTORIALS\TEXTGRIDS\SET1
    comment Enter directory where list file (if any) is kept:
    sentence listDir E:\PRAAT\TUTORIALS\LISTS
endform

# Makes list of files to be labelled, creates a variable with basename of file
# opens loop 

Create Strings as file list... list 'soundDir$'\*.wav

# Uncomment following line (and comment preceding line) to read in files from a list
# in a text file.

#Read Strings from raw text file... 'listDir$'\list.txt
numberOfFiles = Get number of strings
for ifile to numberOfFiles
   select Strings list
   fileName$ = Get string... ifile
   Read from file... 'soundDir$'\'fileName$'
# strip extension to get basename
   name$ = fileName$ - ".wav"

# create .TextGrid file with two tiers 
# NB: The second instance of segments (without quotation marks) indicates that this 
# is a point tier

To TextGrid... "segments misc" misc

# selects Sound object and displays it
select Sound 'name$'
Edit
editor Sound 'name$'

# prompts user to click on vowel beginning and end, create variables with values at point clicked

 pause Click Get start of vowel 1
 Move cursor to nearest zero crossing
 v1beg = Get cursor
 pause Click Get end of vowel 1
 Move cursor to nearest zero crossing
 v1end = Get cursor

Close
endeditor

# add tags in the TextGrid at right times

select TextGrid 'name$'

Insert boundary... 1 'v1beg'
Insert boundary... 1 'v1end'
Set interval text... 1  2 v1

# allow user to confirm tagging (and make necessary changes)

select Sound 'name$'
plus TextGrid 'name$'
Edit
pause CONFIRM TextGrid

# save TextGrid file

select TextGrid 'name$'

Write to text file... 'textDir$'\'name$'.TextGrid

###### Cleaning up objects before proceeding to the next file
select Sound 'name$'
plus TextGrid 'name$'
Remove

endfor

###### After you're done with all files, remove Strings object for complete object cleaning up
select Strings list
Remove

########################################################
## END OF SCRIPT
########################################################