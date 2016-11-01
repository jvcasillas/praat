#
#       Praat Script: ACOUSTIC ANALYSIS
#
#	This script prints waveform, spectrogram, formants, pitch, and intensity of 
#	a sound file into the 'Praat picture' window. It will print the name of the 
#	file as a headline. I use it with students at christmas so they can get an 
#	acoustic analysis of their names on one printout which is usually something 
#	that phoneticians like to hang up at home or print on their t-shirts - the 
#	more complicated the graphs look the better ;-) 
#
#                                     written by Floki
#


### Create user interface window #############################################################
form waveform & spectrogram printer
   comment Please specify your name:
      text name Volker
   comment Please specify the path of the sound file you want to print?
      text path C:\Dokumente und Einstellungen\Flok\Desktop
   comment Please specify the name of the sound file you want to print?
      text filename testfile.wav
   comment What sex are you? (This is relevant for measuring your formants)
      optionmenu sex: 2
      option male
      option female
endform


### Read file and remove '.wav' extension for variable #######################################
Read from file... 'path$'\'filename$'
filename$ = filename$ -".wav"
if sex = 1
  maxFormant = 5000
  maxPitch = 300
elsif sex = 2
  maxFormant = 5500
  maxPitch = 400
endif


### Graphical output of the waveform #########################################################
Erase all
Line width... 1

# Print headline:
Font size... 28
Maroon
Viewport... 0.3 7.5 0.5 1
Viewport text... Centre Half 0 Acoustic analysis of the name "'name$'"

# Print names:
Font size... 18
Viewport... 7 7.5 1.5 3
Viewport text... Centre Half 270 waveform
Viewport... 7 7.5 4 7
Viewport text... Centre Half 270 spectrogram & formants
Viewport... 7 7.5 8 9
Viewport text... Centre Half 270 pitch & intensity

# Waveform:
minAmp = Get minimum... 0 0 Sinc70
maxAmp = Get maximum... 0 0 Sinc70
Viewport... 0.3 7.5 1 3.5
Font size... 12
Red
Draw... 0 0 'minAmp' 'maxAmp' 1

# Spetrogram:
To Spectrogram... 0.005 maxFormant 0.002 20 Gaussian
Viewport... 0.3 7.5 3.5 7.5
Paint... 0 0 0 0 100 yes 50 6 0 yes

# Formants:
select Sound 'filename$'
To Formant (burg)... 0.0 5 maxFormant 0.025 50
Viewport... 0.3 7.5 3.5 7.5
Speckle... 0 0 5000 30 no

# Pitch:
select Sound 'filename$'
To Pitch... 0.0 75 600
Viewport... 0.3 4 7.5 9.5
Speckle... 0 0 0 maxPitch yes

# Intensity:
select Sound 'filename$'
To Intensity... 100 0
Viewport... 4 7.5 7.5 9.5
Draw... 0 0 0 0 yes


### Save graphical output in file ############################################################
Viewport... 0 7.8 0 9.8
Write to Windows metafile... 'path$'\'name$'.emf