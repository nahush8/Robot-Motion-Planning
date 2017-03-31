#!/usr/bin/env python

import sys, random, math, pygame
from pygame.locals import *
from math import sqrt,cos,sin,atan2
from RRT_includes import *

#constants
XDIM = 150
YDIM = 170
WINSIZE = [XDIM, YDIM]
EPSILON = 7.0
NUMNODES = sys.maxint #Maximum number of nodes
GOAL_RADIUS = 10
START_RADIUS = 5
MIN_DISTANCE_TO_ADD = 1.0


pygame.init()
fpsClock = pygame.time.Clock()

#initialize and prepare screen
screen = pygame.display.set_mode(WINSIZE)

pygame.display.set_caption('Rapidly Exploring Random Tree')
white = 255, 240, 200
black = 20, 20, 40
red = 255, 0, 0
blue = 0, 0, 255
green = 0, 255, 0
cyan = 0,255,255
yellow = 255,255,0

# setup program variables
count = 0
rectObs = []


def dist(p1,p2):
    return sqrt((p1[0]-p2[0])*(p1[0]-p2[0])+(p1[1]-p2[1])*(p1[1]-p2[1]))

def step_from_to(p1,p2):
    if dist(p1,p2) < EPSILON:
        return p2
    else:
        theta = atan2(p2[1]-p1[1],p2[0]-p1[0])
        return p1[0] + EPSILON*cos(theta), p1[1] + EPSILON*sin(theta)

def collides(p):
    for rect in rectObs:
        if rect.collidepoint(p) == True:
            # print ("collision with object: " + str(rect))
            return True
    return False


def get_random():
    return random.random()*XDIM, random.random()*YDIM

def get_random_clear():
    while True:
        p = get_random()
        noCollision = collides(p)
        if noCollision == False:
            return p

def init_obstacles():
    global rectObs
    rectObs = []
    rectObs.append(pygame.Rect((40,60),(50,80)))
    rectObs.append(pygame.Rect((80,20),(30,60)))

    pl1 = [(40, 140), (80 ,140), (90 ,130), (90 ,100),(80 ,90), (70 ,90), (70 ,100), (60 ,110), ( 50,100), (40 ,100)]
    pl2 = [(40, 60), (40 ,100), (60 ,100), (70 ,90),(70 ,70), (60 ,60)]
    pl3 = [(80, 20), (80 ,80), (100 ,80), (110 ,70),(110 ,30), (100 ,20)]

    pygame.draw.polygon(screen, yellow, pl1)
    pygame.draw.polygon(screen, yellow, pl2)
    pygame.draw.polygon(screen, yellow, pl3)


def reset():
    global count
    screen.fill(black)
    init_obstacles()
    count = 0


def main():
    global count

    initPoseSet = False
    initialPoint = Node(None, None)
    goalPoseSet = False
    goalPoint = Node(None, None)
    currentState = 'init'

    nodes = []
    reset()
    
    initialPoint = Node((20,150), None)
    nodes.append(initialPoint) # Start in the center
    initPoseSet = True
    pygame.draw.circle(screen, red, initialPoint.point, START_RADIUS) 

    goalPoint = Node((120,50),None)
    goalPoseSet = True
    pygame.draw.circle(screen, green, goalPoint.point, GOAL_RADIUS)
    currentState = 'buildTree'
       

    while True:
        if currentState == 'goalFound':
            #traceback
            currNode = goalNode.parent
            while currNode.parent != None:
                pygame.draw.line(screen,cyan,currNode.point,currNode.parent.point,5)
                currNode = currNode.parent
            optimizePhase = True
        elif currentState == 'optimize':
            fpsClock.tick(0.5)
            pass
    
        elif currentState == 'buildTree':
            count = count+1
            if count < NUMNODES:
                foundNext = False
                while foundNext == False:
                    rand = get_random_clear()
                    # print("random num = " + str(rand))
                    parentNode = nodes[0]

                    for p in nodes: #find nearest vertex
                        if dist(p.point,rand) <= dist(parentNode.point,rand): #check to see if this vertex is closer than the previously selected closest
                            newPoint = step_from_to(p.point,rand)
                            if collides(newPoint) == False: # check if a collision would occur with the newly selected vertex
                                parentNode = p #the new point is not in collision, so update this new vertex as the best
                                foundNext = True

                newnode = step_from_to(parentNode.point,rand)
                nodes.append(Node(newnode, parentNode))
                pygame.draw.line(screen,green,parentNode.point,newnode)

                if point_circle_collision(newnode, goalPoint.point, GOAL_RADIUS):
                    currentState = 'goalFound'
                    goalNode = nodes[len(nodes)-1]

                if count%100 == 0:
                    print("node: " + str(count))
            else:
                print("Ran out of nodes... :(")
                return;
        pygame.display.update()
        fpsClock.tick(10000)


if __name__ == '__main__':
    main()
    input("press Enter to quit")
