######################################################################
#### Robert Felty <robfelty - umich.edu>
#### 2006
#### This script comes with no warranty. Use at your own risk

## this script reads in a wordlist, in a one stimulus per line textfile, 
## and prompts a speaker to speak each word in a carrier phrase
## "say X again", it records for X seconds, then writes the sound to a file 
## named according to the stimulus, plus an integer from 1 to i, which 
## represents the repition number.

#### N.B. MAKE SURE WHEN THIS SCRIPT IS STARTED THAT ANY RECORDING WINDOWS IN 
#### PRAAT ARE CLOSED 
#### ALSO MAKE SURE THAT THE OUTDIR ALREADY EXISTS
######################################################################

#where to find and put files
infile$ = "stimfile.txt"
outdir$ = "stimuli/"



Read Strings from raw text file... 'infile$'
Randomize
i = 1
numrep = 3
recordTime = 4
#pause after this many words
pauseCount=5 
rep=1
listlength = Get number of strings
#exit
#print out instructions to the talker
echo Welcome to the recording session.  'newline$' You will be asked to speak a series of words (or pseudo-words), which will be recorded.  'newline$' After you click continue, a short phrase will be displayed, and the computer will record for 4 seconds.  'newline$' Once the phrase appears you should repeat it in a normal speaking pattern.  'newline$'After the 4 seconds of recording, a dialog will appear asking you to click continue to record the next word.  'newline$'This will continue until all words have been recorded.  'newline$'If you need a break, simply take one before clicking continue.
pause Click continue to begin

for j from 1 to numrep
  for i from 1 to 'listlength'
    word$ = Get string... 'i'
    print 'word$'
    echo Say "'word$'" again

    Record Sound (fixed time)... Microphone 0.99 0.5 44100 recordTime
    Write to WAV file... 'outdir$'/'word$''j'.wav

    #select Sound
    Remove
    select Strings stimfile
    if rep=pauseCount
      pause click continue to record next word
      rep=0
    endif
    rep=rep+1
  endfor
endfor
pause You have successfully completed the recording.  Thank you very much for your time.  Please tell the experimenter that you are done.