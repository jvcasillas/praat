#####################################
# Praat script to create sythetic vowels            #
# 113 different F1-F2 vowel pairs                   #
# 339 total stimuli (three  duration values)     #
# male voice                                                  #
# Created by Joseph V. Casillas 4/10/2013   #
#                                                                  #
# Based on Chládková and Escudero, 2012  #
##################################

#############################
# Choose where to save the stimuli #
############################

form Save intervals to small WAV sound files
	comment Give the folder where to save the sound files:
	sentence Folder /Users/casillas/Desktop/test/
endform

####################
# create glottal source  #
###################

pitchTier = Create PitchTier... source 0 0.110
Add point... 0.0 150
Add point... 0.110 100
pulses = To PointProcess
Remove points between... 0 0.005
Remove points between... 0.105 0.110
source = To Sound (phonation)... 44100 0.6 0.05 0.7 0.03 3.0 4.0
select pitchTier
plus pulses
Remove
select source

#############################
# Create formant grids of all vowels #
#############################

#1st column
Create FormantGrid... 1 0.005 0.105 5 239.766 50 50 50
Formula (frequencies)... if row = 2 then 580.966 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 2 0.005 0.105 5 277.545 50 50 50
Formula (frequencies)... if row = 2 then 580.966 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 3 0.005 0.105 5 317.132 50 50 50
Formula (frequencies)... if row = 2 then 580.966 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 4 0.005 0.105 5 358.612 50 50 50
Formula (frequencies)... if row = 2 then 580.966 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 5 0.005 0.105 5 402.077 50 50 50
Formula (frequencies)... if row = 2 then 580.966 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 6 0.005 0.105 5 447.62 50 50 50
Formula (frequencies)... if row = 2 then 580.966 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

#2nd column
Create FormantGrid... 7 0.005 0.105 5 239.766 50 50 50
Formula (frequencies)... if row = 2 then 721.688 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 8 0.005 0.105 5 277.545 50 50 50
Formula (frequencies)... if row = 2 then 721.688 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 9 0.005 0.105 5 317.132 50 50 50
Formula (frequencies)... if row = 2 then 721.688 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 10 0.005 0.105 5 358.612 50 50 50
Formula (frequencies)... if row = 2 then 721.688 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 11 0.005 0.105 5 402.077 50 50 50
Formula (frequencies)... if row = 2 then 721.688 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 12 0.005 0.105 5 447.62 50 50 50
Formula (frequencies)... if row = 2 then 721.688 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 13 0.005 0.105 5 495.343 50 50 50
Formula (frequencies)... if row = 2 then 721.688 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 14 0.005 0.105 5 545.348 50 50 50
Formula (frequencies)... if row = 2 then 721.688 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 15 0.005 0.105 5 597.745 50 50 50
Formula (frequencies)... if row = 2 then 721.688 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

#3rd column
Create FormantGrid... 16 0.005 0.105 5 239.766 50 50 50
Formula (frequencies)... if row = 2 then 879.919 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 17 0.005 0.105 5 277.545 50 50 50
Formula (frequencies)... if row = 2 then 879.919 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 18 0.005 0.105 5 317.132 50 50 50
Formula (frequencies)... if row = 2 then 879.919 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 19 0.005 0.105 5 358.612 50 50 50
Formula (frequencies)... if row = 2 then 879.919 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 20 0.005 0.105 5 402.077 50 50 50
Formula (frequencies)... if row = 2 then 879.919 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 21 0.005 0.105 5 447.62 50 50 50
Formula (frequencies)... if row = 2 then 879.919 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 22 0.005 0.105 5 495.343 50 50 50
Formula (frequencies)... if row = 2 then 879.919 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 23 0.005 0.105 5 545.348 50 50 50
Formula (frequencies)... if row = 2 then 879.919 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 24 0.005 0.105 5 597.745 50 50 50
Formula (frequencies)... if row = 2 then 879.919 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 25 0.005 0.105 5 652.649 50 50 50
Formula (frequencies)... if row = 2 then 879.919 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 26 0.005 0.105 5 710.179 50 50 50
Formula (frequencies)... if row = 2 then 879.919 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 27 0.005 0.105 5 770.461 50 50 50
Formula (frequencies)... if row = 2 then 879.919 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

