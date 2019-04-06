### 
### MFC wizard (en)
### v0.2, 2013-06-19, jm
### 

# Welcome form
beginPause ("ExperimentMFC: experiment file creation wizard")
	comment ("Welcome to the experiment file creation wizard.")
	comment ("Before you continue, make sure that you have a dedicated directory (folder)")
	comment ("where the experiment file will be saved and a dedicated subdirectory")
	comment ("which contains all necessary sound files (stimuli/responses, carrier phrase).")
	comment ("All sound files must be of the same format (e.g. wav)")
	comment ("and must have the same sampling frequency")
	comment ("and the same number of channels (mono/stereo)!")
	comment (" ")
	comment ("In the next step you will be asked for your experiment directory.")
clicked = endPause ("Cancel", "Next", 2, 1)
if clicked = 1
	exit The experiment file was not created.
endif

# Choose experiment directory
directoryName$ = chooseDirectory$ ("Choose your experiment directory (folder)")
if directoryName$ = ""
	exit The experiment file was not created.
endif

# list of subdirectories
subdirlistID = do ("Create Strings as directory list...", "subdirlist", directoryName$)
no_sd = do ("Get number of strings")
if no_sd = 0
	exit There is no subdirectory in this directory. Please create a subdirectory which contains all your experimental sound files. The experiment file was not created.
endif
for i to no_sd
	selectObject (subdirlistID)
	dir$[i] = do$ ("Get string...", i)
endfor

# file name and stimulus/response type
beginPause ("File name and stimulus type")
	comment ("Name of the experiment file; the suffix '.mfc' will be added automatically")
	sentence ("FileName", "myexperiment")
	comment (" ")
	comment ("Specify stimulus and response type.")
	comment ("Standard: stimuli are sounds, responses are categories (text/pictures)")
	comment ("Reverse: stimuli are categories (text), responses are sounds")
	choice ("StimuliResponses", 1)
		option ("Standard (stimuli = sounds)")
		option ("Reverse (stimuli = categories)")
clicked = endPause ("Cancel", "Next", 2, 1)
if clicked = 1
	exit The experiment file was not created.
endif

