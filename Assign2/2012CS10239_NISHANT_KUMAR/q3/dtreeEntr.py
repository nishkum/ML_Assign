from __future__ import division
import sys,math,random
from pprint import pprint
import matplotlib.pyplot as plt
import random as rand

class Node:
	numNodes = 0
	def __init__(self):
		self.data = None
		self.splitAttr = None
		self.leftNode = None
		self.midNode = None
		self.rightNode = None
		self.majorInPar = None;
		Node.numNodes+=1

	def depth(self):
		ldepth = self.leftNode.depth() if self.leftNode else 0
		rdepth = self.rightNode.depth() if self.rightNode else 0
		mdepth = self.midNode.depth() if self.midNode else 0
		return max(ldepth,rdepth,mdepth)+1

	def findNumNodes(self):
		lnodes = self.leftNode.findNumNodes() if self.leftNode else 0
		midnodes = self.midNode.findNumNodes() if self.midNode else 0
		rnodes = self.rightNode.findNumNodes() if self.rightNode else 0
		return (lnodes+midnodes+rnodes+1)

classifier = Node()
classifierSafeCopy = classifier
xnumNodes = []
trainaccuracy = []
validaccuracy = []
testaccuracy = []

prunNumNodes = []
prunTrainAcc = [] 
prunValAcc = [] 
prunTestAcc = [] 

traindata = None
validationdata = None
testdata = None


def findError(attr,data):
	errMat = [[0,0],[0,0],[0,0]]
	totEx = 1.0*len(data)
	if (totEx==0):
		print "Error in findError ..."
		exit(1)
	for ex in data:
		errMat[ex[attr]+1][ex[0]] += 1
	numOfZero = 0
	err = 0.0
	for out in errMat:
		if ((out[0]+out[1])!=0):
			temp = ((out[0]+out[1])/totEx)*((1.0*min(out[0],out[1]))/(out[0]+out[1]))
			err += temp
		else:
			numOfZero += 1
	if (numOfZero>=3):
		# this cannot happen
		print "Error in findError - 1!!"
		exit(1)
	return err

def chooseBestAttrError(data,attrset):
	# Choose on error
	if len(data)==0:
		print "ERROR in chooseBestAttr!!"
		exit(1)
	numAttr = len(data[0])-1
	minError = 1.0*(10**9)
	minErrorNo = -1
	for attrNo in xrange(1,numAttr+1):
		if not(attrset[attrNo-1]):
			# means that this attrNo is false in attrset
			continue
		# this attr is allowed
		err = findError(attrNo,data)
		if (err<minError):
			minError = err
			minErrorNo = attrNo
	if (minErrorNo == -1) or (minErrorNo == 0):
		# means that no attribute has error less than 10**9
		print "Error in chooseBestAttr - 1!!"
		exit(1)
	return minErrorNo

def findCondEntr(attr,data):
	errMat = [[0,0],[0,0],[0,0]]
	totEx = 1.0*len(data)
	if (totEx==0):
		print "Error in findCondEntr ..."
		exit(1)
	for ex in data:
		errMat[ex[attr]+1][ex[0]] += 1
	numOfZero = 0
	err = 0.0
	for out in errMat:
		temp = out[0]+out[1]
		if (temp!=0):
			prob = (1.0*temp)/totEx
			condp0 = (1.0*out[0])/temp
			condp1 = (1.0*out[1])/temp
			temp2 = 0.0
			temp2 += (condp0*math.log(condp0,2) if (condp0!=0) else 0.0)
			temp2 += (condp1*math.log(condp1,2) if (condp1!=0) else 0.0)
			err += (prob*(-1*temp2))
		else:
			numOfZero += 1
	# if (numOfZero>=2): return -1
	return err

