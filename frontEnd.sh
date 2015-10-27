## Program for Training the Speech data

wavPath='./DATA/Train'
featPath='./mfcc/Train'
ls $wavPath > modelList
list='./modelList'
mkdir -p $featPath

## Start Feature Extraction
rm -f htkList	

for word in `cat $list` 
do
	rm -rf $featPath/$word
	mkdir $featPath/$word
	for file in `ls $wavPath/$word|cut -d'.' -f1`
	do
		echo $wavPath/$word/$file.wav $featPath/$word/$file.mfcc >>htkList
	done
done

HCopy -C feature.config -S htkList
## End of Feature Extraction and is saved in the path specified in htkList
 
# To create prototype. Initial setup to HTK which specifies the details of HMM Parameters
mkdir -p ./protos
perl MakeProtoHMMSet feature.config InputProto

# this will create a proto folder and makes the prototype for each file

## Training the recognizer using HTK

featPath='./mfcc/Train'
modelPath='./models'
protoPath='./protos'
modelList='./modelList'
mkdir -p $modelPath
for word in `cat $modelList` 
do
	rm -f list.scp
	
	for i in `ls $featPath/$word|cut -d'.' -f1`
	do
		
		echo "$featPath/$word/$i.mfcc" >>list.scp
	done
	
	HInit -T 1 -i 50 -S list.scp  -M $modelPath $protoPath/$word
	HRest -T 1 -i 50  -S list.scp -M $modelPath $modelPath/$word
done
rm list.scp

## end of training


