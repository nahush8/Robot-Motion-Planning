#include <ros/ros.h>
#include <geometry_msgs/Twist.h>

int main(int argc, char** argv){

	// required to access ros. If this gives an error, make sure you are running
	// roscore on your machine.
	ros::init(argc,argv,"dumbot");

	//advertise the topic we wish to publish. Roscore will connect us to the
	//other processes that wish to read from this typic
	ros::NodeHandle nh("/");
	ros::Publisher velout = nh.advertise<geometry_msgs::Twist>("/cmd_vel",5);

	//A helpful way to print debugging information
	ROS_INFO("Up and running. Run gazebo to simulate the robot and RVIZ to see the sensor data.");

	while(ros::ok()){

		//New outgoing message.
		geometry_msgs::Twist msg;

		/** Here you must set the velocities. **/

		//send the commanded velocities
		velout.publish(msg);
	}
	return 0;
}
