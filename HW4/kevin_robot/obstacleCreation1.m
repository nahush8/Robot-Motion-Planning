% create obstacles on plot


function obstacleCreation1(start, goal, obstacles)
hold on;
plot(start(1), start(2), 'p', 'MarkerSize', 10, 'MarkerEdgeColor', 'r')
plot(goal(1), goal(2), '*', 'MarkerSize', 10, 'MarkerEdgeColor', 'g')
xlim([-15,15])
ylim([-15,15])

[m, n] = size(obstacles);

for i = 1:m
    x = [];
    y = [];
    for j = 1:n
        if mod(j, 2)
            x(end+1) = obstacles(i, j);
        else
            y(end+1) = obstacles(i, j);
        end
    end
    for j = 1:n/2
        if x(j) == 0 && y(j) == 0
           x = x(1:j-1);
           y = y(1:j-1);
           break
        end
    end
    plot(x, y, '.', 'MarkerEdgeColor', 'b')
    line(x, y)
    numOfX = numel(x);
    
    % creation of last edge
    
    lastX = [x(1), x(numOfX)];
    lastY = [y(1), y(numOfX)];
    line(lastX, lastY);
end

end