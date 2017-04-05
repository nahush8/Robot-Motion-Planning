import sys
from operator import itemgetter
import math
import copy

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
path = []
optimalNeighbor = [-99] * (numOfVertices+1)
graph = []
neighborList = []
tempList = []
tempNodeList = []
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
dist = [float("inf")] * (numOfVertices+1)
dist[goalVertex] = 0 #Initializing value funtion of goal vertex to zero
neighborList.append([])
for i in range(1,numOfVertices+1):
	tempNodeList = []
	for j in range(1,numOfVertices+1):
		if adj[i][j] != 0:
			tempNodeList.append(j)
			numOfEdges[i] = numOfEdges[i] + 1
	neighborList.append(tempNodeList)

#print neighborList
for itr in range(0,100):
	for i in range(1,numOfVertices+1):
		sumValueFn = 0
		for index, node in enumerate(neighborList[i]):
			intendedVertex = node
			for index2, node2 in enumerate(neighborList[i]):
				if i == goalVertex:
					sumValueFn = 0
				elif node2 == intendedVertex:
					sumValueFn += Tij * (-adj[i][node2] + valueFn[node2])
				else:
					sumValueFn += (TijPrime/(numOfEdges[i]-1)) * (-adj[i][node2] + valueFn[node2])
			tempList.append(sumValueFn)
			sumValueFn = 0
		valueFn[i] = max(tempList)
		tempList[:]=[]
finalist = []
for u in range(0,len(neighborList[numOfVertices])):
	finalist.append(neighborList[numOfVertices][u])
for i in range(1,numOfVertices+1):
	tempNodeList[:] = []
	if i == numOfVertices:
		for index, node in enumerate(finalist):
			#print node
			tempList.append(valueFn[node])
			tempNodeList.append(node)
		if tempList and tempNodeList:
			nextVertex = tempNodeList[tempList.index(max(tempList))]
			path.append((nextVertex))
		tempList[:] = []
		tempNodeList[:]=[]
	else:
		for index, node in enumerate(neighborList[i]):
			#print node
			tempList.append(valueFn[node])
			tempNodeList.append(node)
		if tempList and tempNodeList:
			nextVertex = tempNodeList[tempList.index(max(tempList))]
			path.append((nextVertex))
		tempList[:] = []
		tempNodeList[:]=[]

del valueFn[0]
print valueFn
print path

output = open('output.txt','w')
for item in valueFn:
	output.write("%s,"% item)
output.write("\n")

for item in path:
	output.write("%s,"% item)
output.close()
