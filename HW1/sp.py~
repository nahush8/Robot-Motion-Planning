import sys

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

path = []
tempList = []
tempNodeList = []
graph = []
adj = [[0 for i in xrange(numOfVertices+1)] for i in xrange(numOfVertices+1)]
for x in range(3,len(data)):
	a = int(data[x].split()[0])
	b = int(data[x].split()[1])
	c = float(data[x].split()[2])
	graph.append([a,b,c]) #Creating a graph of vertices and edges
	adj[a][b] = c #creating an adjacency matrix
dist = [float("inf")] * (numOfVertices+1)
dist[goalVertex] = 0 #Initializing value funtion of goal vertex to zero

for i in range (0,numOfVertices-1): #worst case there would be numOfVertices -1 edges so iterating over all the edges
	for u, v, w in graph:
		if dist[u] != float("inf") and dist[u] + w < dist[v]:
			dist[v] = dist[u] + w #Updating value function
'''
starting from the startingVertex, for all the neighbours, 
find the minimum cost function, append the vertex to the path
and continue to do so till you reach the goal vertex.
'''

currVertex = startingVertex
path.append(startingVertex)
while True:
	for i in range(1,numOfVertices +1):
		if adj[currVertex][i] != 0:
			tempList.append(dist[i])
			tempNodeList.append(i)
	if tempList and tempNodeList:
		currVertex = tempNodeList[tempList.index(min(tempList))]
	tempList[:] = []
	tempNodeList[:]=[]
	path.append(currVertex)
	if currVertex == goalVertex:
		break
del dist[0]
print path
print dist
output = open('output.txt','w')
for item in path:
	output.write("%s "% item)
output.write("\n")
for item in dist:
	output.write("%s "% item)
output.close()