#4th column
Create FormantGrid... 28 0.005 0.105 5 239.766 50 50 50
Formula (frequencies)... if row = 2 then 1057.838 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 29 0.005 0.105 5 277.545 50 50 50
Formula (frequencies)... if row = 2 then 1057.838 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 30 0.005 0.105 5 317.132 50 50 50
Formula (frequencies)... if row = 2 then 1057.838 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 31 0.005 0.105 5 358.612 50 50 50
Formula (frequencies)... if row = 2 then 1057.838 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 32 0.005 0.105 5 402.077 50 50 50
Formula (frequencies)... if row = 2 then 1057.838 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 33 0.005 0.105 5 447.62 50 50 50
Formula (frequencies)... if row = 2 then 1057.838 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 34 0.005 0.105 5 495.343 50 50 50
Formula (frequencies)... if row = 2 then 1057.838 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 35 0.005 0.105 5 545.348 50 50 50
Formula (frequencies)... if row = 2 then 1057.838 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 36 0.005 0.105 5 597.745 50 50 50
Formula (frequencies)... if row = 2 then 1057.838 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 37 0.005 0.105 5 652.649 50 50 50
Formula (frequencies)... if row = 2 then 1057.838 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 38 0.005 0.105 5 710.179 50 50 50
Formula (frequencies)... if row = 2 then 1057.838 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 39 0.005 0.105 5 770.461 50 50 50
Formula (frequencies)... if row = 2 then 1057.838 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 40 0.005 0.105 5 833.627 50 50 50
Formula (frequencies)... if row = 2 then 1057.838 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 41 0.005 0.105 5 899.551 50 50 50
Formula (frequencies)... if row = 2 then 1067.838 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

#5th column
Create FormantGrid... 42 0.005 0.105 5 239.766 50 50 50
Formula (frequencies)... if row = 2 then 1257.895 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 43 0.005 0.105 5 277.545 50 50 50
Formula (frequencies)... if row = 2 then 1257.895 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 44 0.005 0.105 5 317.132 50 50 50
Formula (frequencies)... if row = 2 then 1257.895 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 45 0.005 0.105 5 358.612 50 50 50
Formula (frequencies)... if row = 2 then 1257.895 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 46 0.005 0.105 5 402.077 50 50 50
Formula (frequencies)... if row = 2 then 1257.895 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 47 0.005 0.105 5 447.62 50 50 50
Formula (frequencies)... if row = 2 then 1257.895 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 48 0.005 0.105 5 495.343 50 50 50
Formula (frequencies)... if row = 2 then 1257.895 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 49 0.005 0.105 5 545.348 50 50 50
Formula (frequencies)... if row = 2 then 1257.895 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 50 0.005 0.105 5 597.745 50 50 50
Formula (frequencies)... if row = 2 then 1257.895 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 51 0.005 0.105 5 652.649 50 50 50
Formula (frequencies)... if row = 2 then 1257.895 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 52 0.005 0.105 5 710.179 50 50 50
Formula (frequencies)... if row = 2 then 1257.895 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 53 0.005 0.105 5 770.461 50 50 50
Formula (frequencies)... if row = 2 then 1257.895 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 54 0.005 0.105 5 833.627 50 50 50
Formula (frequencies)... if row = 2 then 1257.895 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 55 0.005 0.105 5 899.551 50 50 50
Formula (frequencies)... if row = 2 then 1257.895 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi


