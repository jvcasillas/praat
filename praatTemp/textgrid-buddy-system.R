## Aaron Braver
## April 10, 2012
## Check that every wav file in a given directory
## 		has a textgrid by the same name

## The script also moves any buddyless wavs into
## a folder called `buddyless_wavs'.  If you don't
## want it to do that, comment out the bottom portion



#Set the directory you want to check
setwd("/Users/abraver/thefiles")

#Get a list of the wavs and textgrids
wavlist<-list.files(pattern="*\\.wav", ignore.case=TRUE)
gridlist<-list.files(pattern="*\\.TextGrid", ignore.case=TRUE)
cat("\n\n\n")


#Loop through the wavs
cat("I don't have matching TextGrids for the following wav files.\n\nFor your convenience, they've been moved to the folder 'buddyless_wavs'\n\n\n")
buddyless_wavs<-c()
for (i in wavlist) {
	#all the substr business below is to chop off the file extensions
	#so we can compare apples to apples between the two file lists
	if (!(substr(i,1,nchar(i)-4) %in% substr(gridlist,1,nchar(gridlist)-9))) {
		cat(i,"\n")
		buddyless_wavs<-c(buddyless_wavs,i)
	}
}



####Move the buddyless wavs into their own folder for processing

#If the folder "buddyless_wavs" doesn't exist already, make it
if (!file.exists(file.path(getwd(),"buddyless_wavs"))) {
	dir.create(file.path(getwd(),"buddyless_wavs"))
}
#Move the buddyless files to the folder
for (i in buddyless_wavs) {
	file.rename(file.path(getwd(),i),file.path(getwd(),"buddyless_wavs",i))
}