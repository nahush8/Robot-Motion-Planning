rosshutdown
rosinit

while(true)
    %intialize publisher
    pub = rospublisher('/cmd_vel');
    %initialize the message
    msg = rosmessage('geometry_msgs/Twist');
    %populate the message
    %publish
    send(pub,msg); 
end