#6th column
Create FormantGrid... 56 0.005 0.105 5 239.766 50 50 50
Formula (frequencies)... if row = 2 then 1482.844 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 57 0.005 0.105 5 277.545 50 50 50
Formula (frequencies)... if row = 2 then 1482.844 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 58 0.005 0.105 5 317.132 50 50 50
Formula (frequencies)... if row = 2 then 1482.844 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 59 0.005 0.105 5 358.612 50 50 50
Formula (frequencies)... if row = 2 then 1482.844 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 60 0.005 0.105 5 402.077 50 50 50
Formula (frequencies)... if row = 2 then 1482.844 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 61 0.005 0.105 5 447.62 50 50 50
Formula (frequencies)... if row = 2 then 1482.844 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 62 0.005 0.105 5 495.343 50 50 50
Formula (frequencies)... if row = 2 then 1482.844 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 63 0.005 0.105 5 545.348 50 50 50
Formula (frequencies)... if row = 2 then 1482.844 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 64 0.005 0.105 5 597.745 50 50 50
Formula (frequencies)... if row = 2 then 1482.844 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 65 0.005 0.105 5 652.649 50 50 50
Formula (frequencies)... if row = 2 then 1482.844 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 66 0.005 0.105 5 710.179 50 50 50
Formula (frequencies)... if row = 2 then 1482.844 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 67 0.005 0.105 5 770.461 50 50 50
Formula (frequencies)... if row = 2 then 1482.844 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 68 0.005 0.105 5 833.627 50 50 50
Formula (frequencies)... if row = 2 then 1482.844 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi

Create FormantGrid... 69 0.005 0.105 5 899.551 50 50 50
Formula (frequencies)... if row = 2 then 1482.844 else self fi
Formula (frequencies)... if row = 3 then 2500 else self fi
Formula (frequencies)... if row = 4 then 3500 else self fi
Formula (frequencies)... if row = 5 then 4500 else self fi


#7th column
Create FormantGrid... 70 0.005 0.105 5 239.766 50 50 50
Formula (frequencies)... if row = 2 then 1735.783 else self fi
Formula (frequencies)... if row = 3 then 2735.783 else self fi
Formula (frequencies)... if row = 4 then 3735.783 else self fi
Formula (frequencies)... if row = 5 then 4735.783 else self fi

Create FormantGrid... 71 0.005 0.105 5 277.545 50 50 50
Formula (frequencies)... if row = 2 then 1735.783 else self fi
Formula (frequencies)... if row = 3 then 2735.783 else self fi
Formula (frequencies)... if row = 4 then 3735.783 else self fi
Formula (frequencies)... if row = 5 then 4735.783 else self fi

Create FormantGrid... 72 0.005 0.105 5 317.132 50 50 50
Formula (frequencies)... if row = 2 then 1735.783 else self fi
Formula (frequencies)... if row = 3 then 2735.783 else self fi
Formula (frequencies)... if row = 4 then 3735.783 else self fi
Formula (frequencies)... if row = 5 then 4735.783 else self fi

Create FormantGrid... 73 0.005 0.105 5 358.612 50 50 50
Formula (frequencies)... if row = 2 then 1735.783 else self fi
Formula (frequencies)... if row = 3 then 2735.783 else self fi
Formula (frequencies)... if row = 4 then 3735.783 else self fi
Formula (frequencies)... if row = 5 then 4735.783 else self fi

Create FormantGrid... 74 0.005 0.105 5 402.077 50 50 50
Formula (frequencies)... if row = 2 then 1735.783 else self fi
Formula (frequencies)... if row = 3 then 2735.783 else self fi
Formula (frequencies)... if row = 4 then 3735.783 else self fi
Formula (frequencies)... if row = 5 then 4735.783 else self fi

Create FormantGrid... 75 0.005 0.105 5 447.62 50 50 50
Formula (frequencies)... if row = 2 then 1735.783 else self fi
Formula (frequencies)... if row = 3 then 2735.783 else self fi
Formula (frequencies)... if row = 4 then 3735.783 else self fi
Formula (frequencies)... if row = 5 then 4735.783 else self fi

Create FormantGrid... 76 0.005 0.105 5 495.343 50 50 50
Formula (frequencies)... if row = 2 then 1735.783 else self fi
Formula (frequencies)... if row = 3 then 2735.783 else self fi
Formula (frequencies)... if row = 4 then 3735.783 else self fi
Formula (frequencies)... if row = 5 then 4735.783 else self fi

