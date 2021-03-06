# 
# PRAAT script  
# CircleVowelsGivenStartingPoint.praat
#

#This script takes as its input two vowels defined in F1/F2 space. 
#One is an anchor and the other a starting point.
#The script will generate a continuum of vowels at a given distance apart (in erbs)
#at a fixed radius from the anchor vowel. The user can choose this to be the distance
# between the anchor vowel and the starting point or the user provides a radius in erbs. 
#The user specifies whether the direction is anticlockwise or clockwise.

#A plot is generated with the points on it. Our purpose requires Australian lax vowels so
#these are plotted as reference points. This can be changed in the AddAusVowels procedure
#at the end of the script. To use these vowels and anchors and/or starting points, 
#copy and paste them into the default values in the form immediately below.

#Written by Michael D. Tyler 21 Jun 2010
#AddErbScale procedure and plot parameters of user form:
	# Copyright Mietta Lennes 5.11.2004 (distributed under the GNU General Public License)

# get user input
form Parameters
#	comment Output directory 
	sentence outDirectory /Users/michaeltyler/Desktop/continuum/
#	comment Stimulus Parameters
		positive duration_in_ms 200
		positive f0 125
		positive rampin_in_ms 10
		positive rampout_in_ms 10
	comment Anchor vowel
    		positive anchor_F1 504
    		positive anchor_F2 1468
	comment Starting Point/Vector
    		positive start_F1 523
    		positive start_F2 1869
#	comment Radius value
		choice radiusvalue 2
			button Start minus Anchor
			button Provide a radius below
		real radius_length_in_erbs 1.6
	comment Continuum Parameters
		real step_size_in_erbs 0.3
		positive number_of_steps 33
		optionmenu direction 2
			option anticlockwise
			option clockwise
	comment Plot Parameters
		boolean Clear_Picture_window_first yes
		comment Formant chart minima and maxima (Hz):
		real f1_minimum 200
		real f1_maximum 1000
		real f2_minimum 600
		real f2_maximum 2500
endform

if clear_Picture_window_first = 1
	Erase all
endif


### plot parameters ###
Black
Times
Line width... 1
Font size... 16

call AddErbScale f1_minimum f1_maximum f2_minimum f2_maximum 1

Line width... 3

call AddAusEVowels

### static variables ###

#higher formants
f3 = 2600
f4 = 3300
f5 = 3850
f6 = 4900

#formant bandwidths
f1_bw = 50
f2_bw = 70
f3_bw = 110
f4_bw = 250
f5_bw = 200
f6_bw = 1000

### convert target values to ERBs ###

anchor_F1_erb = hertzToErb(anchor_F1)
anchor_F2_erb = hertzToErb(anchor_F2)
start_F1_erb = hertzToErb(start_F1)
start_F2_erb = hertzToErb(start_F2)

### convert durations to seconds ###

duration = duration_in_ms /1000
rampin = rampin_in_ms /1000
rampout = rampout_in_ms /1000

### calculate rampout point ###

rampout = duration - rampout

### calculate initial radius, angle, and angle step ###


radius = sqrt((anchor_F1_erb-start_F1_erb)^2 + (anchor_F2_erb-start_F2_erb)^2)


if  start_F2_erb > anchor_F2_erb
	if start_F1_erb > anchor_F1_erb
		starting_angle = (2 * pi) - arccos((start_F2_erb-anchor_F2_erb)/radius)
	else
		starting_angle = arccos((start_F2_erb-anchor_F2_erb)/radius) 
	endif
else
	if start_F1_erb > anchor_F1_erb
		starting_angle = (2 * pi) - arccos((start_F2_erb-anchor_F2_erb)/radius)
	else
		starting_angle = arccos((start_F2_erb-anchor_F2_erb)/radius)
	endif
endif

#Now that the angle has been calculated, adjust the radius length if it has been specified

if radiusvalue == 2
	radius = radius_length_in_erbs
endif

#calculate the angular step

angular_step = arctan(step_size_in_erbs/radius)

#For debugging - comment out if not needed
clearinfo
print anchor F1 erb: 'anchor_F1_erb'
printline
print anchor F2 erb: 'anchor_F2_erb'
printline
printline
print start F1 erb: 'start_F1_erb'
printline
print start F2 erb: 'start_F2_erb'
printline
print radius: 'radius'
printline
print Starting angle: 'starting_angle' in radians
printline
print Angular step: 'angular_step' in radians
printline