def chooseBestAttrEntropy(data,attrset):
	# Choose on entropy
	if len(data)==0:
		print "ERROR in chooseBestAttr!!"
		exit(1)
	numAttr = len(data[0])-1
	minError = 1.0*(10**9)
	minErrorNo = -1
	for attrNo in xrange(1,numAttr+1):
		if not(attrset[attrNo-1]):
			# means that this attrNo is false in attrset
			continue
		# this attr is allowed
		err = findCondEntr(attrNo,data)
		if (err<minError):
			minError = err
			minErrorNo = attrNo
	if (minErrorNo == -1) or (minErrorNo == 0):
		# means that no attribute has error less than 10**9
		print "Error in chooseBestAttr - 1!!"
		exit(1)
	return minErrorNo

def splitOnAttr(spAttr,data):
	dataneg,datazero,datapos=[[],[]],[[],[]],[[],[]]
	for example in data:
		if (example[spAttr]==-1): dataneg[example[0]].append(example)
		elif (example[spAttr]==0): datazero[example[0]].append(example)
		elif (example[spAttr]==1): datapos[example[0]].append(example)
		else:
			print "Error in splitOnAttr - ",example[spAttr]
			exit(1)
	return [dataneg,datazero,datapos]

# use classi to predict ex
def predictSingle(ex,classi):
	spatt = classi.splitAttr
	if (classi.leftNode==None) and (classi.midNode == None) and (classi.rightNode == None):
		# This means this is a leaf node
		l0 = len(classi.data[0])
		l1 = len(classi.data[1])
		if (l0>l1): return 0
		elif (l0<l1): return 1
		else:
			# the equal case
			if (classi.majorInPar) and (l0==0):
				return classi.majorInPar
			return 1

	# recursive case
	
	spatt-=1 # classi.splitAttr was in [1..16] but i need it in [0..15]
	curattrval = ex[spatt]
	gonode = None
	if (curattrval==-1): gonode = classi.leftNode
	elif (curattrval==0): gonode = classi.midNode
	elif (curattrval==1): gonode = classi.rightNode
	else:
		print  "Error - the curattr is something unknown",curattr
		exit(1)
	if gonode==None:
		# now use majority prediction with training data going on curattrval
		splitdata = splitOnAttr(spatt+1,classi.data[0]+classi.data[1])
		onthisway = splitdata[curattrval+1]
		l0 = len(onthisway[0])
		l1 = len(onthisway[1])
		if (l0>l1): return 0
		elif (l0<l1): return 1
		else:
			# the equal case
			if (classi.majorInPar) and (l0==0):
				return classi.majorInPar
			return 1
	else:
		return predictSingle(ex,gonode)

def findAccuracy(nnodes,trainacc,valacc,testacc,root):
	global traindata,validationdata,testdata
	# find the accuracy on train,validation and test data
	classifierOri = root
	curNumnodes = classifierOri.findNumNodes()
	trainCorrect = 0
	validCorrect = 0
	testCorrect = 0
	trd = traindata[0]+traindata[1]
	vld = validationdata[0]+validationdata[1]
	tstd = testdata[0]+testdata[1]
	# now find the accuracy over train , validation and test
	for ex in trd:
		c1 = classifierOri
		prediction = predictSingle(ex[1:],c1)
		if not((prediction==0) or (prediction==1)):
			print "predictSingle not working !!",prediction
			exit(1)
		if (prediction == ex[0]): trainCorrect += 1

	for ex in vld:
		c1 = classifierOri
		prediction = predictSingle(ex[1:],c1)
		if not((prediction==0) or (prediction==1)):
			print "predictSingle not working !!",prediction
			exit(1)
		if (prediction == ex[0]): validCorrect += 1

	for ex in tstd:
		c1 = classifierOri
		prediction = predictSingle(ex[1:],c1)
		if not((prediction==0) or (prediction==1)):
			print "predictSingle not working !!",prediction
			exit(1)
		if (prediction == ex[0]): testCorrect += 1

	nnodes.append(curNumnodes)
	trainacc.append((1.0*trainCorrect)/len(trd))
	valacc.append((1.0*validCorrect)/len(vld))
	testacc.append((1.0*testCorrect)/len(tstd))