# forms for stimuli-related parameters
if stimuliResponses = 1
	### STIMULI ARE SOUNDS
	stimuliAreSounds$ = "yes"
	responsesAreSounds$ = "no"
	# set parameters for categorical responses
	rSubdirectory$ = ""
	rSuffix$ = ""
	rCarrierBefore$ = ""
	rCarrierAfter$ = ""
	rSilenceBefore = 0
	rSilenceBetween = 0
	rSilenceAfter = 0
	
	# subdirectory, sound file suffix, and carrier(s)
	beginPause ("Stimuli are Sounds I")
		comment ("Choose the subdirectory which contains all your stimuli sound files.")
		choice ("Subdirectory", 0)
			for i to no_sd
				option (dir$[i])
			endfor
		comment ("The suffix of your sound files (in most cases 'wav');")
		comment ("upper/lower case does matter!")
		word ("Suffix", "wav")
		comment ("Do you have sound files for a carrier phrase?")
		comment ("If you do, please fill in the name(s) (without suffix)")
		comment ("of the appropriate sound file(s).")
		comment ("If you don't, just leave the fields empty.")
		sentence ("StimulusCarrierBefore", "")
		sentence ("StimulusCarrierAfter", "")
	clicked = endPause ("Cancel", "Next", 2, 1)
	if clicked = 1
		exit The experiment file was not created.
	endif
	sSubdirectory$ = subdirectory$
	sSuffix$ = "." + suffix$
	sCarrierBefore$ = stimulusCarrierBefore$
	sCarrierAfter$ = stimulusCarrierAfter$
	
	# list sound files
	sfilelistID = do ("Create Strings as file list...", "sfilelist", directoryName$ + "/" + sSubdirectory$ + "/*" + sSuffix$)
	no_sf_all = do ("Get number of strings")
	if no_sf_all = 0
		exit No sound files in this subdirectory. The experiment file was not created.
	endif
	
	# delete carrier(s) from sound file list
	if sCarrierBefore$ = "" && sCarrierAfter$ = ""
		no_sf = no_sf_all
	elsif sCarrierBefore$ <> ""
		teststring1$ = sCarrierBefore$ + sSuffix$
		for i to no_sf_all
			selectObject (sfilelistID)
			teststring2$ = do$ ("Get string...", i)
			if teststring1$ = teststring2$
				beforeStringPosition = i
			endif
		endfor
		do ("Remove string...", beforeStringPosition)
		no_sf_all = no_sf_all - 1
		no_sf = no_sf_all
	elsif sCarrierAfter$ <> ""
		teststring1$ = sCarrierAfter$ + sSuffix$
		for i to no_sf_all
			selectObject (sfilelistID)
			teststring2$ = do$ ("Get string...", i)
			if teststring1$ = teststring2$
				afterStringPosition = i
			endif
		endfor
		do ("Remove string...", afterStringPosition)
		no_sf_all = no_sf_all - 1
		no_sf = no_sf_all
	endif
	if no_sf = 0
		exit No sound files (except carrier phrase) in this subdirectory. The experiment file was not created.
	endif
	
	# screen and initial/final silence duration
	beginPause ("Stimuli are Sounds II")
		comment ("Blank screen while presenting the stimuli?")
		choice ("BlankWhilePlaying", 2)
			option ("yes")
			option ("no")
		comment ("Duration of silence before every stimulus:")
		real ("SilenceBefore (seconds)", "0.5")
		comment ("Duration of silence after every stimulus:")
		real ("SilenceAfter (seconds)", "0.5")
	clicked = endPause ("Cancel", "Next", 2, 1)
	if clicked = 1
		exit The experiment file was not created.
	endif
	sSilenceBefore = silenceBefore
	sSilenceAfter = silenceAfter
	
	# simple stimuli or sequences of sub-stimuli?
	pwr = no_sf * no_sf
	beginPause ("Stimuli are Sounds III")
		comment ("Please specify the number of sound files (sub-stimuli)")
		comment ("you want to present per stimulus ('no_sf' files found).")
		natural ("FilesPerStimulus", 1)
		comment ("If you want to present more than one file specify the")
		comment ("total number of different stimuli you want to achieve;")
		comment ("the wizard generates random combinations of files")
		comment ("(which could be adjusted after the experiment file")
		comment ("is finished and saved).")
		natural ("NumberOfDifferentStimuli", "'no_sf'")
		comment ("If you want to present more than one file")
		comment ("specify the silence duration between files.")
		real ("SilenceBetween (seconds)", "0.5")
	clicked = endPause ("Cancel", "Next", 2, 1)
	if clicked = 1
		exit The experiment file was not created.
	endif
	sSilenceBetween = silenceBetween
	
	# build list of stimuli
	if filesPerStimulus = 1
		sSilenceBetween = 0
		numberOfDifferentStimuli = no_sf
		for i to numberOfDifferentStimuli
			selectObject (sfilelistID)
			stimulusfull$ = do$ ("Get string...", i)
			stimulus$[i] = replace$ (stimulusfull$, sSuffix$, "", 0)
		endfor
	elsif filesPerStimulus > 1
		### copy filelist (one list per substimulus)
		### and randomize filelists; after no-sf
		### this is done again and again until we
		### have enough stimuli;
		# counter for generated stimuli sequences:
		no_GenStim = 0
		repeat
			selectObject (sfilelistID)
			do ("Randomize")
			# copy and randomize filelist
			for c to filesPerStimulus-1
				selectObject (sfilelistID)
				do ("Copy...", "sfilelist_'c'")
				do ("Randomize")
			endfor
			# generate no_sf stimuli
			for i to no_sf
				# the first substimulus...
				selectObject (sfilelistID)
				stimulusfull$ = do$ ("Get string...", i)
				stimulus$[no_GenStim + i] = replace$ (stimulusfull$, sSuffix$, "", 0)
				# and the remaining substimuli
				for c to filesPerStimulus-1
					selectObject ("Strings sfilelist_'c'")
					stimulusfull$ = do$ ("Get string...", i)
					stimulusbase$ = replace$ (stimulusfull$, sSuffix$, "", 0)
					stimulus$[no_GenStim + i] = stimulus$[no_GenStim + i] + "," + stimulusbase$
				endfor
			endfor
			# remove the copied filelists; we make new filelist for the next round
			for c to filesPerStimulus-1
				removeObject ("Strings sfilelist_'c'")
			endfor
			no_GenStim = no_GenStim + (i-1)
		until no_GenStim > numberOfDifferentStimuli
		# probably, we have generated too much stimuli by now,
		# but don't worry, superfluous stimuli will be supressed in the output later
	endif
else
	### RESPONSES ARE SOUNDS
	stimuliAreSounds$ = "no"
	responsesAreSounds$ = "yes"
	# set parameters for categorical stimuli
	blankWhilePlaying$ = "no"
	sSubdirectory$ = ""
	sSuffix$ = ""
	sCarrierBefore$ = ""
	sCarrierAfter$ = ""
	sSilenceBefore = 0
	sSilenceBetween = 0
	sSilenceAfter = 0
	stimulusDependentText = 1
	stimulusDependentResp = 1
	
	# how many categorical stimuli?
	beginPause ("Stimuli are Categories I")
		comment ("Specify the number of different stimuli.")
		natural ("NumberOfDifferentStimuli", "")
	clicked = endPause ("Cancel", "Next", 2, 1)
	if clicked = 1
		exit The experiment file was not created.
	endif
	
	# we need to ask for the category and run text of each stimulus;
	# to avoid large forms (which would be truncated on small screens)
	# we'll paginate the forms; this is done in a procedure:
	@stimuliAreCategories ()