### synthesise the anchor vowel ###

f1_erb_temp = anchor_F1_erb
f2_erb_temp = anchor_F2_erb

f1_hz_temp = erbToHertz(f1_erb_temp)
f2_hz_temp = erbToHertz(f2_erb_temp)

#creats a new KlattGrid
Create KlattGrid... anchor_'f1_hz_temp:0'_'f2_hz_temp:0' 0 'duration' 6 1 1 6 1 1 1 

#add voicing amplitude, vowel formants, and pitch targets 
Add voicing amplitude point... 0.0 90 
Add pitch point... 0.0 'f0' 
Add oral formant frequency point... 1 0.1 'f1_hz_temp'
Add oral formant bandwidth point... 1 0.1 'f1_bw' 
Add oral formant frequency point... 2 0.1 'f2_hz_temp'
Add oral formant bandwidth point... 2 0.1 'f2_bw'
Add oral formant frequency point... 3 0.1 'f3'
Add oral formant bandwidth point... 3 0.1 'f3_bw'
Add oral formant frequency point... 4 0.1 'f4'
Add oral formant bandwidth point... 4 0.1 'f4_bw' 
Add oral formant frequency point... 5 0.1 'f5'
Add oral formant bandwidth point... 5 0.1 'f5_bw'
Add oral formant frequency point... 5 0.1 'f6'
Add oral formant bandwidth point... 5 0.1 'f6_bw'
	
To Sound
Formula... if x < 'rampin' then self * (1- (cos(0.5 * pi * (x/'rampin'))^2))  else self fi
Formula... if (x > ('rampout')) then self * (1- (cos((0.5*pi * (( 'duration' - x )/'rampin')))^2)) else self fi

#save the anchor vowel as a sound (aif) file. This may be changed to WAVE and .wav if desired
anchorName$ = selected$ ("Sound")
#Write to AIFF file... 'outDirectory$''anchorName$'.aif
	
select KlattGrid anchor_'f1_hz_temp:0'_'f2_hz_temp:0'
Remove

### start the loop for creating the vowels ###

theta = starting_angle
for step from 1 to number_of_steps

	#keep the angle in the range 0<theta<2pi
	if theta < 0
		theta = theta + 2 * pi
	endif


	f1_erb_temp = anchor_F1_erb - radius * sin(theta)
	f2_erb_temp = anchor_F2_erb + radius * cos(theta)

	#plot this step in the picture window
	Paint circle... black -f2_erb_temp -f1_erb_temp 0.05

	f1_hz_temp = erbToHertz(f1_erb_temp)
	f2_hz_temp = erbToHertz(f2_erb_temp)

	#for debugging - comment out if not needed
	print ### Step 'step' ###
	printline
	print theta = 'theta'
	printline
	temp = radius * sin(theta)
	print radius * sin(theta) = 'temp'
	printline
	temp = radius * cos(theta)
	print radius * cos(theta) = 'temp'
	printline
	print F1 = 'f1_erb_temp' erbs
	printline
	print F2 = 'f2_erb_temp' erbs
	printline
	print F1 = 'f1_hz_temp' Hz
	printline
	print F2 = 'f2_hz_temp' Hz
	printline
	printline 

	#creats a new KlattGrid
	Create KlattGrid... 'step'_'f1_hz_temp:0'_'f2_hz_temp:0' 0 'duration' 6 1 1 6 1 1 1 

	#add voicing amplitude, vowel formants, and pitch targets 
	Add voicing amplitude point... 0.0 90 
	Add pitch point... 0.0 'f0' 
	Add oral formant frequency point... 1 0.1 'f1_hz_temp'
	Add oral formant bandwidth point... 1 0.1 'f1_bw' 
	Add oral formant frequency point... 2 0.1 'f2_hz_temp'
	Add oral formant bandwidth point... 2 0.1 'f2_bw'
	Add oral formant frequency point... 3 0.1 'f3'
	Add oral formant bandwidth point... 3 0.1 'f3_bw'
	Add oral formant frequency point... 4 0.1 'f4'
	Add oral formant bandwidth point... 4 0.1 'f4_bw' 
	Add oral formant frequency point... 5 0.1 'f5'
	Add oral formant bandwidth point... 5 0.1 'f5_bw'
	Add oral formant frequency point... 5 0.1 'f6'
	Add oral formant bandwidth point... 5 0.1 'f6_bw'
	
	To Sound
	Formula... if x < 'rampin' then self * (1- (cos(0.5 * pi * (x/'rampin'))^2))  else self fi
	Formula... if (x > ('rampout')) then self * (1- (cos((0.5*pi * (( 'duration' - x )/'rampin')))^2)) else self fi
	
	#save this step along the circle as a sound (aif) file. This may be changed to WAVE and .wav if desired
	objectName$ = selected$ ("Sound")
	Write to AIFF file... 'outDirectory$''objectName$'.aif

	#insert a silent soundfile to aid concatenation
	Create Sound from formula... silence Mono 0 1 44100 self
	
	select KlattGrid 'step'_'f1_hz_temp:0'_'f2_hz_temp:0'
	Remove

	#increment theta by the step size
	if direction == 1
		theta = theta - angular_step
	else
		theta = theta + angular_step
	endif

