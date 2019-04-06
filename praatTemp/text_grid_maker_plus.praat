# This script helps you make text grids. It opens all files from the specified directory one at a time
# creates a text grid for you, waits until you're done annotating, and saves that text grid for you,
# and loops until you're done with all the files.
# originally written by Kathryn Flack and Shigeto Kawahara
# Modified by Aaron Braver version 2/6/2012

# First, we define the directory where all the files we want to work with is - You thus
# need to define your own directory; below I use "./", the directory that the script resides in,
# but change this! The  best way not to make a mistake is to (i) From the script window, go Edit =>
# clear history,  (ii) From the object window, Read=> Read from file... and open any one file from
# the directory (iii) and paste history. This should give you a command line like the one below.
# Read from file.../xxx/yyyy/zzzz/aaa.wav. /xxx/yyyy/zzzz/ is the path to the directory. 
# Then you can then copy and paste the directory name.

# If "skip" is set to yes, the script will not open for editing a wav file that has a TextGrid
# in the same directory as the wav file and has the same name
# So, if you have 1.wav, 2.wav, and 2.TextGrid in the same directory, with this option,
# Only 1.wav will be opened for editing.

form Textgrid in which directory?
	sentence Directory ./
	comment Skip wav files that already have an associated textgrid?
	sentence skip yes
endform

backtrack = 0
# this lists everything in the directory into what's called a Strings list
# and counts how many there are

Create Strings as file list... list 'directory$'*.wav
numberOfFiles = Get number of strings

# Below is the script for a loop, doing something for every file on the list.

for ifile to numberOfFiles

# Select the stringlist and find a file name. Then, it reads that file.

	select Strings list
	fileName$ = Get string... ifile
	Read from file... 'directory$''fileName$'

# Now we define an object name - a file name minus extension. This is useful because
# then we can refer to the text grid file and the sound file by using the object name,
# which is a variable. See below

     	object_name$ = "'fileName$'" - ".wav"
	possible_textgrid_name$ = "'object_name$'" + ".TextGrid"
	possible_fullpath$ = "'directory$'" + "'possible_textgrid_name$'"

	

#Check if it already has a TextGrid
if fileReadable (possible_fullpath$) and  skip$ = "yes" and backtrack <> 1
		 printline "'possible_textgrid_name$'" already exists, so I've skipped it for you.
else
	  #This is what happens if it doesn't already have a texgrid
		# Select a sound now.

	   	select Sound 'object_name$'
		
		if not fileReadable(possible_fullpath$)
			# Create a text grid file with a tier named "sentence". This name is not important.
			# It can be anything.
			To TextGrid... sentence 
		else
			Read from file... 'possible_fullpath$'
			#pause I've loaded up your previous work on 'object_name$' for you!
		endif
		backtrack = 0

			

		# And you select the sound file and the text grid file, whose name is defined
		# by "object_name" (see above). This is why we defined the object_name.

			select Sound 'object_name$'
			plus TextGrid 'object_name$'

		# And of course now we want to edit the files.

		Edit

		# The script pauses here so that you can work on marking intervals.
		# It waits until you click a button in the window that pops up, 
		# at which point the script will resume. The sentence that follows
		# will be in the window. Add any sentence that makes you feel happy
		# when labeling.

	     	beginPause("Hi. You're working on item numer 'ifile' ('object_name$')!")
		comment ("Hit continue to continue editing")
		comment ("Hit back to go back one file")
		comment("Going back means you won't save new work on the current file")
		comment ("Hit stop if you are sick of segmenting")
		comment ("Revert is a side effect of Praat.  Clicking it does nothing!")
		clicked=endPause("Back", "Continue", 2)


		if 'clicked' = 1
			ifile = ifile - 2
			backtrack = 1
			if ifile < 0
				ifile = 0
				backtrack = 0
				pause "You're already at the first file!  Can't go back!"
			endif
			#pause ifile is now 'ifile'
		else
			# Once you are done marking, you want to save the TextGrid file. So, first you
			# select it.

			select TextGrid 'object_name$'

			# Then save it as a text file with "TextGrid" extension.

     			Write to text file... 'directory$''object_name$'.TextGrid
		endif

endif	


# Now we get rid of all the files from the menu window.
# It does NOT mean that we delete the files that we created.

     	select all
     	minus Strings list
     	Remove

# And it ends if it goes through all the files in the directory.

endfor

# After the loop, let's clear off all the window.

select all
Remove


