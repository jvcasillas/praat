# Check Intervals 
# This script takes the set of TextGrid files in a folder, and checks to make sure 
# that each TextGrid file has the correct number of intervals, and that they're
# in the correct order.  This is useful to make sure you didn't make any typos
# which could affect how intervals are labeled.
# Some code for this script comes from duration_getter.praat, originally writen by Mietaa Lennes, 
# and further revised by Shigeto Kawahara
#
#To make this work for your project, be sure to change numberOfExpectedIntervals,
#add/remove/modify if/elsif statements in the for-loop that checks interval labels
#
# Aaron Braver, Version 1, 3/31/2011

# ask the user for the tier number
form Calculate durations of labeled segments
	sentence Directory ./
	comment Which tier of the TextGrid object would you like to analyse?
	integer Tier 1
	comment Where do you want to save the list of errors, if there are any?
	text textfile textgriderrors.txt
endform

clearinfo

#get the number of TextGrid files for looping

Create Strings as file list... list 'directory$'/*.TextGrid
select Strings list
ns = Get number of strings

for i to ns
	select Strings list
	gridname$ = Get string... i
	Read from file... 'directory$'/'gridname$'
endfor

#set how many intervals you expect there to be in the file
	numberOfExpectedIntervals = 6
#get the name of each file

for i to ns
	select Strings list
	gridname$ = Get string... i
	name$ = gridname$ - ".TextGrid"
	Read from file... 'directory$'/'gridname$'
	select TextGrid 'name$'
	
		# check how many intervals there are in the selected tier:
		numberOfIntervals = Get number of intervals... tier
		
		#check to see that it has the right number of intervals
		if numberOfIntervals  <> numberOfExpectedIntervals
			fileappend 'textfile$' 'name$' doesn't have the right number of intervals
			fileappend 'textfile$' 'newline$'
			fileappend 'textfile$' 'newline$'

		else
		wroteSomethingP = 0

		# loop through all the intervals, if it's got the right number of them
			for interval from 1 to numberOfIntervals
				#check that the label is correct, and in the correct order
					label$ = Get label of interval... tier interval
				if interval = 1
					if label$ <> ""
						fileappend 'textfile$' 'name$': There is an issue with interval 1.  It should be blank, but it is actually "'label$'" 'newline$'
						 wroteSomethingP= 1
					endif	
				elsif interval = 2
					if label$ <> "1" and label$ <> "1-Q"
						fileappend 'textfile$' 'name$': There is an issue with interval 2.  It should be "1", but it is actually "'label$'" 'newline$'
						wroteSomethingP = 1

					endif	
				elsif interval = 3
					if label$ <> "V" and label$ <> "V-Q"
						fileappend 'textfile$' 'name$': There is an issue with interval 3.  It should be "V", but it is actually "'label$'" 'newline$'
						wroteSomethingP = 1
					endif	
				elsif interval = 4
					if label$ <> "C" and label$ <> "C-Q"
						fileappend 'textfile$' 'name$': There is an issue with interval 4.  It should be "C", but it is actually "'label$'" 'newline$'
						wroteSomethingP = 1
					endif	
				elsif interval = 5
					if label$ <> "2" and label$ <> "2-Q"
						fileappend 'textfile$' 'name$': There is an issue with interval 5.  It should be "2", but it is actually "'label$'" 'newline$'
						wroteSomethingP = 1
					endif	
				elsif interval = 6
					if label$ <> ""
						fileappend 'textfile$' 'name$': There is an issue with interval 6.  It should be blank, but it is actually "'label$'" 'newline$'
						wroteSomethingP = 1
					endif	
				endif
			endfor
			if wroteSomethingP = 1
				#Print a newline if we wrote something for this item
				fileappend 'textfile$' 'newline$'
			endif
		endif
endfor

	select all
	minus Strings list
	Remove