Create FormantGrid... 77 0.005 0.105 5 545.348 50 50 50
Formula (frequencies)... if row = 2 then 1735.783 else self fi
Formula (frequencies)... if row = 3 then 2735.783 else self fi
Formula (frequencies)... if row = 4 then 3735.783 else self fi
Formula (frequencies)... if row = 5 then 4735.783 else self fi

Create FormantGrid... 78 0.005 0.105 5 597.745 50 50 50
Formula (frequencies)... if row = 2 then 1735.783 else self fi
Formula (frequencies)... if row = 3 then 2735.783 else self fi
Formula (frequencies)... if row = 4 then 3735.783 else self fi
Formula (frequencies)... if row = 5 then 4735.783 else self fi

Create FormantGrid... 79 0.005 0.105 5 652.649 50 50 50
Formula (frequencies)... if row = 2 then 1735.783 else self fi
Formula (frequencies)... if row = 3 then 2735.783 else self fi
Formula (frequencies)... if row = 4 then 3735.783 else self fi
Formula (frequencies)... if row = 5 then 4735.783 else self fi

Create FormantGrid... 80 0.005 0.105 5 710.179 50 50 50
Formula (frequencies)... if row = 2 then 1735.783 else self fi
Formula (frequencies)... if row = 3 then 2735.783 else self fi
Formula (frequencies)... if row = 4 then 3735.783 else self fi
Formula (frequencies)... if row = 5 then 4735.783 else self fi

Create FormantGrid... 81 0.005 0.105 5 770.461 50 50 50
Formula (frequencies)... if row = 2 then 1735.783 else self fi
Formula (frequencies)... if row = 3 then 2735.783 else self fi
Formula (frequencies)... if row = 4 then 3735.783 else self fi
Formula (frequencies)... if row = 5 then 4735.783 else self fi

Create FormantGrid... 82 0.005 0.105 5 833.627 50 50 50
Formula (frequencies)... if row = 2 then 1735.783 else self fi
Formula (frequencies)... if row = 3 then 2735.783 else self fi
Formula (frequencies)... if row = 4 then 3735.783 else self fi
Formula (frequencies)... if row = 5 then 4735.783 else self fi

Create FormantGrid... 83 0.005 0.105 5 899.551 50 50 50
Formula (frequencies)... if row = 2 then 1735.783 else self fi
Formula (frequencies)... if row = 3 then 2735.783 else self fi
Formula (frequencies)... if row = 4 then 3735.783 else self fi
Formula (frequencies)... if row = 5 then 4735.783 else self fi


#8th column
Create FormantGrid... 84 0.005 0.105 5 239.766 50 50 50
Formula (frequencies)... if row = 2 then 2020.193 else self fi
Formula (frequencies)... if row = 3 then 3020.193 else self fi
Formula (frequencies)... if row = 4 then 4020.193 else self fi
Formula (frequencies)... if row = 5 then 5020.193 else self fi

Create FormantGrid... 85 0.005 0.105 5 277.545 50 50 50
Formula (frequencies)... if row = 2 then 2020.193 else self fi
Formula (frequencies)... if row = 3 then 3020.193 else self fi
Formula (frequencies)... if row = 4 then 4020.193 else self fi
Formula (frequencies)... if row = 5 then 5020.193 else self fi

Create FormantGrid... 86 0.005 0.105 5 317.132 50 50 50
Formula (frequencies)... if row = 2 then 2020.193 else self fi
Formula (frequencies)... if row = 3 then 3020.193 else self fi
Formula (frequencies)... if row = 4 then 4020.193 else self fi
Formula (frequencies)... if row = 5 then 5020.193 else self fi

Create FormantGrid... 87 0.005 0.105 5 358.612 50 50 50
Formula (frequencies)... if row = 2 then 2020.193 else self fi
Formula (frequencies)... if row = 3 then 3020.193 else self fi
Formula (frequencies)... if row = 4 then 4020.193 else self fi
Formula (frequencies)... if row = 5 then 5020.193 else self fi

Create FormantGrid... 88 0.005 0.105 5 402.077 50 50 50
Formula (frequencies)... if row = 2 then 2020.193 else self fi
Formula (frequencies)... if row = 3 then 3020.193 else self fi
Formula (frequencies)... if row = 4 then 4020.193 else self fi
Formula (frequencies)... if row = 5 then 5020.193 else self fi