endif
# end of stimuli-related stuff



# replications and randomization strategies
beginPause ("Presentation I")
	comment ("You have 'numberOfDifferentStimuli' different stimuli.")
	comment ("Please specify the number of repetitions.")
	natural ("NumberOfReplications", 1)
	comment ("Choose a randomization strategy. These strategies are explained")
	comment ("in section 2.5 of the ExperimentMFC chapter of the built-in Praat help.")
	optionMenu ("Randomize", 4)
		option ("CyclicNonRandom")
		option ("PermuteBalancedNoDoublets")
		option ("PermuteBalanced")
		option ("PermuteAll")
		option ("WithReplacement")
clicked = endPause ("Cancel", "Next", 2, 1)
if clicked = 1
	exit The experiment file was not created.
endif
numberOfTokens = numberOfDifferentStimuli * numberOfReplications

# breaks and special buttons
beginPause ("Presentation II")
	comment ("You have 'numberOfTokens' experimental tokens ('numberOfDifferentStimuli' stimuli * 'numberOfReplications' repetitions).")
	comment ("If you want to allow for a break after every so many trials")
	comment ("specify the number of trials below (0 means no breaks).")
	integer ("BreakAfterEvery", 0)
	if stimuliResponses = 1
		comment ("If you want to provide the option to replay stimuli,")
		comment ("specify the maximum number of replays (0 means no replays).")
		integer ("MaximumNumberOfReplays", 0)
		sentence ("LabelOfReplayButton", "Play again")
	else
		maximumNumberOfReplays = 0
		labelOfReplayButton$ = ""
	endif
	comment ("Do you want to provide the option for the participant")
	comment ("to correct the previous response?")
	boolean ("OopsButton", 0)
	sentence ("LabelOfOopsButton", "Rerun previous stimulus")
	if stimuliResponses = 1
		comment ("Do you want an optional continuation button?")
		boolean ("OkButton", 0)
		sentence ("LabelOfOkButton", "Continue")
	else
		okButton = 1
		comment ("Specify the label of the Continue button.")
		sentence ("LabelOfOkButton", "Continue")
	endif
clicked = endPause ("Cancel", "Next", 2, 1)
if clicked = 1
	exit The experiment file was not created.
endif

### specify start, pause, and end texts;
### we'll allow 6 lines of text initially;
### for start and end texts the user can request another 6 lines;
### texts are parsed to escape double quotes

# start text
beginPause ("Presentation StartText 1-6")
	comment ("Specify the text on the first page, one line of text per field;")
	comment ("very long lines will be truncated on small screens, so be careful!")
	comment ("Bold: ## ... #")
	comment ("Italics: %% ... %")
	comment ("Lines 1 - 6:")
	text ("sline1", "This is a listening experiment.")
	text ("sline2", "Bla bla bla.")
	text ("sline3", "")
	text ("sline4", "Click to start.")
	text ("sline5", "")
	text ("sline6", "")
	boolean ("I need more lines", 0)
clicked = endPause ("Cancel", "Next", 2, 1)
if clicked = 1
	exit The experiment file was not created.
endif
@parseText ("sline", 1, 6)

if i_need_more_lines = 1
	startLines = 12
	beginPause ("Presentation StartText 7-12")
		comment ("Specify the text on the first page, one line of text per field;")
		comment ("very long lines will be truncated on small screens, so be careful!")
		comment ("Bold: ## ... #")
		comment ("Italics: %% ... %")
		comment ("Lines 7 - 12:")
		text ("sline7", "")
		text ("sline8", "")
		text ("sline9", "")
		text ("sline10", "")
		text ("sline11", "")
		text ("sline12", "")
	clicked = endPause ("Cancel", "Next", 2, 1)
	if clicked = 1
		exit The experiment file was not created.
	endif
	@parseText ("sline", 7, 12)
else
	startLines = 6
endif

beginPause ("Presentation EndText 1-6")
	comment ("Specify the text on the last page, one line of text per field;")
	comment ("very long lines will be truncated on small screens, so be careful!")
	comment ("Bold: ## ... #")
	comment ("Italics: %% ... %")
	comment ("Lines 1 - 6:")
	text ("eline1", "The listening experiment has finished.")
	text ("eline2", "")
	text ("eline3", "Thank you.")
	text ("eline4", "")
	text ("eline5", "")
	text ("eline6", "")
	boolean ("I need more lines", 0)
clicked = endPause ("Cancel", "Next", 2, 1)
if clicked = 1
	exit The experiment file was not created.
endif
@parseText ("eline", 1, 6)

