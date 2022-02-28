# Easy plot
#
# This script will take a sound object and textgrid
# and generate a simple plot of the spectrogram and 
# textgrid (no waveform). 
# The textgrid should only have 1 tier.
#
# Author: Joseph V. Casillas
# Last update: 02-27-2022
#

# Did you select a sound?
beginPause ("Plot sound file")
	comment ("Make sure you select the sound file and corresponding textgrid that you would like to plot.")
clicked = endPause ("Cancel", "Next", 2, 1)
if clicked = 1
	exit The plot was not created
endif


Erase all

Font size: 12
sound = selected ("Sound")
name$ = selected$("Sound")
textgrid = selected ("TextGrid")
select sound
To Spectrogram: 0.005, 5000, 0.002, 20, "Gaussian"
spectrogram = selected ("Spectrogram")
Select inner viewport: 1, 5, 2, 3.4
select spectrogram
Paint... 0 0 0 0 100 yes 50 6 0 no
Black
Draw inner box
Marks left every... 1 1250 yes yes no
Text left... yes Frequency (Hz)
Select inner viewport: 1, 5, 2, 3.75
select textgrid
Draw... 0 0 yes no yes
Select inner viewport: 1, 5, 2, 3.75



###############
# Save things #
###############

# Save file prompt with opt out
beginPause ("Save file")
	comment ("Would you like to save the file?")
clicked = endPause ("No", "Yes", 2, 1)
if clicked = 1
	exit The plot was not saved
endif

# Where to save
dir$ = chooseDirectory$ ("Where you woud like to save the file?")
if dir$ = ""
	exit The experiment file was not created.
endif

# File format with opt out
beginPause ("Save file")
	comment ("What is your preferred file format?")
clicked = endPause ("PDF", "PNG (300-dpi)", "PNG (600-dpi)", 3)
if clicked = 1
	Save as PDF file:  "'dir$'/'name$'.pdf"
elsif clicked = 2
	Save as 300-dpi PNG file:  "'dir$'/'name$'.png"
elsif clicked = 3
	Save as 600-dpi PNG file:  "'dir$'/'name$'.png"
endif




