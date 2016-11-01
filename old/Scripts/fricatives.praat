form Input Enter specifications for Formant settings
    comment first spectral peak, bandwidth and relative amplitude: 
    real spp1 2500
    real bw1 2000
    integer rel1 8
    boolean peak1 1

    real spp2 3400
    real bw2 2600
    integer rel2 0
    boolean peak2 1

    real spp3 5200
    real bw3 3500
    integer rel3 6
    boolean peak3 1

    comment final intensity (dB) and filename: 
    real int 67

    comment fricative duration, rise time and fall time
    real duration 240
    real risetime 160
    real falltime 70

#    word name fricative_sh
endform

#soundDir$ = chooseDirectory$ ("Choose a directory to save the new file in")

samplerate = 22050
dur = 'duration'/1000
Create Sound from formula... Noise 1 0 'dur' 'samplerate' randomGauss(0,0.1)
Scale intensity... 70

#### ramps onset and offset volume using onset & offset sin/cosine ramps

## selects the sound that has been converted to the samplerate and has the onset prefix added 
select Sound Noise
start1 = Get start time
end1 = Get end time
risetime = risetime/1000
falltime = falltime/1000
    Formula... if x<('risetime')  
	...then self * cos((x-('risetime' - 'start1'))/'risetime' * pi/2)
	...else self endif    
    Formula... if x>('end1' - 'falltime')  
	...then self * cos((x-(end1 - 'falltime'))/'falltime' * pi/2)
	...else self endif
	Rename... Noise_ramped


n = 0
for s from 1 to 3
	n = n + 1
	
	select Sound Noise_ramped
	Filter (pass Hann band)... 0 spp'n' bw'n'
	Filter (pass Hann band)... spp'n' 22050 bw'n'
	Rename... SPP'n'

	newInt = 70 + rel'n'

	Scale intensity... 'newInt'
	
	if peak'n' = 1
		peakbw'n' = bw'n' / 8
		select Sound SPP'n'
		Filter (pass Hann band)... 0 spp'n' peakbw'n'
		Filter (pass Hann band)... spp'n' 'samplerate' peakbw'n'
		Multiply... 3

		select Sound SPP'n'
		plus Sound SPP'n'_band_band
		sound1 = selected ("Sound", 1)
		sound2 = selected ("Sound", 2)
		select sound1
		Copy... Added
		Formula... self [col] + Object_'sound2' [col] 
		Rename... SPP'n'_peaked
		select Sound Noise_ramped_band
		Remove
	endif

endfor

Create Sound from formula... silence 1 0 0.05 'samplerate' 0


if peak1 = 1
	select Sound SPP1_peaked
	else
	select Sound SPP1
endif

if peak2 = 1
	plus Sound SPP2_peaked
	else
	plus Sound SPP2
endif

if peak3 = 1
	plus Sound SPP3_peaked
	else
	plus Sound SPP3
endif

sound1 = selected ("Sound", 1)
sound2 = selected ("Sound", 2)
sound3 = selected ("Sound", 3)
select sound1
Copy... Fricative
Formula... self [col] + Object_'sound2' [col] + Object_'sound3' [col]
Scale intensity... 'int'

select Sound silence
plus Sound Fricative
Concatenate

select Sound silence
plus Sound Fricative
Remove

select Sound chain
Rename... Fricative
#Save as WAV file... 'soundDir$'\fricative.wav


select Sound SPP1
if peak1 = 1
	plus Sound SPP1_peaked
	plus Sound SPP1_band
	plus Sound SPP1_band_band
endif
if peak2 = 1
	plus Sound SPP2_peaked
	plus Sound SPP2_band
	plus Sound SPP2_band_band
	else
endif
plus Sound SPP2
plus Sound SPP3
if peak3 = 1
	plus Sound SPP3_peaked
	plus Sound SPP3_band
	plus Sound SPP3_band_band
endif
plus Sound Noise_ramped
Remove