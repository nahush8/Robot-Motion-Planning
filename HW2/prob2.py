import sys
from math import sqrt

coordList = []
coordFileList = ['coords_1.txt','coords_2.txt','coords_3.txt']
inputFileList = ['input_1.txt','input_2.txt','input_3.txt']
output_costs_file = open('output_costs','w')
output_numiters_file = open('output_numiters','w')


for fileIterator in range(0,3):

	coordFile = coordFileList[fileIterator]
	fname = inputFileList[fileIterator]
	with open(coordFile) as f2:
		data = f2.readlines()
	f2.close()
	data = [x.strip() for x in data] #Getting the input data from the file
	for z in range(0,len(data)):
		coordList.append((data[z].split()[0],data[z].split()[1]))

	with open(fname) as f:
		data = f.readlines()
	f.close()
	data = [x.strip() for x in data] #Getting the input data from the file
	
	numOfVertices = int(data[0])
	startingVertex = int(data[1])
	goalVertex = int(data[2])
	epsilon = 4
	goalCoordinateX,goalCoordinateY = coordList[goalVertex-1]
	goalCoordinateX = float(goalCoordinateX)
	goalCoordinateY = float(goalCoordinateY)


	for algoIterator in range(0,6):
		def heuristics(vertices,epsilon):

			x,y = coordList[vertices-1]
			x = float(x)
			y = float(y)
			return epsilon * sqrt((x-goalCoordinateX)*(x-goalCoordinateX)+(y-goalCoordinateY)*(y-goalCoordinateY))

		graph = []
		adj = [[-99 for i in xrange(numOfVertices+1)] for i in xrange(numOfVertices+1)]
		for x in range(3,len(data)):
			a = int(data[x].split()[0])
			b = int(data[x].split()[1])
			c = float(data[x].split()[2])
			graph.append([a,b,c]) #Creating a graph of vertices and edges
			adj[a][b] = c #creating an adjacency matrix

		openList = []
		closedList = []
		cost = [float("inf")] * (numOfVertices+1)
		cost[startingVertex] = 0
		openList.append(startingVertex)
		tempCostList = []

		while True:	
			for vertices in openList:
				tempCostList.append((vertices, cost[vertices] +  heuristics(vertices,algoIterator)))
			minCostVertex,minCost = min(tempCostList, key = lambda t: t[1])
			tempCostList[:] = []
			
			del openList[openList.index(minCostVertex)]
			closedList.append(minCostVertex)
			
			if minCostVertex == goalVertex:
				break
			
			for i in range(1,numOfVertices+1):
					if adj[minCostVertex][i] != -99:
						if i not in closedList:
							costNew = cost[minCostVertex] + adj[minCostVertex][i]
							if cost[i] > costNew:
								cost[i] = costNew
							if i not in openList:
								openList.append(i)
								
		output_costs_file.write(str(cost[goalVertex]) + "\t")
		output_numiters_file.write(str(len(closedList)) + "\t")
		print "========================="
		print "OUTPUT WRITTEN FOR ONE ALGO"
		print "========================="
	
	print "========================="
	print "OUTPUT WRITTEN FOR ONE FILE"
	print "========================="
	output_costs_file.write("\n")
	output_numiters_file.write("\n")

output_costs_file.close()
output_numiters_file.close()