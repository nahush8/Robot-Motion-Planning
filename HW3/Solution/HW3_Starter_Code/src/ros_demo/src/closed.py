#!/usr/bin/env python
import rospy
from geometry_msgs.msg import Twist
from nav_msgs.msg import Odometry
import tf
import math

inputFile = 'input.txt'
with open(inputFile) as f:
	data = f.readlines()
data = [x.strip() for x in data]
goal = []
for x in range(0,len(data)):
	a = int(data[x].split()[0])
	b = int(data[x].split()[1])
	goal.append((a,b))
 

kP = 0.75
tolerence = 0.2
if __name__ == '__main__':
	#required to access ros. If this gives an error, make sure you are running roscore on your machine.
    rospy.init_node('dumbot')
    #advertise the topic we wish to publish. Roscore will connect us to the other processes that wish to read from this topic
    p = rospy.Publisher('/cmd_vel', Twist)
    #A helpful way to print debugging information
    rospy.loginfo("Up and running. Run Gazebo to simulate the robot and RVIZ to see the sensor data.")
    twist=Twist()
    i = 0
    while not rospy.is_shutdown():
	goalX, goalY = goal[i]
	print goalX
	print goalY
	###########################################
	#            YOUR CODE HERE               #
	###########################################
	msg= rospy.wait_for_message('/odom', Odometry)
	(roll, pitch, yaw) = tf.transformations.euler_from_quaternion([msg.pose.pose.orientation.x, msg.pose.pose.orientation.y, msg.pose.pose.orientation.z, msg.pose.pose.orientation.w])
	currX = msg.pose.pose.position.x
	currY = msg.pose.pose.position.y
	
	heading  = math.atan2((goalY - currY),(goalX - currX))
	error = kP * (heading - yaw)
	errDist = math.sqrt((goalX - currX)*(goalX - currX)+(goalY - currY)*(goalY - currY))
	print "=============="
	print error
	print "=============="
	
	print "                "
	print "=============="
	print errDist
	print "=============="
	if errDist < tolerence:
		print "GOAL REACHED"
		twist.angular.z = 0
		twist.linear.x = 0
		p.publish(twist)
		rospy.sleep(2)
		i = i+1
		if i == len(goal):
			print "===== FULL PATH DONE ======"
			break
	if error > 0:		
		twist.angular.z = error
	else:
		twist.angular.z = error
	twist.linear.x = 0.5
	p.publish(twist)

	#p.publish(twist)
	rospy.loginfo("Publishing!!")
	rospy.sleep(0.1)