def growTree(inpd,curNode,attrset):
	global xnumNodes,trainaccuracy,validaccuracy,testaccuracy,classifier
	c1 = classifier
	[data0,data1] = inpd
	curNode.data = [data0,data1] #inpdata is a list = [data0,data1]

	findAccuracy(xnumNodes,trainaccuracy,validaccuracy,testaccuracy,c1)

	l0 = len(data0)
	l1 = len(data1)
	if (l0==0) or (l1==0) or (sum(attrset)==0):
		return

	# using entropy as the metric to split on
	spAttr = chooseBestAttrEntropy(data0+data1,attrset) # spAttr is in [1..maxattr]
	curNode.splitAttr = spAttr
	[dataneg,datazero,datapos] = splitOnAttr(spAttr,data0+data1) # dataneg,datazero and datapos are 2*1 lists

	newattrset = [x for x in attrset]
	newattrset[spAttr-1] = False

	leftn = Node()
	curNode.leftNode = leftn
	leftn.majorInPar = ((0 if (l0>l1) else 1) if (l0!=l1) else None)
	growTree(dataneg,leftn,newattrset)

	midn = Node()
	curNode.midNode = midn
	midn.majorInPar = ((0 if (l0>l1) else 1) if (l0!=l1) else None)
	growTree(datazero,midn,newattrset)	
	
	rightn = Node()
	curNode.rightNode = rightn
	rightn.majorInPar = ((0 if (l0>l1) else 1) if (l0!=l1) else None)
	growTree(datapos,rightn,newattrset)

def readFile(filename):
	fid = open(filename,'r')
	lines = fid.read().splitlines()
	data = [[0 for x in xrange(len(lines[0].split(',')))] for x in xrange(len(lines))]
	for i,line in enumerate(lines):
		arr = line.split(',')
		for j,val in enumerate(arr):
			if j==0:
				# 0 for democrat and 1 for republican
				if (val=='democrat'):
					data[i][0] = 0
				elif (val=='republican'):
					data[i][0] = 1
				else:
					print "Input File error."
					exit(1)
			else:
				# -1 for no, +1 for yes, 0 for unknown - ?
				if (val=='y'): 
					data[i][j] = 1;
				elif (val=='n'): 
					data[i][j] = -1;
				elif (val=='?'): 
					data[i][j] = 0;
				else:
					print "Error reading the file at line ",i,j
					exit(1)
	data0 = []
	data1 = []
	for ex in data:
		if (ex[0]==1):data1.append(ex)
		else: data0.append(ex)
	return [data0,data1]



traindata = readFile('train.data')
validationdata = readFile('validation.data')
testdata = readFile('test.data')

c3 = classifier
growTree(traindata,c3,[True for x in xrange(16)])
print 'The built tree depth = ',classifier.depth()
print 'The built tree\'s number of nodes = ',classifier.findNumNodes()

trainaccuracy=trainaccuracy[1:]
validaccuracy=validaccuracy[1:]
testaccuracy=testaccuracy[1:]
xnumNodes=xnumNodes[1:]

# Create plots with pre-defined labels.
fig, ax = plt.subplots()
ax.plot(xnumNodes, trainaccuracy, label='TrainingData accuracy')
ax.plot(xnumNodes, validaccuracy, label='ValidationData accuracy')
ax.plot(xnumNodes, testaccuracy,  label='TestData accuracy')

# Now add the legend with some customizations.
legend = ax.legend(loc='center right', shadow=True)

# The frame is matplotlib.patches.Rectangle instance surrounding the legend.
frame = legend.get_frame()
frame.set_facecolor('0.90')

# Set the fontsize
for label in legend.get_texts():
    label.set_fontsize('small')

for label in legend.get_lines():
    label.set_linewidth(1.5)  # the legend line width

plt.show()
