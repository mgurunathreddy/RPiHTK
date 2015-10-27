arecord -f S16_LE -c1 -r8000 -d 3 test.wav
rm TestListOnline
HCopy -C feature.config test.wav test.mfcc
cat ./models/* > allTrainedModels
echo ./test.mfcc >>TestListOnline

#scpFile = ./TestListOnline

HVite -T 1 -H ./allTrainedModels -S ./TestListOnline -i ./recoutr.mlf -w ./digit.net ./model2model ./modelList > ./logout
