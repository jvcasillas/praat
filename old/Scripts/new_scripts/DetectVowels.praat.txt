#########################################################################
#### This script takes the selected sound object, and finds all of the vowels in it
#### then it does a formant analysis on the vowel and makes a plot
#### 2006 Robert Felty
#########################################################################

###uses selected sound.  A portion must be highlighted
use_sound$ = selected$ ("Sound")

To Intensity... 100 0.01
n = Get number of frames
maxIntensity = Get maximum... 0 0 Parabolic
cutOffIntensity = maxIntensity*0.85
#test = Get time from frame... 64
#echo test 'test'
#exit
select Sound 'use_sound$'
noprogress To Pitch (ac)... 0 75 15 no 0.03 0.65 0.01 0.35 0.5 600
#noprogress To Pitch... 0.01 75 600
#x=73
printline -----------------------------------------------------------
printline sound = 'use_sound$'
printline max = 'maxIntensity:3'  cutoff = 'cutOffIntensity:3'
#echo 'n'
#var = Get value in frame... n

vowelOn=0

#keep track of the total number of vowels
numVowels=0

#loop over all frames
for i to n
  #get intensity in decibels
  select Intensity 'use_sound$'
  intensity = Get value in frame... i
  #echo var

  if vowelOn=0 && numVowels<1
    if intensity > cutOffIntensity
      #check for voicing
      select Pitch 'use_sound$' 
      checkVoicing = Get value in frame... 'i'+1 Hertz
      #printline pitch = 'checkVoicing'
      if checkVoicing = undefined
      else
        select Intensity 'use_sound$'
        numVowels=numVowels+1
        vowelBegin = Get time from frame... i 
        printline vowel on at: 'vowelBegin:3' seconds.
        vowelOn=1
      endif
      #exit
    endif
  else
    select Pitch 'use_sound$' 
    checkVoicing = Get value in frame... 'i'+1 Hertz
    if checkVoicing = undefined || intensity < cutOffIntensity
      vowelOn=0
      vowelEnd = Get time from frame... i
      i=n
      printline vowel off at: 'vowelEnd:3' seconds.
      vowel25 = vowelBegin + 0.25*(vowelEnd-vowelBegin)
      vowel50 = vowelBegin + 0.5*(vowelEnd-vowelBegin)
      vowel75 = vowelBegin + 0.75*(vowelEnd-vowelBegin)
      
      plus Intensity 'use_sound$'
      Remove
      select Sound 'use_sound$'
      #extract just the vowel (plus 20 ms padding on either side)
      Extract part... 'vowelBegin'-0.02 'vowelEnd'+0.02 Rectangular 1 yes

      #get f0 information      
      select Sound 'use_sound$'_part 
      noprogress To Pitch... 0 75 600
      
      vowel25f0 = Get value at time... 'vowel25' Hertz Linear
      vowel50f0 = Get value at time... 'vowel50' Hertz Linear
      vowel75f0 = Get value at time... 'vowel75' Hertz Linear
      #transform into bark scale according to Syrdal and Gopal 1986
      call hertz2bark vowel25f0
      vowel25f0 = barkFreq
      call hertz2bark vowel50f0
      vowel50f0 = barkFreq
      call hertz2bark vowel75f0
      vowel75f0 = barkFreq
      procedure hertz2bark hertzFreq
	if hertzFreq < 150
	  hertzFreq = 150
	elsif hertzFreq > 250
	  hertzFreq = hertzFreq
	elsif hertzFreq > 200
	  hertzFreq = hertzFreq - 0.2*(250 - hertzFreq)
	elsif hertzFreq > 150
	  hertzFreq = hertzFreq - 0.2*(hertzFreq - 150)
	endif
	#barkFreq = 13*arctan(0.76*hertzFreq) + 3.5*(arctan((hertzFreq/7.5)^2))
        barkFreq =hertzToBark('hertzFreq')
      endproc


      #create formant object
      select Sound 'use_sound$'_part 
      noprogress To Formant (burg)... 0 6 4000 0.025 50
      #this sets the formant Units
      formantUnit$ = "Bark"
      #get f1, f2, f3 values at 25%, midpoint and 75% of vowel
      procedure getFormants
	vowel25f1 = Get value at time... 1 'vowel25' 'formantUnit$' Linear
	vowel25f2 = Get value at time... 2 'vowel25' 'formantUnit$' Linear
	vowel25f3 = Get value at time... 3 'vowel25' 'formantUnit$' Linear
	vowel50f1 = Get value at time... 1 'vowel50' 'formantUnit$' Linear
	vowel50f2 = Get value at time... 2 'vowel50' 'formantUnit$' Linear
	vowel50f3 = Get value at time... 3 'vowel50' 'formantUnit$' Linear
	vowel75f1 = Get value at time... 1 'vowel75' 'formantUnit$' Linear
	vowel75f2 = Get value at time... 2 'vowel75' 'formantUnit$' Linear
	vowel75f3 = Get value at time... 3 'vowel75' 'formantUnit$' Linear
	printline vowel25: f0 'vowel25f0:2' f1 'vowel25f1:2' f2 'vowel25f2:2' f3 'vowel25f3:2'
	printline vowel50: f0 'vowel25f0:2' f1 'vowel50f1:2' f2 'vowel50f2:2' f3 'vowel50f3:2'
	printline vowel75: f0 'vowel25f0:2' f1 'vowel75f1:2' f2 'vowel75f2:2' f3 'vowel75f3:2'
      endproc
      call getFormants
      #redo formants for [u] and [o], with 0 to 4000 Hz and 6 formants
      
      if (vowel25f3 < 14 || vowel50f3 < 14 || vowel75f3 < 14) && (vowel25f2 > 6 || vowel50f2 > 6 || vowel75f2 >6)
	printline redoing formants == formants = 5 max = 4500
	select Formant 'use_sound$'_part
        Remove
	select Sound 'use_sound$'_part
	noprogress To Formant (burg)... 0 5 4000 0.025 50
	call getFormants
      endif
      if ((vowel25f2 > 9 || vowel50f2 > 9 || vowel75f2 > 9) && (vowel25f3 < 14 || vowel50f3 < 14 || vowel75f3 < 14)) || (max(vowel25f3, vowel50f3, vowel75f3)-min(vowel25f3, vowel50f3, vowel75f3)>4)
	select Formant 'use_sound$'_part
        Remove
        select Sound 'use_sound$'_part
        noprogress To Formant (burg)... 0 5 5000 0.025 50
	printline redoing formants == formants = 5 max = 5000
	call getFormants
      endif 
      
      #check to see if it is a dipthong
      #f1diff = abs(vowel75f1 - vowel25f1)/max(vowel75f1, vowel25f1)
      #f2diff = abs(vowel75f2 - vowel25f2)/max(vowel75f2, vowel25f2)
      #if f1diff>0.1 || f2diff>0.1
      f1diff = abs(vowel75f1 - vowel25f1)
      f2diff = abs(vowel75f2 - vowel25f2)
      if f1diff>0.75 || f2diff>0.75
        printline DIPHTHONG 
	height1 = vowel25f1 - vowel25f0
	front1 = vowel25f3 - vowel25f2
	height2 = vowel75f1 - vowel75f0
	front2 = vowel75f3 - vowel75f2
	Red
	Line width... 1
	Draw arrow... 'front1' 'height1' 'front2' 'height2'
        Text special... 'front1' Centre 'height1'-0.5 Half Times 10 0 'use_sound$'
	printline f1diff: 'f1diff:2' f2diff 'f2diff:2'
	printline f0 'f0:1' f1 'f1:1' f2 'f2:1' f3 'f3:1'
	printline front: 'front1:2' - 'front2:2' height: 'height1:2' - 'height2:2'

      else
        #f0 = (vowel25f0 + vowel50f0 + vowel75f0)/3
        #f1 = (vowel25f1 + vowel50f1 + vowel75f1)/3
        #f2 = (vowel25f2 + vowel50f2 + vowel75f2)/3
        #f3 = (vowel25f3 + vowel50f3 + vowel75f3)/3
        f0 = vowel50f0
        f1 = vowel50f1
        f2 = vowel50f2
        f3 = vowel50f3
	height = f1 - f0
	front = f3 - f2
        #put point on plot
        Black
        Text special... 'front' Centre 'height' Half Times 10 0 'use_sound$'
        #Paint circle (mm)... black 'front' 'height' 2
	printline f1diff: 'f1diff:2' f2diff 'f2diff:2'
	printline f0 'f0:1' f1 'f1:1' f2 'f2:1' f3 'f3:1'
	printline front: 'front:2' height: 'height:2'
      endif
    endif
  endif
endfor
plus Sound 'use_sound$'_part
plus Pitch 'use_sound$'_part
Remove
printline number of vowels = 'numVowels'




