#!/usr/bin/env python
import rospy
from geometry_msgs.msg import Twist

if __name__ == '__main__':
    #required to access ros. If this gives an error, make sure you are running roscore on your machine.
    rospy.init_node('dumbot')
    #advertise the topic we wish to publish. Roscore will connect us to the other processes that wish to read from this topic
    p = rospy.Publisher('/cmd_vel', Twist)
    #A helpful way to print debugging information
    rospy.loginfo("Up and running. Run Gazebo to simulate the robot and RVIZ to see the sensor data.")
    twist=Twist()
    rospy.sleep(2)  
    while not rospy.is_shutdown():
    
        twist.linear.x=0.5
        p.publish(twist)
        rospy.loginfo("MOVING STRAIGHT!!")
        # wait for 4 meters
        rospy.sleep(5)    
        
           
        twist.linear.x=0
        twist.angular.z=0
        p.publish(twist)
        rospy.sleep(5)
        

        twist.angular.z=0.5
        p.publish(twist)
        rospy.sleep(1.85)
        
        twist.linear.x=0
        twist.angular.z=0
        p.publish(twist)
        rospy.sleep(4)
        
        # rotate in place by making linear.x = 0 and angular.z to some non-zero value
        # publish new velocity
        # wait for 90 degrees
        # repeat




