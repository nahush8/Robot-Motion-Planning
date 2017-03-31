 sandX = [0.00,-0.00,1.00,1.00,0.00 , 0.00,2.00,2.00];
 sandY = [3.00,  2.00,  2.00,  -2.00, -2.00, -3.00,  -3.00,  3.00];
 
plot(sandX,sandY,'.')
hold on
plot(12,12,'*')
xlim([-15,15])
ylim([-15,15])

line(sandX, sandY,'Color','r')
 fill(sandX,sandY,'y')
numOfX = numel(sandX);
finishX = [sandX(1), sandX(numOfX)];
finishY = [sandY(1), sandY(numOfX)];
line(finishX, finishY,'Color','r');