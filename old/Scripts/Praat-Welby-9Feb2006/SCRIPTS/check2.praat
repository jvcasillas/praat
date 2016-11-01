#################################################################
## check.praat
##
## pulls up TextGrid and .wav files 
## use for checking (and correcting) labels
##
## can be used with files whose names contain decimal points
## (e.g. foo-4.17.wav), which are converted to underscores in
## the objects window
##  
##
## Pauline Welby, November 19, 2005
##
## works with Praat 4.3.29
## 
#################################################################

form Input directory name with final slash
    comment Enter directory where soundfiles are kept:
    sentence soundDir E:\PRAAT\TUTORIALS\SOUNDFILES\SET3
    comment Enter directory where TextGrid file will be saved:
    sentence textDir E:\PRAAT\TUTORIALS\TEXTGRIDS\SET3
    comment Enter directory where list file (if any) is kept:
    sentence listDir E:\PRAAT\TUTORIALS\LISTS
    comment Display file basename? 
    boolean display_name yes
    comment Check TextGrid? 
    boolean check_TextGrid no
    comment Play sound automatically? 
    boolean play_sound no
    comment Save TextGrid? 
    boolean save_TextGrid yes
endform

if (save_TextGrid = 0) && (check_TextGrid = 1)
 pause Changes will NOT be saved! Continue?
endif

Create Strings as file list... list 'soundDir$'\*.wav
#Read Strings from raw text file... 'listDir$'\list.txt


# loop that goes through all the specified files
numberOfFiles = Get number of strings
for ifile to numberOfFiles
   select Strings list
   fileName$ = Get string... ifile
   name$ = fileName$-".wav"

# if there are associated TextGrid files...

   if check_TextGrid = 1
      # Read in files
      Read from file... 'textDir$'\'name$'.TextGrid
      # rename  
      Rename... current
      Read from file... 'soundDir$'\'name$'.wav
      Rename... current

      
      # print base name of current file to info window
      if display_name = 1      
        echo current = 'name$'
      endif     
      
      # Display files in edit window
      select Sound current
      plus TextGrid current
      Edit

      # automatically play Sound object
      if play_sound = 1
        select Sound current
        Play
      endif

      # prompt user to check labels
      pause Check labels
      
      select TextGrid current

      # save TextGrid
      if save_TextGrid = 1
        Write to text file... 'textDir$'\'name$'.TextGrid
      endif

     ## Remove Sound object from objects window before proceeding to the next file
     Remove

# if there are no TextGrid files...

   else
      # read in only sound file
      Read from file... 'soundDir$'\'name$'.wav
      Rename... current

      # print base name of current file to info window
      if display_name = 1      
        echo current = 'name$'
      endif 

      # Display sound in edit window
      select Sound current
      Edit

      # automatically play Sound object
      if play_sound = 1
         select Sound current
         Play
      endif

      # prompt user to check
      pause Check

   endif

      ## Remove Sound object from objects window before proceeding to the next file
      select Sound current
      Remove

endfor

## Remove Strings object for complete object cleaning up
select Strings list
Remove

# Clear the info window
if display_name = 1  
  clearinfo
endif

###END OF SCRIPT###
