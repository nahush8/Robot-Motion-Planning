

function [nc] = obstacleAvoidance(n1, n2, x, y)
A = [n1(1) n1(2)];
B = [n2(1) n2(2)];
%     obs = [o(1) o(2) o(1)+o(3) o(2)+o(4)];
numOfNodes = numel(x);
intersect = [];
for i = 1:(numOfNodes-1)
    C1 = [x(i),y(i)];
    D1 = [x(i+1),y(i+1)];
    intersect(end+1) = ccw(A,C1,D1) ~= ccw(B,C1,D1) && ccw(A,B,C1) ~= ccw(A,B,D1);
end

C1 = [x(end),y(end)];
D1 = [x(1),y(1)];
intersect(end+1) = ccw(A,C1,D1) ~= ccw(B,C1,D1) && ccw(A,B,C1) ~= ccw(A,B,D1);
if max(intersect)==0
    nc = 1;
else
    nc = 0;
end

end