if i_need_more_lines = 1
	endLines = 12
	beginPause ("Presentation EndText 7-12")
		comment ("Specify the text on the last page, one line of text per field;")
		comment ("very long lines will be truncated on small screens, so be careful!")
		comment ("Bold: ## ... #")
		comment ("Italics: %% ... %")
		comment ("Lines 7 - 12:")
		text ("eline7", "")
		text ("eline8", "")
		text ("eline9", "")
		text ("eline10", "")
		text ("eline11", "")
		text ("eline12", "")
	clicked = endPause ("Cancel", "Next", 2, 1)
	if clicked = 1
		exit The experiment file was not created.
	endif
	@parseText ("eline", 7, 12)
else
	endLines = 6
endif

if breakAfterEvery > 0
	beginPause ("Presentation PauseText")
		comment ("Specify the text on the pause pages, one line of text per field;")
		comment ("very long lines will be truncated on small screens, so be careful!")
		comment ("Bold: ## ... #")
		comment ("Italics: %% ... %")
		comment ("Lines 1 - 6:")
		text ("pline1", "You can have a short break if you like.")
		text ("pline2", "")
		text ("pline3", "Click to continue.")
		text ("pline4", "")
		text ("pline5", "")
		text ("pline6", "")
	clicked = endPause ("Cancel", "Next", 2, 1)
	if clicked = 1
		exit The experiment file was not created.
	endif
	@parseText ("pline", 1, 6)
endif


### for the run text and some other stuff we differentiate again between stimulus/response types
if stimuliResponses = 1
	### STIMULI ARE SOUNDS
	# ask for stimulus dependent stuff, define (default) run text, and specify number of responses
	beginPause ("RunText and Responses")
		comment ("You can have the same ""run text"" on all stimulus pages;")
		comment ("this is specified below.")
		comment ("Or you can have stimulus dependent run text; in this case the text below")
		comment ("serves as default run text.")
		boolean ("StimulusDependentText", 0)
		comment ("")
		comment ("Specify the text on the stimulus pages, one line of text per field;")
		comment ("very long lines will be truncated on small screens, so be careful!")
		comment ("Bold: ## ... #")
		comment ("Italics: %% ... %")
		comment ("")
		comment ("Lines 1 - 6:")
		text ("rline1", "Listen carefully and click the appropriate response button.")
		text ("rline2", "")
		text ("rline3", "")
		text ("rline4", "")
		text ("rline5", "")
		text ("rline6", "")
		comment ("")
		comment ("Specify the number of different responses")
		comment ("(i.e. the number of buttons; max. 20).")
		natural ("NumberOfDifferentResponses", 4)
		comment ("Are responses stimulus dependent?")
		boolean ("StimulusDependentResp", 0)
	clicked = endPause ("Cancel", "Next", 2, 1)
	if clicked = 1
		exit The experiment file was not created.
	endif
	@parseText ("rline", 1, 6)
	if numberOfDifferentResponses > 20
		exit This wizard can't handle more than 20 responses (you specified 'numberOfDifferentResponses')
	endif

	# if we have stimulus dependent stuff at all,
	# there are 3 possible cases: run text, responses, or both;
	# we call a procedure which asks for the stuff (incl. pagination to avoid large forms)
	if stimulusDependentText = 1 && stimulusDependentResp = 0
		@stimulusDependentStuff ("Specify the run text for each stimulus.", "")
	elsif stimulusDependentText = 0 && stimulusDependentResp = 1
		@stimulusDependentStuff ("Specify the labels of the response buttons for each stimulus;", "each label must start with the |-prefix (|label1|label2...).")
		responseCategories = 2
	elsif  stimulusDependentText = 1 && stimulusDependentResp = 1
		@stimulusDependentStuff ("Specify the run text and the labels of the response buttons for each stimulus;", "labels must start with the |-prefix (Run text|label1|label2...).")
		responseCategories = 2
	endif
	
	# if we don't have stimulus-dependent responses
	# we need labels for the response buttons
	if stimulusDependentResp = 0
		beginPause ("Responses II")
			comment ("Type the labels of the response buttons.")
			comment ("(For pictures use the prefix \FI followed by the subdirectory")
			comment ("followed by the file name: \FIsubdir/file.jpg)")
			for i to numberOfDifferentResponses
				sentence ("ResponseButton'i'", "")
			endfor
			comment ("Do you want to adopt the button labels as response categories")
			comment ("or do you want to specify individual response categories?")
			comment ("(Response categories are the stuff which is saved in the results table.)")
			choice ("ResponseCategories", 1)
				option ("button labels")
				option ("individual")
		clicked = endPause ("Cancel", "Next", 2, 1)
		if clicked = 1
			exit The experiment file was not created.
		endif
	endif

	# if the user wants response categories which differ from response button labels
	# or if she has stimulus dependent responses we need to know the categories
	# (probably, this should be paginated as well because we allow up to 20 responses... task for next version)
	if responseCategories = 2
			beginPause ("Responses III")
			comment ("Specify response categories.")
			for i to numberOfDifferentResponses
				if stimulusDependentResp = 0
					# if labels were defined in the last step, show them
					label$ = responseButton'i'$
					comment ("Category for response 'i' (button label: 'label$')")
					sentence ("ResponseCat'i'", "")
				else
					# for stimulus dependent responses set button labels to the empty string
					responseButton'i'$ = ""
					comment ("Category for response 'i'")
					# category defaults to response number
					sentence ("ResponseCat'i'", "'i'")
				endif
			endfor
		clicked = endPause ("Cancel", "Next", 2, 1)
		if clicked = 1
			exit The experiment file was not created.
		endif
	endif