endfor

#pause Select the sounds you want to concatenate and click OK
select all
minus Sound 'anchorName$'
#Chain all of the steps around the circle into a single sound file.
#Also save a TextGrid so that the files may be recovered 
Concatenate recoverably
minus TextGrid chain
Write to AIFF file... 'outDirectory$'VowelSteps.aif
select TextGrid chain
Write to text file... 'outDirectory$'VowelSteps.TextGrid

#------

procedure AddErbScale f1min f1max f2min f2max garnish

# This procedure adds Erb scale tick marks and lines to a
# reversed-and-inverted-axes F1/F2 formant chart (the traditional style).
# The input parameters for minima and maxima must be in Hertz.
#
# Remember that if you want to use Hertz scale for drawing after this
# procedure, you have to redefine the axes!!!

#This line added by Michael Tyler
Select outer viewport... 0 6 0 5
#

Draw inner box

if garnish = 1
	Text top... no Erb
	Text right... no Erb
endif

f1min_Erb = hertzToErb (f1min)
f1max_Erb = hertzToErb (f1max)
f2min_Erb = hertzToErb (f2min)
f2max_Erb = hertzToErb (f2max)

Axes... -f2max_Erb -f2min_Erb -f1max_Erb -f1min_Erb

Marks top every... 1 1 no yes yes
Marks right every... 1 1 no yes yes

if garnish = 1
	One mark left... -f1max_Erb no no no 'f1max:0'
	One mark left... -f1min_Erb no no no 'f1min:0'
	One mark bottom... -f2max_Erb no no no 'f2max:0'
	One mark bottom... -f2min_Erb no no no 'f2min:0'
endif

f1scale = floor ((f1max - f1min) / 100)
f2scale = floor ((f2max - f2min) / 100)

for i to f2scale
	f2value = hertzToErb (f2min + (i * 100))
	if (f2min + (i * 100) = 1000 or f2min + (i * 100) = 2000) and garnish = 1
		mark = f2min + (i * 100)
		mark$ = "'mark:0'"
	else
		mark$ = ""
	endif
	One mark bottom... -f2value no yes no 'mark$'	
endfor

for y to f1scale
	f1value = hertzToErb (f1min + (y * 100))
	if (f1min + (y * 100) = 500 or f1min + (y * 100) = 1000) and garnish = 1
		mark = f1min + (y * 100)
		mark$ = "'mark:0'"
	else
		mark$ = ""
	endif
	One mark left... -f1value no yes no 'mark$'	
endfor


endproc

procedure AddAusEVowels

#These formant values are from the 50% point of vowels reported in
#Bundgaard-Nielsen et al. (2010) Applied Psycholinguistics

#Lax vowels only

Font size... 10

#ɒ
f1_hz_temp = 608
f2_hz_temp = 930
f1_erb_temp = hertzToErb(f1_hz_temp)
f2_erb_temp = hertzToErb(f2_hz_temp)
Paint circle... green -f2_erb_temp -f1_erb_temp 0.05
Text... -f2_erb_temp+0.3 Centre -f1_erb_temp Half ɒ