Create FormantGrid... 89 0.005 0.105 5 447.62 50 50 50
Formula (frequencies)... if row = 2 then 2020.193 else self fi
Formula (frequencies)... if row = 3 then 3020.193 else self fi
Formula (frequencies)... if row = 4 then 4020.193 else self fi
Formula (frequencies)... if row = 5 then 5020.193 else self fi

Create FormantGrid... 90 0.005 0.105 5 495.343 50 50 50
Formula (frequencies)... if row = 2 then 2020.193 else self fi
Formula (frequencies)... if row = 3 then 3020.193 else self fi
Formula (frequencies)... if row = 4 then 4020.193 else self fi
Formula (frequencies)... if row = 5 then 5020.193 else self fi

Create FormantGrid... 91 0.005 0.105 5 545.348 50 50 50
Formula (frequencies)... if row = 2 then 2020.193 else self fi
Formula (frequencies)... if row = 3 then 3020.193 else self fi
Formula (frequencies)... if row = 4 then 4020.193 else self fi
Formula (frequencies)... if row = 5 then 5020.193 else self fi

Create FormantGrid... 92 0.005 0.105 5 597.745 50 50 50
Formula (frequencies)... if row = 2 then 2020.193 else self fi
Formula (frequencies)... if row = 3 then 3020.193 else self fi
Formula (frequencies)... if row = 4 then 4020.193 else self fi
Formula (frequencies)... if row = 5 then 5020.193 else self fi

Create FormantGrid... 93 0.005 0.105 5 652.649 50 50 50
Formula (frequencies)... if row = 2 then 2020.193 else self fi
Formula (frequencies)... if row = 3 then 3020.193 else self fi
Formula (frequencies)... if row = 4 then 4020.193 else self fi
Formula (frequencies)... if row = 5 then 5020.193 else self fi

Create FormantGrid... 94 0.005 0.105 5 710.179 50 50 50
Formula (frequencies)... if row = 2 then 2020.193 else self fi
Formula (frequencies)... if row = 3 then 3020.193 else self fi
Formula (frequencies)... if row = 4 then 4020.193 else self fi
Formula (frequencies)... if row = 5 then 5020.193 else self fi

Create FormantGrid... 95 0.005 0.105 5 770.461 50 50 50
Formula (frequencies)... if row = 2 then 2020.193 else self fi
Formula (frequencies)... if row = 3 then 3020.193 else self fi
Formula (frequencies)... if row = 4 then 4020.193 else self fi
Formula (frequencies)... if row = 5 then 5020.193 else self fi

Create FormantGrid... 96 0.005 0.105 5 833.627 50 50 50
Formula (frequencies)... if row = 2 then 2020.193 else self fi
Formula (frequencies)... if row = 3 then 3020.193 else self fi
Formula (frequencies)... if row = 4 then 4020.193 else self fi
Formula (frequencies)... if row = 5 then 5020.193 else self fi

Create FormantGrid... 97 0.005 0.105 5 899.551 50 50 50
Formula (frequencies)... if row = 2 then 2020.193 else self fi
Formula (frequencies)... if row = 3 then 3020.193 else self fi
Formula (frequencies)... if row = 4 then 4020.193 else self fi
Formula (frequencies)... if row = 5 then 5020.193 else self fi


#9th column
Create FormantGrid... 98 0.005 0.105 5 239.766 50 50 50
Formula (frequencies)... if row = 2 then 2339.993 else self fi
Formula (frequencies)... if row = 3 then 3339.993 else self fi
Formula (frequencies)... if row = 4 then 4339.993 else self fi
Formula (frequencies)... if row = 5 then 5339.993 else self fi

Create FormantGrid... 99 0.005 0.105 5 277.545 50 50 50
Formula (frequencies)... if row = 2 then 2339.993 else self fi
Formula (frequencies)... if row = 3 then 3339.993 else self fi
Formula (frequencies)... if row = 4 then 4339.993 else self fi
Formula (frequencies)... if row = 5 then 5339.993 else self fi

