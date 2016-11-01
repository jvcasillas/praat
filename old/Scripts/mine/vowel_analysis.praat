###########################
#  Extract F0, duration, intensity  #
#  Joseph V. Casillas                    #
#  10/2/2013                             #
##########################

#### This script will do the following acoustic analysis :
####	- F0 at midpoint
####	- Intensity at midpoint
####	- duration of vowel

#### Enter the path to where the files are kept

form Enter information
	comment Folders where files are kept:
	sentence dirFiles /Users/casillas/Desktop/files
	comment Enter directory where list file (if any) is kept:
	sentence listDir /Users/casillas/Desktop/files/list/
   	comment Enter filename to which values should be written
   	sentence outFile vowel_data.txt
endform

#### creates an output file with the specified name and adds headings 
#### tab variables ('tab$') create columns
#### NB: if the named output file exists, appends to existing file

clearinfo

#### first deletes any existing output file
filedelete 'listDir$'/'outFile$'

#### creates header
fileappend 'listDir$'/'outFile$' 'prefix$''tab$''speaker$''tab$''word$''tab$''stress$''tab$''v1dur''tab$''v1int''tab$''v1f0''tab$''v2dur''tab$''v2int''tab$''v2f0''newline$' 


#### Prepare the loop
Create Strings as file list... allFiles 'dirFiles$'/*.wav
select Strings allFiles
clearinfo
numberOfFiles = Get number of strings

#### Begin loop

for i to numberOfFiles
	select Strings allFiles
	fileName$ = Get string... i
	prefix$ = fileName$ - ".wav"
	tgName$ = prefix$ + ".TextGrid"
	Read from file... 'dirFiles$'/'fileName$'
	nameSound$ = selected$("Sound")
	Read from file... 'dirFiles$'/'tgName$'
	select Sound 'nameSound$'
	do ("To Pitch...", 0, 75, 600)
	select Sound 'nameSound$'
	do ("To Intensity...", 10, 0, "yes")
	select Sound 'nameSound$'
	plus TextGrid 'nameSound$'
	Edit

	## extract values from Text Tier (label times) in order to calculate duration of vowel 1
	## Select TextGrid

	

	select TextGrid 'nameSound$'

	#labels
	speaker$ = Get label of interval... 1 1
	word$ = Get label of interval... 2 1
	stress$ = Get label of interval... 3 1

	#v1 dur
	v1Start = do ("Get start point...", 4, 2)
	v1End = do ("Get end point...", 4, 2)
	v1dur = v1End - v1Start
	v1x = v1dur / 2
	v1mp = 'v1Start' + 'v1x'

	#v2 dur
	v2Start = do ("Get start point...", 5, 2)
	v2End = do ("Get end point...", 5, 2)
	v2dur = v2End - v2Start
	v2x = v2dur / 2
	v2mp = 'v2Start' + 'v2x'

	#v1 f0
	select Pitch 'nameSound$'
	v1f0 = do ("Get value at time...", v1mp, "Hertz", "Linear")

	#v2 f0
	v2f0 = do ("Get value at time...", v2mp, "Hertz", "Linear")

	#v1 int
	select Intensity 'nameSound$'
	v1int = do ("Get value at time...", v1mp, "Linear")

	#v2 int
	v2int = do ("Get value at time...", v2mp, "Linear")


	printline v1 start time is 'v1Start'
	printline v1 end time is 'v1End'
	printline v1dur = 'v1dur'
	printline v1 midpoint =  'v1mp'
	printline v1 intensity = 'v1int'
	printline v1 f0 = 'v1f0'

	printline v2 start time is 'v2Start'
	printline v2 end time is 'v2End'
	printline v2dur = 'v2dur'
	printline v2 midpoint =  'v2mp'
	printline v2 intensity = 'v2int'
	printline v2 f0 = 'v2f0'

	printline group = 'speaker'
	printline word = 'word'
	printline stress = 'stress'

	## write extracted values to tab-delineated output file
	## NB: This file can be opened in Excel, for example.

	fileappend 'listDir$'/'outFile$' 'prefix$''tab$''speaker$''tab$''word$''tab$''stress$''tab$''v1dur''tab$''v1int''tab$''v1f0''tab$''v2dur''tab$''v2int''tab$''v2f0''newline$' 

	## Printline to make sure it's working

	printline 'nameSound$'	'speaker$'	'word$' 'stress$'	'v1dur'	'v1int'	'v1f0'	'v2dur'	'v2int'	'v2f0'

	select all
	minus Strings allFiles
	Remove
endfor

#### Clean up

select all
Remove
