


function obstacleCreation(sandX,sandY)
% sandX = [-10.00,-10.00,10.00,10.00,-8.00,-8.00,9.00,9.00,-9.00,-9.00];
% sandY = [10.00,-10.00,-10.00,10.00,10.00,9.00,9.00,-9.00,-9.00,10.00];
plot(sandX,sandY,'.')
xlim([-15,15])
ylim([-15,15])

line(sandX, sandY,'Color','r')
 fill(sandX,sandY,'y')
numOfX = numel(sandX);
finishX = [sandX(1), sandX(numOfX)];
finishY = [sandY(1), sandY(numOfX)];
line(finishX, finishY,'Color','r');
end