else
	### RESPONSES ARE SOUNDS
	responseCategories = 2
	# if responses are sound we need to know the same stuff as above (subdirectory, suffix, carrier...)
	beginPause ("Responses are Sounds I")
		comment ("Choose the subdirectory which contains all your response sound files.")
		comment ("Attention: This wizard can't handle more than 20 different responses!)")
		choice ("Subdirectory", 0)
			for i to no_sd
				option (dir$[i])
			endfor
		comment ("The suffix of your sound files (in most cases 'wav');")
		comment ("upper/lower case does matter!")
		word ("Suffix", "wav")
		comment ("Do you have sound files for a carrier phrase?")
		comment ("If you do, please fill in the name(s) (without suffix)")
		comment ("of the appropriate sound file(s).")
		comment ("If you don't, just leave the fields empty.")
		sentence ("ResponseCarrierBefore", "")
		sentence ("ResponseCarrierAfter", "")
	clicked = endPause ("Cancel", "Next", 2, 1)
	if clicked = 1
		exit The experiment file was not created.
	endif
	rSubdirectory$ = subdirectory$
	rSuffix$ = "." + suffix$
	rCarrierBefore$ = responseCarrierBefore$
	rCarrierAfter$ = responseCarrierAfter$
	
	# sound file list minus carrier sounds, see above
	sfilelistID = do ("Create Strings as file list...", "sfilelist", directoryName$ + "/" + rSubdirectory$ + "/*" + rSuffix$)
	no_sf_all = do ("Get number of strings")
	if no_sf_all = 0
		exit No sound files in this subdirectory. The experiment file was not created.
	endif
	if rCarrierBefore$ = "" && rCarrierAfter$ = ""
		no_sf = no_sf_all
	elsif rCarrierBefore$ <> ""
		teststring1$ = rCarrierBefore$ + rSuffix$
		for i to no_sf_all
			selectObject (sfilelistID)
			teststring2$ = do$ ("Get string...", i)
			if teststring1$ = teststring2$
				beforeStringPosition = i
			endif
		endfor
		do ("Remove string...", beforeStringPosition)
		no_sf_all = no_sf_all - 1
		no_sf = no_sf_all
	elsif rCarrierAfter$ <> ""
		teststring1$ = rCarrierAfter$ + rSuffix$
		for i to no_sf_all
			selectObject (sfilelistID)
			teststring2$ = do$ ("Get string...", i)
			if teststring1$ = teststring2$
				afterStringPosition = i
			endif
		endfor
		do ("Remove string...", afterStringPosition)
		no_sf_all = no_sf_all - 1
		no_sf = no_sf_all
	endif
	if no_sf = 0
		exit No sound files (except carrier phrase) in this subdirectory. The experiment file was not created.
	endif
	numberOfDifferentResponses = no_sf
	if numberOfDifferentResponses > 20
		exit Sorry, this wizard can't handle more than 20 different responses.
	endif
	
	for i to numberOfDifferentResponses
		selectObject (sfilelistID)
		responsefull$ = do$ ("Get string...", i)
		response$[i] = replace$ (responsefull$, rSuffix$, "", 0)
	endfor
	
	# silence durations
	beginPause ("Responses are Sounds II")
		comment ("Duration of silence before every response:")
		real ("SilenceBefore (seconds)", "0.5")
		comment ("Duration of silence after every response:")
		real ("SilenceAfter (seconds)", "0.5")
	clicked = endPause ("Cancel", "Next", 2, 1)
	if clicked = 1
		exit The experiment file was not created.
	endif
	rSilenceBefore = silenceBefore
	rSilenceBetween = 0
	rSilenceAfter = silenceAfter
endif


### finally, the goodness rating
beginPause ("Rating I")
	comment ("Specify the number of rating categories (max. 10).")
	comment ("(0 means there will be no rating buttons.)")
	comment (" ")
	integer ("NumberOfGoodnessCategories", 0)
clicked = endPause ("Cancel", "Next", 2, 1)
if clicked = 1
	exit The experiment file was not created.
endif

if numberOfGoodnessCategories > 10
	exit Sorry, this wizard can't handle more than 10 rating categories.
elsif numberOfGoodnessCategories > 0 && numberOfGoodnessCategories <= 10
		beginPause ("Rating II")
		comment ("Specify labels for the rating categories.")
		for i to numberOfGoodnessCategories
			sentence ("RatingButton'i'", string$ (i))
		endfor
	clicked = endPause ("Cancel", "Next", 2, 1)
	if clicked = 1
		exit The experiment file was not created.
	endif
