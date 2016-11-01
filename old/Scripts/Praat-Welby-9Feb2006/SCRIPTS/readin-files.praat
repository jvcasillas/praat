################################################################
###  Read in all .wav files and .TextGrid files in a directory
###
### Pauline Welby
### welby@ling.ohio-state.edu
### July 2002
### 
### works with Praat 4.3.29
################################################################

# This is a form that queries the user to specify the  name of 
# the directory that contains the files to be worked on

form Input directory name with final slash
    comment Enter directory where soundfiles are kept:
    sentence soundDir E:\PRAAT\TUTORIALS\SOUNDFILES\SET2
    comment Enter directory where TextGrids are kept:
    sentence textDir E:\PRAAT\TUTORIALS\SOUNDFILES\SET2
    comment Enter directory where list files are kept:
    sentence listDir E:\PRAAT\TUTORIALS\LISTS
endform

# lists all .wav files
Create Strings as file list... list 'soundDir$'\*.wav

## Uncomment following line to read in files from a list
# Read Strings from raw text file... 'listDir$'\list.txt

# loop that goes through all files

numberOfFiles = Get number of strings
for ifile to numberOfFiles
   select Strings list
   fileName$ = Get string... ifile
   baseFile$ = fileName$ - ".wav"

   # Read in the Sound files and TextGrid files with that base name

   Read from file... 'soundDir$'\'baseFile$'.wav
   #Read from file... 'textDir$'\'baseFile$'.TextGrid

endfor
################################################################
#END OF SCRIPT
################################################################
