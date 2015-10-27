# To extract features for test wave files

wavPath='./DATA/Test'
featPath='./mfcc/Test'
ls $wavPath > modelList
list='./modelList'
mkdir -p $featPath

rm -f htkTestList	

for word in `cat $list` 
do
	rm -rf $featPath/$word
	mkdir $featPath/$word
	for file in `ls $wavPath/$word|cut -d'.' -f1`
	do
		echo $wavPath/$word/$file.wav  $featPath/$word/$file.mfcc >>htkTestList
		echo $featPath/$word/$file.mfcc >>TestList
	done
done

HCopy -C feature.config -S htkTestList

# end of Feature extraction
cat ./models/* > allTrainedModels

HParse ./digit.syn ./digit.net
# creation of recognition grammar or word network

scpFile=./TestList

paste modelList modelList >> model2model


HVite -T 1 -H ./allTrainedModels -S $scpFile -i ./recoutr.mlf -w ./digit.net ./model2model ./modelList > ./logout

# final recognized output will be in logout text file
