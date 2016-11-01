##################################################################################################
### get-values-tones.praat
###
### extracts time points, f0 values and durations and spits them out
### into a tab-separated text file
### 
### Pauline Welby
### welby@icp.inpg.fr
### September 2005
###
### 4.3.27
##################################################################################################

form Input directory name
    comment Enter directory where soundfiles are kept:
    sentence soundDir E:\PRAAT\TUTORIALS\SOUNDFILES\SET2
    comment Enter directory where TextGrid files are kept:
    sentence textDir E:\PRAAT\TUTORIALS\TEXTGRIDS\SET2
    comment Enter directory where list files are kept:
    sentence listDir E:\PRAAT\TUTORIALS\LISTS
    comment Enter the step size (window duration) for creation of Pitch object. 
    comment Remember '0' before decimal point.
    positive step 0.005
    comment Enter filename to which values should be written
    sentence outFile connaught-values.txt
endform

# Reads in a list of files in one of two ways

# by matching patterns
Create Strings as file list... list 'textDir$'\*Nuc*.TextGrid

# *or* using a text file list
#Read Strings from raw text file... 'listDir$'\list.txt

# clear the info window

clearinfo

# deletes any existing output file
filedelete 'listDir$'\'outFile$'

# Create header for output file
fileappend 'listDir$'\'outFile$' 'name$' 'tab$' 'begsp1:3' 'tab$' 'begs1:3' 'tab$' 'ends1:3' 'tab$' 'ends2:3' 'tab$' 'ends3:3'
fileappend 'listDir$'\'outFile$' 'tab$' 'timel:3' 'tab$' 'timeL:3' 'tab$' 'timeH:3'
fileappend 'listDir$'\'outFile$' 'tab$' 'f0l:0' 'tab$' 'f0L:0' 'tab$' 'f0H:0'
fileappend 'listDir$'\'outFile$' 'tab$' 'durwd:0' 'tab$' 'dursp1:0' 'tab$' 'durs1:0''tab$' 'durs2:0''tab$' 'durs3:0' 'newline$'

# loop that goes through all files, strip extension to get basename

numberOfFiles = Get number of strings
for ifile to numberOfFiles
   select Strings list
      fileName$ = Get string... ifile
      name$ = fileName$ - ".TextGrid"

# Print file X of Y to info window

echo 'ifile' of 'numberOfFiles' 'newline$'

# Reads in sound (wav) and TextGrid (label)  files

Read from file... 'textDir$'\'name$'.TextGrid
Read from file... 'soundDir$'\'name$'.wav

# Selects Sound object

select Sound 'name$'

# Gets time values at different label points, words tier

select TextGrid 'name$'

## Search all tiers until appropriate tier is found
nTiers = Get number of tiers

for i from 1 to 'nTiers'

	tname$ = Get tier name... 'i'

# for tones

		if tname$ = "tones"

timel1 = 0
timeL1 = 0
timeH = 0
			
		        npoints = Get number of points... 'i'
			for j from 1 to 'npoints'
							
			  lab$ = Get label of point... 'i' 'j'

				if lab$ = "l"
    				 timel = Get time of point... 'i' 'j'
 				endif

			        if lab$ = "L"
    				 timeL = Get time of point... 'i' 'j'
 				endif

				if lab$ = "H"
    				 timeH = Get time of point... 'i' 'j'
 				endif

			endfor

		endif

# Gets time values at different label points, syllables tier

if tname$ = "syllables"

begsp1 = 0
endsp1 = 0
begs1 = 0
ends1 = 0
begs2 = 0
ends2 = 0
begs3 = 0
ends3 = 0		     
		      nInterv = Get number of intervals... 'i'
		      for j from 1 to 'nInterv'
							
			lab$ = Get label of interval... 'i' 'j'

		             if lab$ = "sp1"
  			      begsp1 = Get starting point... 'i' 'j'
			      endsp1 = Get end point... 'i' 'j'
 			     endif

			     if lab$ = "s1"
  			      begs1 = Get starting point... 'i' 'j'
			      ends1 = Get end point... 'i' 'j'
 			     endif

			     if lab$ = "s2"
  			      begs2 = Get starting point... 'i' 'j'
			      ends2 = Get end point... 'i' 'j'
 			     endif

 			     if lab$ = "s3"
  			      begs3 = Get starting point... 'i' 'j'
			      ends3 = Get end point... 'i' 'j'
 			     endif

		       endfor
endif

endfor # tiers

# calculates f0 values

f0l = 0
f0L = 0
f0H = 0

select Sound 'name$'
# Create Pitch object.
# Tweak the following settings, to set a higher voicing threshold, for example
# Note first value is the time step
To Pitch (ac)... 'step' 75 15 no 0.03 0.45 0.01 0.35 0.14 600

if 'timel' != 0
 f0l = Get value at time... 'timel' Hertz Linear
endif

if 'timeL' != 0
 f0L = Get value at time... 'timeL' Hertz Linear
endif

if 'timeH' != 0
 f0H = Get value at time... 'timeH' Hertz Linear
endif

#if 'timel' != 0
# Move cursor to... 'timel' 
# f0l = Get pitch
#endif

#if 'timeL' != 0
# Move cursor to... 'timeL' 
# f0L = Get pitch
#endif

# get durations

dursp1 = 0
durs1 = 0
durs2 = 0
durs3 = 0
durwd = 0

dursp1 = endsp1 - begsp1
durs1 = ends1-begs1
durs2 = ends2-begs2
durs3 = ends3-begs3

durwd = (durs1 + durs2) + durs3


#conversion to milliseconds

dursp1 = dursp1*1000
durs1 = durs1*1000
durs2 = durs2*1000
durs3 = durs3*1000
durwd = durwd*1000

# spits those values out into the output file

fileappend 'listDir$'\'outFile$' 'name$' 'tab$' 'begsp1:3' 'tab$' 'begs1:3' 'tab$' 'ends1:3' 'tab$' 'ends2:3' 'tab$' 'ends3:3'
fileappend 'listDir$'\'outFile$' 'tab$' 'timel:3' 'tab$' 'timeL:3' 'tab$' 'timeH:3'
fileappend 'listDir$'\'outFile$' 'tab$' 'f0l:0' 'tab$' 'f0L:0' 'tab$' 'f0H:0'
fileappend 'listDir$'\'outFile$' 'tab$' 'durwd:0' 'tab$' 'dursp1:0' 'tab$' 'durs1:0''tab$' 'durs2:0''tab$' 'durs3:0' 'newline$'

###### Cleaning up objects before proceeding to the next file
select Sound 'name$'
plus TextGrid 'name$'
plus Pitch 'name$'
Remove

endfor

###### Remove Strings object for complete object cleaning up
select Strings list
Remove

############################################################################
##end of script -- Yaay!
############################################################################