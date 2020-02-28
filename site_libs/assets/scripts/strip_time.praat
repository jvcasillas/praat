# -----------------------------------------------------------------------------
#
# Remove time from audio file and textgrid
#
# Last udpate: 02/27/2020
# Author: Joseph V. Casillas
#
# - This script will loop through all of the .wav files and 
#   corresponding textgrids in a directory and automatically 
#   strip a specified amount of time from the beginning. 
# - By default 60 seconds are removed.
# - The script assumes you have a project (root directory) 
#   named "strip_time" and your wav files are stored in "wavs"
# - The edited files are saved in "new_wavs"
# - There is an example project folder available here: 
#   https://www.jvcasillas.com/praat/site_libs/assets/scripts/strip_time.zip
#
# -----------------------------------------------------------------------------


#
# Form setup ------------------------------------------------------------------
#

form Strip time from wav/textgrid
	sentence Path_to_files_(wavs/textgrids) ./sound_files/
	sentence Where_to_save ./sound_files_new/
	real Time_to_strip_from_files_(ms) 60
endform

# Shorten variables

path$ = path_to_files$
outputDir$ = where_to_save$
time_to_remove = 'time_to_strip_from_files'

# -----------------------------------------------------------------------------



#
# Prepare loop ----------------------------------------------------------------
#

# Go to folder where files are located, create list
Create Strings as file list: "fileList", path$ + "*.wav"

# Select the object fileList
selectObject: "Strings fileList"

# Count # of files and assign total to 'numFiles'
numFiles = Get number of strings

# -----------------------------------------------------------------------------



#
# Start loop ------------------------------------------------------------------
#

for i from 1 to numFiles
	
	# Select string
	select Strings fileList
	fileName$ = Get string... i
	prefix$ = fileName$ - ".wav"
	Read from file... 'path$'/'prefix$'.wav
	Read from file... 'path$'/'prefix$'.TextGrid

	# Remove time from beginning of sound object
	selectObject: "Sound " + prefix$
	file_duration = Get total duration
	Extract part: time_to_remove, 'file_duration', "rectangular", 1, "no"

	# Save new sound object
	selectObject: "Sound " + prefix$ + "_part"
	Save as WAV file: outputDir$ + fileName$

	# Remove time from beginning of textgrid object
	selectObject: "TextGrid " + prefix$
	Extract part: time_to_remove, file_duration, "no"

	# Save new textgrid object
	selectObject: "TextGrid " + prefix$ + "_part"
	Save as text file: outputDir$ + prefix$ + ".TextGrid"

endfor

# -----------------------------------------------------------------------------



#
# Clean objects and finish ----------------------------------------------------
#

select all
Remove

writeInfoLine: "Finished! :)"
appendInfoLine: "The shorter sound files and textgrids can be found in:"
appendInfoLine: "'", outputDir$, "'"

# -----------------------------------------------------------------------------