Create FormantGrid... 100 0.005 0.105 5 317.132 50 50 50
Formula (frequencies)... if row = 2 then 2339.993 else self fi
Formula (frequencies)... if row = 3 then 3339.993 else self fi
Formula (frequencies)... if row = 4 then 4339.993 else self fi
Formula (frequencies)... if row = 5 then 5339.993 else self fi

Create FormantGrid... 101 0.005 0.105 5 358.612 50 50 50
Formula (frequencies)... if row = 2 then 2339.993 else self fi
Formula (frequencies)... if row = 3 then 3339.993 else self fi
Formula (frequencies)... if row = 4 then 4339.993 else self fi
Formula (frequencies)... if row = 5 then 5339.993 else self fi

Create FormantGrid... 102 0.005 0.105 5 402.077 50 50 50
Formula (frequencies)... if row = 2 then 2339.993 else self fi
Formula (frequencies)... if row = 3 then 3339.993 else self fi
Formula (frequencies)... if row = 4 then 4339.993 else self fi
Formula (frequencies)... if row = 5 then 5339.993 else self fi

Create FormantGrid... 103 0.005 0.105 5 447.62 50 50 50
Formula (frequencies)... if row = 2 then 2339.993 else self fi
Formula (frequencies)... if row = 3 then 3339.993 else self fi
Formula (frequencies)... if row = 4 then 4339.993 else self fi
Formula (frequencies)... if row = 5 then 5339.993 else self fi

Create FormantGrid... 104 0.005 0.105 5 495.343 50 50 50
Formula (frequencies)... if row = 2 then 2339.993 else self fi
Formula (frequencies)... if row = 3 then 3339.993 else self fi
Formula (frequencies)... if row = 4 then 4339.993 else self fi
Formula (frequencies)... if row = 5 then 5339.993 else self fi

Create FormantGrid... 105 0.005 0.105 5 545.348 50 50 50
Formula (frequencies)... if row = 2 then 2339.993 else self fi
Formula (frequencies)... if row = 3 then 3339.993 else self fi
Formula (frequencies)... if row = 4 then 4339.993 else self fi
Formula (frequencies)... if row = 5 then 5339.993 else self fi

Create FormantGrid... 106 0.005 0.105 5 597.745 50 50 50
Formula (frequencies)... if row = 2 then 2339.993 else self fi
Formula (frequencies)... if row = 3 then 3339.993 else self fi
Formula (frequencies)... if row = 4 then 4339.993 else self fi
Formula (frequencies)... if row = 5 then 5339.993 else self fi


#10th column
Create FormantGrid... 107 0.005 0.105 5 239.766 50 50 50
Formula (frequencies)... if row = 2 then 2699.583 else self fi
Formula (frequencies)... if row = 3 then 3699.583 else self fi
Formula (frequencies)... if row = 4 then 4699.583 else self fi
Formula (frequencies)... if row = 5 then 5699.583 else self fi

Create FormantGrid... 108 0.005 0.105 5 277.545 50 50 50
Formula (frequencies)... if row = 2 then 2699.583 else self fi
Formula (frequencies)... if row = 3 then 3699.583 else self fi
Formula (frequencies)... if row = 4 then 4699.583 else self fi
Formula (frequencies)... if row = 5 then 5699.583 else self fi

Create FormantGrid... 109 0.005 0.105 5 317.132 50 50 50
Formula (frequencies)... if row = 2 then 2699.583 else self fi
Formula (frequencies)... if row = 3 then 3699.583 else self fi
Formula (frequencies)... if row = 4 then 4699.583 else self fi
Formula (frequencies)... if row = 5 then 5699.583 else self fi

Create FormantGrid... 110 0.005 0.105 5 358.612 50 50 50
Formula (frequencies)... if row = 2 then 2699.583 else self fi
Formula (frequencies)... if row = 3 then 3699.583 else self fi
Formula (frequencies)... if row = 4 then 4699.583 else self fi
Formula (frequencies)... if row = 5 then 5699.583 else self fi

