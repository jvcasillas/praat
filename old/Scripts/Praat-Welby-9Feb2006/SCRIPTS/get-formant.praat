############################################################################
## get-formant.praat
##
## extracts formant (F1, F2) values  from Formant files (which are made and removed by this script)
## at time points indicated in associated TextGrid files (midpoint of V1);
## prints values to a text file
##
## adds midpoint labels to TextGrid file (if there no existing label)
## This allows user to easily check the value found by Praat.
##
## Use with label-vowel.praat
##
## Pauline Welby
## welby@ling.ohio-state.edu
## January 12, 2003
##
## works with Praat 4.3.29
##
############################################################################

# brings up form that prompts the user to enter directory and output file names
# creates variables for these

form Input Enter directory and output file name
    comment Enter directory where soundfiles are kept:
    sentence soundDir E:\PRAAT\TUTORIALS\SOUNDFILES\SET1
    comment Enter directory where TextGrid file will be saved:
    sentence textDir E:\PRAAT\TUTORIALS\TEXTGRIDS\SET1
    comment Enter directory where list file (if any) is kept:
    sentence listDir E:\PRAAT\TUTORIALS\LISTS
    comment Enter filename to which values should be written
    sentence outFile formant-values.txt
endform

# creates an output file with the specified name and adds headings 
# tab variables ('tab$') create columns
# NB: if the named output file exists, appends to existing file

clearinfo

# first deletes any existing output file
filedelete 'listDir$'\'outFile$'

# creates header
fileappend 'listDir$'\'outFile$' 'name$' 'tab$'  'v1f1:1' 'tab$'  'v1f2:1' 'newline$' 

# Reads in a list of files in one of two ways

# by matching patterns
Create Strings as file list... list 'textDir$'\*.TextGrid

# *or* using a text file list
#Read Strings from raw text file... 'listDir$'\list.txt

# Counts number of lines (filenames) in list, opens loop
# Creates variable with basename of file

numberOfFiles = Get number of strings
for ifile to numberOfFiles
   select Strings list
      fileName$ = Get string... ifile
      name$ = fileName$ - ".TextGrid"

print 'name$' 'newline$'

# Reads in TextGrid (label) and sound (wav) files

Read from file... 'textDir$'\'name$'.TextGrid
Read from file... 'soundDir$'\'name$'.wav

# Selects Sound object and creates a Formant object
 select Sound 'name$'
 To Formant (burg)... 0.01 5 5500 0.025 50

## extract values from Text Tier (label times) in order to calculate midpoint
## also check v1stat (v1status) to see if midpoint is already labelled

## Select TextGrid
select TextGrid 'name$'

## Search all tiers until appropriate tier is found ("segments")
nTiers = Get number of tiers

for i from 1 to 'nTiers'

	tname$ = Get tier name... 'i'

		if tname$ = "segments"

			# Search all labelled points for labels for calculating midpoint			
		         nInterv = Get number of intervals... 'i'
			for j from 1 to 'nInterv'
							
				lab$ = Get label of interval... 'i' 'j'

					 if lab$ = "v1"
					     begV1= Get starting point... 'i' 'j'			       	    
     				   	     endV1= Get end point... 'i' 'j'
					 endif
					
					 
			endfor
		endif 

		if tname$ = "misc"

			# Search all labelled points for labels for calculating midpoint			
		         nPoints = Get number of points... 'i'
			 v1stat = 0
			 for j from 1 to 'nPoints'
							
				lab$ = Get label of point... 'i' 'j'

					 if lab$ = "MidV1"
					    v1stat = 1
    				       	    midV1= Get time of point... 'i' 'j'
					 endif
					

					 
			endfor
		endif
		
endfor



# calculates duration of vowel, then midpoint

durV1 = endV1 - begV1
midV1 = (durV1/2)+begV1

# adds midpoint to TextGrid file
# v1stat line avoids attempted addition of a midpoint label if one already exists.

select TextGrid 'name$'
for i from 1 to 'nTiers'

	tname$ = Get tier name... 'i'

		if tname$ = "segments"
			if  (v1stat = 0) 
			   Insert point... 'nTiers' 'midV1' MidV1
	  		   Write to text file... 'textDir$'\'name$'.TextGrid
			endif 		
		endif 



	# add midpoint only if there is not an existing midpoint label
	 
endfor             
        

# get F1 and F2 values

select Formant 'name$'

v1f1 = Get value at time... 1 'midV1' Hertz Linear
v1f2 = Get value at time... 2 'midV1' Hertz Linear


## write extracted values to tab-delineated output file
## NB: This file can be opened in Excel, for example.

fileappend 'listDir$'\'outFile$' 'name$' 'tab$'  'v1f1:1' 'tab$'  'v1f2:1' 'newline$' 

###### Remove TextGrid and Formant files before proceeding to the next file

select TextGrid 'name$'
plus Sound 'name$'
plus Formant 'name$'
Remove

endfor

###### Remove list

select Strings list
Remove

#############################################
#END OF SCRIPT
#############################################