endif


### CREATE RESPONSE BUTTONS
# the job of defining x- and y-coordinates for the buttons is done in a procedure
# which takes the number of button rows as the first argument (the number of columns
# results from the number of rows and the number of buttons)
if numberOfDifferentResponses <= 5
	@calcCoordinates (1, numberOfDifferentResponses)
elsif numberOfDifferentResponses <= 10 && numberOfDifferentResponses <> 9
	@calcCoordinates (2, numberOfDifferentResponses)
elsif numberOfDifferentResponses <= 15 || numberOfDifferentResponses = 9 || numberOfDifferentResponses = 18
	@calcCoordinates (3, numberOfDifferentResponses)
elsif numberOfDifferentResponses <= 20 && numberOfDifferentResponses <> 18
	@calcCoordinates (4, numberOfDifferentResponses)
elsif numberOfDifferentResponses > 20
	exit Sorry, this wizard can't handle more than 20 different responses.
endif


### CREATE RATING BUTTONS
# all buttons in one row w/o space between
if numberOfGoodnessCategories > 0
	# the edge between window frame and buttons
	gdEdge = 0.05
	# the width of one button
	gdSlotWidth = (1 - (gdEdge * 2))/numberOfGoodnessCategories
	# initialize first x
	gdxto = gdEdge
	for g to numberOfGoodnessCategories
		# left-x = right-x from last button
		gdxfrom = gdxto
		gdxto = gdxfrom + gdSlotWidth
		gdCoord$[g] = fixed$ (gdxfrom, 2) + " " + fixed$ (gdxto, 2) + " 0.15 0.25"
	endfor
endif


### GENERATE OUTPUT
# clear info window
writeInfo ()
# header
appendInfoLine ("""ooTextFile""")
appendInfoLine ("""ExperimentMFC 6""")
# stimuli stuff
appendInfoLine ("blankWhilePlaying? <", blankWhilePlaying$, ">")
appendInfoLine ("stimuliAreSounds? <", stimuliAreSounds$, ">")
appendInfoLine ("stimulusFileNameHead = """, sSubdirectory$, "/""")
appendInfoLine ("stimulusFileNameTail = """, sSuffix$, """")
appendInfoLine ("stimulusCarrierBefore = """, sCarrierBefore$, """")
appendInfoLine ("stimulusCarrierAfter = """, sCarrierAfter$, """")
appendInfoLine ("stimulusInitialSilenceDuration = ", sSilenceBefore, " seconds")
appendInfoLine ("stimulusMedialSilenceDuration = ", sSilenceBetween, " seconds")
appendInfoLine ("stimulusFinalSilenceDuration = ", sSilenceAfter, " seconds")
appendInfoLine ("numberOfDifferentStimuli = ", numberOfDifferentStimuli)

# the stimuli list
for i to numberOfDifferentStimuli
	if stimulusDependentText = 0 && stimulusDependentResp = 0
		appendInfoLine ("    """, stimulus$[i], """ """"")
	else
		appendInfoLine ("    """, stimulus$[i], """ """, stimulusDependentSpec'i'$, """")
	endif
endfor

# presentation
appendInfoLine ("numberOfReplicationsPerStimulus = ", numberOfReplications)
appendInfoLine ("breakAfterEvery = ", breakAfterEvery)
appendInfoLine ("randomize = <", randomize$, ">")

# startText
# determine last line with any content (empty lines before that line will be retained)
for i to startLines
	if sline'i'$ <> ""
		# escape double quotes
		sline'i'$ = replace$ (sline'i'$, """", """""", 0)
		lastSline = i
	endif
endfor
# comment and opening quotes w/o line break
appendInfo ("startText = """)
# start text lines
for i from 1 to lastSline-1
	appendInfoLine (sline'i'$)
endfor
# last line and closing quotes
appendInfo (sline'lastSline'$)
appendInfoLine ("""")

# runText
# if stimuli are sounds same steps as above
if stimuliResponses = 1
	for i to 6
		if rline'i'$ <> ""
			lastRline = i
		endif
	endfor
	appendInfo ("runText = """)
	for i from 1 to lastRline-1
		appendInfoLine (rline'i'$)
	endfor
	appendInfo (rline'lastRline'$)
	appendInfoLine ("""")
else
	# if stimuli are categories we only have stimulus dependent run texts
	# so we can output the empty string here
	appendInfoLine ("runText = """"")
endif

# pauseText
# see above
if breakAfterEvery > 0
	for i to 6
		if pline'i'$ <> ""
			lastPline = i
		endif
	endfor
	appendInfo ("pauseText = """)
	for i from 1 to lastPline-1
		appendInfoLine (pline'i'$)
	endfor
	appendInfo (pline'lastPline'$)
	appendInfoLine ("""")
else
	appendInfoLine ("pauseText = """"")