Create FormantGrid... 111 0.005 0.105 5 402.077 50 50 50
Formula (frequencies)... if row = 2 then 2699.583 else self fi
Formula (frequencies)... if row = 3 then 3699.583 else self fi
Formula (frequencies)... if row = 4 then 4699.583 else self fi
Formula (frequencies)... if row = 5 then 5699.583 else self fi

Create FormantGrid... 112 0.005 0.105 5 447.62 50 50 50
Formula (frequencies)... if row = 2 then 2699.583 else self fi
Formula (frequencies)... if row = 3 then 3699.583 else self fi
Formula (frequencies)... if row = 4 then 4699.583 else self fi
Formula (frequencies)... if row = 5 then 5699.583 else self fi

Create FormantGrid... 113 0.005 0.105 5 495.343 50 50 50
Formula (frequencies)... if row = 2 then 2699.583 else self fi
Formula (frequencies)... if row = 3 then 3699.583 else self fi
Formula (frequencies)... if row = 4 then 4699.583 else self fi
Formula (frequencies)... if row = 5 then 5699.583 else self fi

####################################
# Filter formant grids through glottal source #
###################################

for i from 1 to 113
	select Sound source
	plus FormantGrid 'i'
	Filter
	Rename... 'i'_1
endfor

##########
# clean up #
#########

select Sound source
Remove

for i from 1 to 113
	select FormantGrid 'i'
	Remove
endfor

########################
# Now start with the duration #
########################

#################
# medium duration #
################

# starting time of the vowel as measured by hand
vowelStart = 0

# ending time of the vowel as measured by hand
vowelEnd = 0.100

targetDur = 0.141

# duration in seconds of the actual vowel as it exists currently
initialDur = vowelEnd - vowelStart

ratio = targetDur/initialDur

for i from 1 to 113
	select Sound 'i'_1
	To Manipulation... 0.01 75 600
	Edit
 
	editor Manipulation 'i'_1
		# Just before the start of the vowel
		Add duration point at... 'vowelStart'-0.001 1.0
		# Just after the end of the vowel
		Add duration point at... 'vowelEnd'+0.001 1.0
		# The actual start of the vowel
		Add duration point at... 'vowelStart' 'ratio'
		# The actual end of the vowel
		Add duration point at... 'vowelEnd' 'ratio'
		Publish resynthesis
	endeditor

	Resample... 22050 1
	Scale... 0.99
	#Scale intensity... 70 If we put intensity here - it scales the whole file

	duration = Get duration
	Rename... 'i'_2
	select Sound fromManipulationEditor
	Remove
	select Manipulation 'i'_1
	Remove
endfor


################
# longest duration #
###############

# starting time of the vowel as measured by hand
vowelStart = 0

# ending time of the vowel as measured by hand
vowelEnd = 0.100

targetDur = 0.200

# duration in seconds of the actual vowel as it exists currently
initialDur = vowelEnd - vowelStart

ratio = targetDur/initialDur

for i from 1 to 113
	select Sound 'i'_1
	To Manipulation... 0.01 75 600
	Edit
 
	editor Manipulation 'i'_1
		# Just before the start of the vowel
		Add duration point at... 'vowelStart'-0.001 1.0
		# Just after the end of the vowel
		Add duration point at... 'vowelEnd'+0.001 1.0
		# The actual start of the vowel
		Add duration point at... 'vowelStart' 'ratio'
		# The actual end of the vowel
		Add duration point at... 'vowelEnd' 'ratio'
		Publish resynthesis
	endeditor

	Resample... 22050 1
	Scale... 0.99
	#Scale intensity... 70 If we put intensity here - it scales the whole file

	duration = Get duration
	Rename... 'i'_3
	select Sound fromManipulationEditor
	Remove
	select Manipulation 'i'_1
	Remove
endfor

#############
# save all files #
############

select all
k = numberOfSelected ("Sound")
for i from 1 to k
	sound'i'= selected ("Sound",i)
endfor

for i from 1 to k
	select sound'i'
	sound$ = selected$("Sound")
	printline 'sound$'
	Save as WAV file... 'folder$''sound$'.wav
endfor