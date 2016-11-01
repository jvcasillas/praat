# # ## ### ##### ########  #############  ##################### 
# Praat Script
# pseudo batch processing
#
# Matthew Winn
# August 2014
#
##################################
##################### 
############# 
######## 
#####
###
##
#
#
clearinfo
pause select all sounds to be used for this operation
numberOfSelectedSounds = numberOfSelected ("Sound")

for thisSelectedSound to numberOfSelectedSounds
	sound'thisSelectedSound' = selected("Sound",thisSelectedSound)
endfor

for thisSound from 1 to numberOfSelectedSounds
    select sound'thisSound'
	name$ = selected$("Sound")

    ## do your stuff here 
        
    # for example: display all intensities
    	#int = Get intensity (dB)
    	#print 'name$''tab$''int:2''newline$'


    # etc. 
endfor

#re-select the sounds
select sound1
for thisSound from 2 to numberOfSelectedSounds
    plus sound'thisSound'
endfor