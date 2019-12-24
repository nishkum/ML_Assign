import sys

# Arg1 - test file
# Arg2 - the feature file 
# Output file - [arg1]_Y.txt, [arg1]_[arg2]_cvx.txt, [arg1]_[arg2]_libsvm.txt

if (len(sys.argv) < 3):
	print "Incorrect number of arguments.\n"
	exit(1)

# Load the features
ffeature = open(sys.argv[2],'r')
features = ffeature.read().splitlines()
numfeatures = len(features)
ffeature.close()

featureFileName = sys.argv[2]
featureFileName = featureFileName[:featureFileName.find('.')]

ftest = open(sys.argv[1],'r')
fOutput = open(sys.argv[1]+'_Y.txt','w')
fcvx = open(sys.argv[1]+'_'+featureFileName+'_cvx.txt','w')
flsvm = open(sys.argv[1]+'_'+featureFileName+'_libsvm.txt','w')

for line in ftest:
	arr = line.split()
	freqlist = [0]*numfeatures
	for i,k in enumerate(arr):
		if i==0: continue
		elif i==1:
			# spam or ham
			# -1 for ham and +1 for spam
			if k=='ham':
				fOutput.write('-1\n')
				flsvm.write('-1 ')
			else:
				fOutput.write('1\n')
				flsvm.write('1 ')
		elif (i%2==0) and (k in features):
			ind = features.index(k)
			freqlist[ind] = int(arr[i+1])
	for i,v in enumerate(freqlist):
		fcvx.write(str(v)+' ')
		flsvm.write(str(i+1)+':'+str(v)+' ')
	fcvx.write('\n')
	flsvm.write('\n')

ftest.close()
fOutput.close()
fcvx.close()
flsvm.close()