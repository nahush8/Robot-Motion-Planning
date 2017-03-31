rosshutdown
rosinit

while(true)
    %intialize publisher
    pub = rospublisher('/cmd_vel');
    %initialize the message
    msg = rosmessage('geometry_msgs/Twist');
    %populate the message
    msg.Linear.X=0.5;
    %publish
    send(pub,msg);
    
    % wait for 4 meters
    % rotate in place by making linear.x = 0 and angular.z to some non-zero value
    % publish new velocity
    % wait for 90 degrees
    %repeat
end