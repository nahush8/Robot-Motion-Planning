#!/usr/bin/env python

import sys, random, math, pygame
from pygame.locals import *
from math import sqrt,cos,sin,atan2
from RRT_includes import *

#constants
XDIM = 300
YDIM = 300
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
    rectObs.append(pygame.Rect((50,50),(10,200)))
    rectObs.append(pygame.Rect((50,240),(200,10)))
    rectObs.append(pygame.Rect((240,50),(10,200)))
    rectObs.append(pygame.Rect((70,50),(180,10)))

    rectObs.append(pygame.Rect((70,70),(10,160)))
    rectObs.append(pygame.Rect((70,220),(150,10)))
    rectObs.append(pygame.Rect((210,70),(10,70)))
    rectObs.append(pygame.Rect((210,150),(10,70)))
    rectObs.append(pygame.Rect((70,70),(150,10)))


    rectObs.append(pygame.Rect((100,100),(10,40)))
    rectObs.append(pygame.Rect((100,150),(10,50)))
    rectObs.append(pygame.Rect((100,190),(90,10)))
    rectObs.append(pygame.Rect((180,100),(10,100)))
    rectObs.append(pygame.Rect((100,100),(90,10)))

    rectObs.append(pygame.Rect((120,120),(10,50)))
    rectObs.append(pygame.Rect((160,120),(10,50)))
    
    rectObs.append(pygame.Rect((120,120),(20,10)))
    rectObs.append(pygame.Rect((120,170),(20,10)))
    rectObs.append(pygame.Rect((150,120),(20,10)))
    rectObs.append(pygame.Rect((150,170),(20,10)))

    for rect in rectObs:
        pygame.draw.rect(screen, yellow, rect)


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
    
    initialPoint = Node((150,150), None)
    nodes.append(initialPoint) # Start in the center
    initPoseSet = True
    pygame.draw.circle(screen, red, initialPoint.point, START_RADIUS) 

    goalPoint = Node((270,30),None)
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
