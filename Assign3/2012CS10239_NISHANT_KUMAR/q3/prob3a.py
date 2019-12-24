import sys,math
import pprint as pp

def output(dlist):
	for row in dlist:
		for val in row:
			sys.stdout.write('%-5.5f\t' % val)
		sys.stdout.write('\n')
	sys.stdout.write('\n')

trainfid = open('./q3_data/train-0.data')
lines = trainfid.readlines()

# The CPT tables - make one extra column for the total number of examples in that category
diff = [0,0,0]
intel = [0,0,0]
grade = [[0,0,0,0] for x in xrange(4)]
sat = [[0,0,0] for x in xrange(2)]
letter = [[0,0,0] for x in xrange(3)]

splitLines = []
for l in lines:
	arr = l.split()
	arr = map(int,arr)
	# print arr
	splitLines.append(arr)

	# use arr to fill in the CPT
	diff[arr[0]] += 1
	diff[2] += 1

	intel[arr[1]] += 1
	intel[2] += 1

	# grade[binary(i,d)][.]
	# Remember grade is 1 indexed
	grade[arr[1]*2 + arr[0]][arr[2]-1] += 1
	grade[arr[1]*2 + arr[0]][3] += 1

	# sat[i][.]
	sat[arr[1]][arr[3]] += 1
	sat[arr[1]][2] += 1

	# letter[grade][.]
	# Remember grade is 1 indexed
	letter[arr[2]-1][arr[4]] += 1
	letter[arr[2]-1][2] += 1

cptD = [[diff[0]*1.0/diff[2],diff[1]*1.0/diff[2]]]
cptI = [[intel[0]*1.0/intel[2],intel[1]*1.0/intel[2]]]
cptG = [[r[0]*1.0/r[3],r[1]*1.0/r[3],r[2]*1.0/r[3]] for r in grade]
cptS = [[r[0]*1.0/r[2],r[1]*1.0/r[2]] for r in sat]
cptL = [[r[0]*1.0/r[2],r[1]*1.0/r[2]] for r in letter]

# Calculate the math.log likelihood of test data
fidtest = open('./q3_data/test.data')
testlines = fidtest.readlines()
logli = 0.0
for l in testlines:
	arr = map(int,l.split())
	logli += math.log(cptD[0][arr[0]])
	logli += math.log(cptI[0][arr[1]])
	logli += math.log(cptG[ arr[1]*2 + arr[0] ][arr[2]-1])
	logli += math.log(cptS[arr[1]][arr[3]])
	logli += math.log(cptL[arr[2]-1][arr[4]])


# Display the CPTs
sys.stdout.write('\n******** CPT for Difficulty **********\n')
output(cptD)
sys.stdout.write('\n******** CPT for Intelligence **********\n')
output(cptI)
sys.stdout.write('\n******** CPT for Grade **********\n')
output(cptG)
sys.stdout.write('\n******** CPT for SAT **********\n')
output(cptS)
sys.stdout.write('\n******** CPT for Letter **********\n')
output(cptL)

sys.stdout.write('\n******** LogLikelihood of data **********\n')
sys.stdout.write('%-5.5f' % logli)
