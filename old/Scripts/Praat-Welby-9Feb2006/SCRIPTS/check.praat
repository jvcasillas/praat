#################################################################
## check.praat
##
## pulls up TextGrid and .wav files 
## use for checking (and correcting) labels
## 
## Written by Pauline Welby 08-12-02
##
## works with Praat 4.3.29
## 
#################################################################

form Input directory name with final slash
    comment Enter directory where soundfiles are kept:
    sentence soundDir E:\PRAAT\TUTORIALS\SOUNDFILES\SET2
    comment Enter directory where TextGrid file will be saved:
    sentence textDir E:\PRAAT\TUTORIALS\TEXTGRIDS\SET2
    comment Enter directory where list file (if any) is kept:
    sentence listDir E:\PRAAT\TUTORIALS\LISTS
    comment Check TextGrid? 
    boolean check_TextGrid yes
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
      Read from file... 'soundDir$'\'name$'.wav

      # Display sound and TextGrid in edit window
      select Sound 'name$'
      plus TextGrid 'name$'
      Edit

      # automatically play Sound object
      if play_sound = 1
        select Sound 'name$'
        Play
      endif

      # prompt user to check labels
      pause Check labels
     
      select TextGrid 'name$'

      # save TextGrid
      if save_TextGrid = 1
        Write to text file... 'textDir$'\'name$'.TextGrid
      endif

     ## Cleaning up objects before proceeding to the next file
     Remove

   else

      # Read in sound file
      Read from file... 'soundDir$'\'name$'.wav

      # Display sound in edit window
      select Sound 'name$'
      Edit

      # automatically play Sound object
      if play_sound = 1
         select Sound 'name$'
         Play
      endif

      # prompt user to check
      pause Check

   endif

      ## Remove Sound object from objects window before proceeding to the next file
      select Sound 'name$'
      Remove

endfor

## Remove Strings object for complete object cleaning up
select Strings list
Remove

###END OF SCRIPT###