#ʌ
f1_hz_temp = 678
f2_hz_temp = 1171
f1_erb_temp = hertzToErb(f1_hz_temp)
f2_erb_temp = hertzToErb(f2_hz_temp)
Paint circle... green -f2_erb_temp -f1_erb_temp 0.05
Text... -f2_erb_temp+0.3 Centre -f1_erb_temp Half ʌ

#ʊ
f1_hz_temp = 385
f2_hz_temp = 951
f1_erb_temp = hertzToErb(f1_hz_temp)
f2_erb_temp = hertzToErb(f2_hz_temp)
Paint circle... green -f2_erb_temp -f1_erb_temp 0.05
Text... -f2_erb_temp+0.3 Centre -f1_erb_temp Half ʊ

#ɪ
f1_hz_temp = 342
f2_hz_temp = 2085
f1_erb_temp = hertzToErb(f1_hz_temp)
f2_erb_temp = hertzToErb(f2_hz_temp)
Paint circle... green -f2_erb_temp -f1_erb_temp 0.05
Text... -f2_erb_temp+0.3 Centre -f1_erb_temp Half ɪ

#ɛ
f1_hz_temp = 558
f2_hz_temp = 1829
f1_erb_temp = hertzToErb(f1_hz_temp)
f2_erb_temp = hertzToErb(f2_hz_temp)
Paint circle... green -f2_erb_temp -f1_erb_temp 0.05
Text... -f2_erb_temp+0.3 Centre -f1_erb_temp Half ɛ

#æ
f1_hz_temp = 695
f2_hz_temp = 1487
f1_erb_temp = hertzToErb(f1_hz_temp)
f2_erb_temp = hertzToErb(f2_hz_temp)
Paint circle... green -f2_erb_temp -f1_erb_temp 0.05
Text... -f2_erb_temp+0.3 Centre -f1_erb_temp Half æ

#Five tense vowels and two dipthongs

#i
f1_hz_temp = 317
f2_hz_temp = 2216
f1_erb_temp = hertzToErb(f1_hz_temp)
f2_erb_temp = hertzToErb(f2_hz_temp)
Paint circle... red -f2_erb_temp -f1_erb_temp 0.05
Text... -f2_erb_temp+0.3 Centre -f1_erb_temp Half i

#ɜ
f1_hz_temp = 504
f2_hz_temp = 1468
f1_erb_temp = hertzToErb(f1_hz_temp)
f2_erb_temp = hertzToErb(f2_hz_temp)
Paint circle... red -f2_erb_temp -f1_erb_temp 0.05
Text... -f2_erb_temp+0.3 Centre -f1_erb_temp Half ɜ

#a
f1_hz_temp = 682
f2_hz_temp = 1265
f1_erb_temp = hertzToErb(f1_hz_temp)
f2_erb_temp = hertzToErb(f2_hz_temp)
Paint circle... red -f2_erb_temp -f1_erb_temp 0.05
Text... -f2_erb_temp+0.3 Centre -f1_erb_temp Half a

#u
f1_hz_temp = 378
f2_hz_temp = 1544
f1_erb_temp = hertzToErb(f1_hz_temp)
f2_erb_temp = hertzToErb(f2_hz_temp)
Paint circle... red -f2_erb_temp -f1_erb_temp 0.05
Text... -f2_erb_temp+0.3 Centre -f1_erb_temp Half u

#ɔ
f1_hz_temp = 497
f2_hz_temp = 694
f1_erb_temp = hertzToErb(f1_hz_temp)
f2_erb_temp = hertzToErb(f2_hz_temp)
Paint circle... red -f2_erb_temp -f1_erb_temp 0.05
Text... -f2_erb_temp+0.3 Centre -f1_erb_temp Half ɔ

#eə
f1_hz_temp = 523
f2_hz_temp = 1869
f1_erb_temp = hertzToErb(f1_hz_temp)
f2_erb_temp = hertzToErb(f2_hz_temp)
Paint circle... red -f2_erb_temp -f1_erb_temp 0.05
Text... -f2_erb_temp+0.3 Centre -f1_erb_temp Half eə

#ɪə
f1_hz_temp = 325
f2_hz_temp = 2167
f1_erb_temp = hertzToErb(f1_hz_temp)
f2_erb_temp = hertzToErb(f2_hz_temp)
Paint circle... red -f2_erb_temp -f1_erb_temp 0.05
Text... -f2_erb_temp+0.3 Centre -f1_erb_temp Half ɪə
endproc
