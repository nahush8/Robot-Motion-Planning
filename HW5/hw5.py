import sys
from operator import itemgetter
import math

fname = sys.argv[1]
with open(fname) as f:
	data = f.readlines()
f.close()
data = [x.strip() for x in data] #Getting the input data from the file
numOfVertices = int(data[0])
startingVertex = int(data[1])
goalVertex = int(data[2])
print numOfVertices
print startingVertex
print goalVertex

valueFn = [0] * (numOfVertices+1)
optimalNeighbor = [-99] * (numOfVertices+1)
graph = []
neighborList = []
tempValueFnList = []
tempDict = {}
tempValueFn = 0
Tij = 0.7
TijPrime = 0.3
numOfEdges = [0 for i in xrange(numOfVertices+1)]
adj = [[0 for i in xrange(numOfVertices+1)] for i in xrange(numOfVertices+1)]
for x in range(3,len(data)):
	a = int(data[x].split()[0])
	b = int(data[x].split()[1])
	c = float(data[x].split()[2])
	graph.append([a,b,c]) #Creating a graph of vertices and edges
	adj[a][b] = c #creating an adjacency matrix'
neighborList.append([])
for i in range(1,numOfVertices+1):
	tempNodeList = []
	for j in range(1,numOfVertices+1):
		if adj[i][j] != 0:
			tempNodeList.append(j)
			numOfEdges[i] = numOfEdges[i] + 1
	neighborList.append(tempNodeList)

for i in range(1,numOfVertices+1):
	tempList = []
	for j in neighborList[i]:
		tempList.append(j)
	for k in range(0,len(tempList)):
		for z in range(0,len(tempList)):
			if z == k:
				tempValueFn += Tij * (-adj[i][tempList[z]] + valueFn[tempList[z]])
			else:
				tempValueFn += (TijPrime/(len(tempList)-1)) * (-adj[i][tempList[z]] + valueFn[tempList[z]])
		#tempValueFn = round(tempValueFn,3)
		tempValueFnList.append((tempValueFn,tempList[z]))
		#tempValueFn = 0	
	print tempValueFnList	
		#tempValueFnList.append(tempValueFn)
	valueFn[i] = max(tempValueFnList,key=itemgetter(1))[0]
	tempDict = dict(tempValueFnList)
	#print tempDict[valueFn[i]]	
	optimalNeighbor[i] = tempDict[valueFn[i]]
	#valueFn[i] = max(tempValueFnList)
	tempValueFnList = []

del valueFn[0]
del optimalNeighbor[0]
#	del optimalNeighbor[0]
#print valueFn
#	print optimalNeighbor