endif

# endText
# see above
for i to endLines
	if eline'i'$ <> ""
		lastEline = i
	endif
endfor
appendInfo ("endText = """)
for i from 1 to lastEline-1
	appendInfoLine (eline'i'$)
endfor
appendInfo (eline'lastEline'$)
appendInfoLine ("""")

# number of replays and special buttons
appendInfoLine ("maximumNumberOfReplays = ", maximumNumberOfReplays)
if maximumNumberOfReplays > 0
	appendInfoLine ("replayButton = 0.4 0.6 0.02 0.12 """, labelOfReplayButton$, """ """"")
else
	appendInfoLine ("replayButton = 0 0 0 0 """" """"")
endif
if okButton = 1
	appendInfoLine ("replayButton = 0.7 0.9 0.02 0.12 """, labelOfOkButton$, """ """"")
else
	appendInfoLine ("okButton = 0 0 0 0 """" """"")
endif
if oopsButton = 1
	appendInfoLine ("replayButton = 0.1 0.3 0.02 0.12 """, labelOfOopsButton$, """ """"")
else
	appendInfoLine ("oopsButton = 0 0 0 0 """" """"")
endif

# responses
appendInfoLine ("responsesAreSounds? <", responsesAreSounds$, ">")
appendInfoLine ("responseFileNameHead = """, rSubdirectory$, "/""")
appendInfoLine ("responseFileNameTail = """, rSuffix$, """")
appendInfoLine ("responseCarrierBefore = """, rCarrierBefore$, """")
appendInfoLine ("responseCarrierAfter = """, rCarrierAfter$, """")
appendInfoLine ("responseInitialSilenceDuration = ", rSilenceBefore, " seconds")
appendInfoLine ("responseMedialSilenceDuration = ", rSilenceBetween, " seconds")
appendInfoLine ("responseFinalSilenceDuration = ", rSilenceAfter, " seconds")
appendInfoLine ("numberOfDifferentResponses = ", numberOfDifferentResponses)

# the list of response buttons
if responseCategories = 1 && stimuliResponses = 1
	for i to numberOfDifferentResponses
		appendInfoLine ("    ", coord$[i], " """, responseButton'i'$, """ 40 """" """, responseButton'i'$, """")
	endfor
elsif responseCategories = 2 && stimuliResponses = 1
	for i to numberOfDifferentResponses
		appendInfoLine ("    ", coord$[i], " """, responseButton'i'$, """ 40 """" """, responseCat'i'$, """")
	endfor
elsif stimuliResponses = 2
	for i to numberOfDifferentResponses
		appendInfoLine ("    ", coord$[i], " """" 40 """" """, response$[i], """")
	endfor
endif

# goodness buttons
appendInfoLine ("numberOfGoodnessCategories = ", numberOfGoodnessCategories)
if numberOfGoodnessCategories > 0
	for i to numberOfGoodnessCategories
		appendInfoLine (gdCoord$[i], " """, ratingButton'i'$, """")
	endfor
endif


### clean up
removeObject (subdirlistID, sfilelistID)


### save and load experiment file
beginPause ("Finish")
	comment ("You can now view the experiment file in the Praat Info window.")
	comment ("When you are ready click Save to save the file 'fileName$'.mfc")
	comment ("in the experiment directory or click Save & Load to save the file")
	comment ("and load it into Praat.")
clicked = endPause ("Cancel", "Save", "Save & Load", 3, 1)
if clicked = 1
	exit The experiment file was not saved.
else
	deleteFile (directoryName$ + "/" + fileName$ + ".mfc")
	appendFile (directoryName$ + "/" + fileName$ + ".mfc", info$ ())
	if clicked = 3
		do ("Read from file...", directoryName$ + "/" + fileName$ + ".mfc")
	endif
endif




### PROCEDURES

procedure parseText (linename$, start, end)
	# escape double quotes
	for p from start to end
		toparse$ = 'linename$''p'$
		'linename$''p'$ = replace$ (toparse$, """", """""", 0)
	endfor
endproc


procedure stimulusDependentStuff (instruction1$, instruction2$)
	### we have to avoid large forms with too much fields
	### because they would be truncated on small screens
	# define maximum number of stimuli per form (page):
	maxStimuliPerPage = 10
	last_s = 1
	pageNo = 1
	for s to numberOfDifferentStimuli
		# only show a new form when we have enough stimuli for a full page
		# or when we reach the end (i.e. the total number of different stimuli)
		if round (s/maxStimuliPerPage) = s/maxStimuliPerPage || s = numberOfDifferentStimuli
			beginPause ("Stimulus dependent stuff (page 'pageNo')")
				comment ("'instruction1$'")
				if instruction2$ <> ""
					comment ("'instruction2$'")
				endif
				# generate fields for each stimulus
				for l from last_s to s
					s_name$ = stimulus$[l]
					comment ("Stimulus 'l' ('s_name$')")
					sentence ("StimulusDependentSpec'l'", "")
				endfor
			clicked = endPause ("Cancel", "Next", 2, 1)
			if clicked = 1
				exit The experiment file was not created.
			endif
			pageNo = pageNo+1
			last_s = s+1
		endif
	endfor
	# escape double quotes
	for s to numberOfDifferentStimuli
		stimulusDependentSpec's'$ = replace$ (stimulusDependentSpec's'$, """", """""", 0)
	endfor	
endproc


procedure stimuliAreCategories ()
	### we have to avoid large forms with too much fields
	### because they won't fit small screens
	# define maximum number of stimuli per form:
	maxStimuliPerPage = 8
	last_s = 1
	pageNo = 1
	for s to numberOfDifferentStimuli
		# only show a new form when we have enough stimuli for a full page
		# or when we reach the end (i.e. the total number of different stimuli)
		if round (s/maxStimuliPerPage) = s/maxStimuliPerPage || s = numberOfDifferentStimuli
			beginPause ("Category and run text (page 'pageNo')")
				comment ("For each stimulus, specify the response category")
				comment ("(the stuff which is saved in the results table)")
				comment ("and the ""run text"" (the headline of the stimulus page).")
				comment ("In the run text, you can use ##bold#, %%italics% or ##%%bold-italics%#.")
				# generate fields for each stimulus
				for l from last_s to s
					comment ("Stimulus 'l'")
					sentence ("StimulusCategory'l'", "")
					sentence ("StimulusRunText'l'", "")
				endfor
			clicked = endPause ("Cancel", "Next", 2, 1)
			if clicked = 1
				exit The experiment file was not created.
			endif
			pageNo = pageNo+1
			last_s = s+1
		endif
	endfor
	# escape double quotes and use known variable names
	for s to numberOfDifferentStimuli
		# escape quotes
		stimulusCategory's'$ = replace$ (stimulusCategory's'$, """", """""", 0)
		stimulusRunText's'$ = replace$ (stimulusRunText's'$, """", """""", 0)
		# translate to known variable names
		stimulus$[s] = stimulusCategory's'$
		stimulusDependentSpec's'$ = stimulusRunText's'$
	endfor	
endproc


procedure calcCoordinates (rows, no_buttons)
	### if we can't have the same number of buttons in all rows
	### we want the same number in the upper rows and the remaining
	### buttons (fewer than in the upper rows) in the last row;
	### therefore we use the ceiling function for the upper rows;
	# number of columns (buttons) in first row
	cols1 = ceiling (no_buttons/rows)
	# space between buttons; large for few buttons, small for many
	gap = 0.2/cols1
	slot = (1 - gap) / cols1
	width = slot - gap
	# first we define y-coordinates and determine number of columns (buttons) for each row > 1
	if rows = 1
		yfrom1 = 0.35
		yto1 = 0.65
	elsif rows = 2
		yfrom1 = 0.55
		yto1 = 0.7
		yfrom2 = 0.3
		yto2 = 0.45
		cols2 = no_buttons-cols1
	elsif rows = 3
		yfrom1 = 0.6
		yto1 = 0.7
		yfrom2 = 0.45
		yto2 = 0.55
		yfrom3 = 0.3
		yto3 = 0.4
		cols2 = ceiling ((no_buttons-cols1)/2)
		cols3 = no_buttons-(cols1+cols2)
	elsif rows = 4
		yfrom1 = 0.6
		yto1 = 0.69
		yfrom2 = 0.5
		yto2 = 0.59
		yfrom3 = 0.4
		yto3 = 0.49
		yfrom4 = 0.3
		yto4 = 0.39
		cols2 = ceiling ((no_buttons-cols1)/3)
		cols3 = ceiling ((no_buttons-(cols1+cols2))/2)
		cols4 = no_buttons-(cols1+cols2+cols3)
	endif
	# now we calculate x-coordinates and build an array with sequences of coordinates;
	# to keep track of the array indices we need the help of an additional variable:
	doneButtons = 0
	for r to rows
		# initialize the left edge of each row
		leftEdge'r' = 0
		# each buttons needs a slot
		row'r'slots = slot * cols'r'
		# the last row may have fewer buttons, so the left edge may differ
		if cols'r' <> cols1
			leftEdge'r' = ((1 - row'r'slots) / 2) - gap
		endif
		# finally, we can calculate x-coordinates and build the array
		for k to cols'r'
			xfrom = (slot * (k-1)) + gap + leftEdge'r'
			xto = xfrom + width
			coord$[k+doneButtons] = fixed$ (xfrom, 2) + " " + fixed$ (xto, 2) + " " + fixed$ (yfrom'r', 2) +" " + fixed$ (yto'r', 2)
		endfor
		doneButtons = doneButtons + (k - 1)
	endfor
endproc





