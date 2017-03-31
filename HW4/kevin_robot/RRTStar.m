% RRT* algorithm in 2D with collision avoidance.
%
% 
%
% nodes:    Contains list of all explored nodes. Each node contains its
%           coordinates, cost to reach and its parent.
%
% Brief description of algorithm:
% 1. Pick a random node q_rand.
% 2. Find the closest node q_near from explored nodes to branch out from, towards
%    q_rand.
% 3. Steer from q_near towards q_rand: interpolate if node is too far away, reach
%    q_new. Check that obstacle is not hit.
% 4. Update cost of reaching q_new from q_near, treat it as Cmin. For now,
%    q_near acts as the parent node of q_new.
% 5. From the list of 'visited' nodes, check for nearest neighbors with a
%    given radius, insert in a list q_nearest.
% 6. In all members of q_nearest, check if q_new can be reached from a
%    different parent node with cost lower than Cmin, and without colliding
%    with the obstacle. Select the node that results in the least cost and
%    update the parent of q_new.
% 7. Add q_new to node list.
% 8. Continue until maximum number of nodes is reached or goal is hit.

clearvars
close all
input=inputpop;
l=1;
k=1;
q_start.coord = [0 0];
q_goal.coord = [12 12];
for i=2:length(input(:,1))
for j =1: length(input(i,:))
    %     for j=1:length(input(i,:))
    kaka=1;
    if (mod(j,2) == 0)
  %number is even
  ne=1;
    else
    
  %number is odd
  ne=0;
    end

    if(ne==0)
   xx(i-1,l)=input(i,j);
   l=l+1;
    end
  
   if(ne==1)
   yy(i-1,k)=input(i,j);
   k=k+1;
   end
   
   
end
    k=1;
    l=1;
      
end
for obs=1:length(xx(:,1))
    for j=1:length(xx(1,:))
        
        
sandX(obs,j) = xx(obs,j);
sandY(obs,j) = yy(obs,j);
if (obs==5)
ak=1;
end

        if( isnan(xx(obs,j+1)))
           break;
           rara=1;
        end
        
    end
    if (obs==5)
        aka=1;
    end
    
%     obstacleCreation(sandX(obs,:),sandY(obs,:));
    
    hold on
   

end
[start,goal,obstacles] = readInputFile('input_maze.txt');
obstacleCreation1(start,goal,obstacles);
 sandXt = [-10.00,-10.00,10.00,10.00,-8.00,-8.00,9.00,9.00,-9.00,-9.00];
 sandYt = [10.00,-10.00,-10.00,10.00,10.00,9.00,9.00,-9.00,-9.00,10.00];
%  fill(sandXt,sandYt,'y')
x_max = 15;
y_max = 15;

% obstacleCreation(sandX,sandY);

% obstacle1 = [-10,-10,1,20];
EPS = 2;
numNodes = 20000;

q_start.coord = [0 0];
q_start.cost = 0;
q_start.parent = 0;
q_goal.coord = [12 12];
q_goal.cost = 0;

nodes(1) = q_start;
figure(1)
axis([-15 x_max -15 y_max])
 goal = [12,12,1,1];
 rectangle('Position',goal,'FaceColor',[0 .5 .5])
% obstacleCreation(sandX,sandY)
hold on

 colide(1)=0;
  colide(2)=0;
   colide(3)=0;
   colide2(1)=0;
  colide2(2)=0;
   colide2(3)=0;
   colide3(1)=0;
  colide3(2)=0;
   colide3(3)=0;
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     a = -12;
b =12;
rx = (b-a).*rand(100000,1) + a;
ry = (b-a).*rand(100000,1) + a;
brake=0;
for i = 1:1:numNodes
  
%     q_rand = [randi([-15 15],1,1) randi([-15 15],1,1)];
q_rand = [rx(i) ry(i)];
%     plot(q_rand(1), q_rand(2), 'x', 'Color',  [0 0.4470 0.7410])
    
    % Break if goal node is already reached
    for j = 1:1:length(nodes)
        if ( abs(nodes(j).coord - q_goal.coord) < 2)
            brake=1
        end
    end
    if (brake==1)
        break;
    end
    
    
    % Pick the closest node from existing list to branch out from
    ndist = [];
    for j = 1:1:length(nodes)
        n = nodes(j);
        tmp = dist(n.coord, q_rand);
        ndist = [ndist tmp];
    end
    [val, idx] = min(ndist);
    q_near = nodes(idx);
    
    q_new.coord = steer(q_rand, q_near.coord, val, EPS);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for ll=1:length(xx(:,1)) %ignoring 4 and 5 
      el=find(isnan(xx(ll,:)));
     for jj=1:el-1
        new_xx(jj)= xx(ll,jj);
        aka=1;
        
         new_yy(jj)= yy(ll,jj);
     end
        nc(ll)= obstacleAvoidance(q_rand, q_near.coord,  new_xx, new_yy);
        aka=1;
        
         new_xx=[];
         new_yy=[];
         aka=1;
    end
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%   
    

          colide=find(nc==0);
          aka=1;
          if isempty(colide)
             colide(1) = 0;
             colide(2) = 0;
             colide(3) = 0;
          end
          
%           if obstacleAvoidance(q_rand, q_near.coord, sandXt, sandYt)    
        if (colide(1) == 0 && colide(2)== 0 && colide(3)== 0)
            
        line([q_near.coord(1), q_new.coord(1)], [q_near.coord(2), q_new.coord(2)], 'Color', 'k', 'LineWidth', 2);
        drawnow
        hold on
        q_new.cost = dist(q_new.coord, q_near.coord) + q_near.cost;
        
        % Within a radius of r, find all existing nodes
        q_nearest = [];
        r = 0.6;%change
        neighbor_count = 1;
        for j = 1:1:length(nodes)
            
              for lll=1:length(xx(:,1)) %ignoring 4 and 5 
      el=find(isnan(xx(lll,:)));
     for jjj=1:el-1
        new_xx(jjj)= xx(lll,jjj);
        aka=1;
        
         new_yy(jjj)= yy(lll,jjj);
     end
     
        nc(lll)= obstacleAvoidance(nodes (j).coord, q_new.coord,  new_xx, new_yy);
        aka=1;
        
         new_xx=[];
         new_yy=[];
         aka=1;
              end
    
             colide2=find(nc==0);
             if isempty(colide2)
             colide2(1) = 0;
             colide2(2) = 0;
             colide2(3) = 0;
             end
          
            if colide2(1)==0 && colide2(2)==0 && colide2(3)==0 && dist(nodes(j).coord, q_new.coord) <= r
                q_nearest(neighbor_count).coord = nodes(j).coord;
                q_nearest(neighbor_count).cost = nodes(j).cost;
                neighbor_count = neighbor_count+1;
            end
            colide2(:)=0;
        end
        
        % Initialize cost to currently known value
        q_min = q_near;
        C_min = q_new.cost;
        
        % Iterate through all nearest neighbors to find alternate lower
        % cost paths
        
        for k = 1:1:length(q_nearest)
                  for llll=1:length(xx(:,1)) %ignoring 4 and 5 
      el=find(isnan(xx(llll,:)));
     for jjjj=1:el-1
        new_xx(jjjj)= xx(llll,jjjj);
        aka=1;
        
         new_yy(jjjj)= yy(llll,jjjj);
     end
     
        nc(llll)= obstacleAvoidance(q_nearest (k).coord, q_new.coord,  new_xx, new_yy);
        aka=1;
        
         new_xx=[];
         new_yy=[];
         aka=1;
              end
    
             colide3=find(nc==0);
              if isempty(colide3)
             colide3(1) = 0;
             colide3(2) = 0;
             colide3(3) = 0;
             end
            if colide3(1)==0  && colide3(2)==0  && colide3(3)==0  && q_nearest(k).cost + dist(q_nearest(k).coord, q_new.coord) < C_min
                q_min = q_nearest(k);
                C_min = q_nearest(k).cost + dist(q_nearest(k).coord, q_new.coord);
                line([q_min.coord(1), q_new.coord(1)], [q_min.coord(2), q_new.coord(2)], 'Color', 'g');
                hold on
            end
             colide3(:)=0;
        end
        
        % Update parent to least cost-from node
        for j = 1:1:length(nodes)
            if nodes(j).coord == q_min.coord
                q_new.parent = j;
            end
        end
        
        % Append to nodes
        nodes = [nodes q_new];
        end
    colide(:)=0;
    if colide==0
    aka=1;
    end
    
    
end

D = [];
for j = 1:1:length(nodes)
    tmpdist = dist(nodes(j).coord, q_goal.coord);
    D = [D tmpdist];
end

% Search backwards from goal to start to find the optimal least cost path
[val, idx] = min(D);
q_final = nodes(idx);
q_goal.parent = idx;
q_end = q_goal;
nodes = [nodes q_goal];
while q_end.parent ~= 0
    start = q_end.parent;
    line([q_end.coord(1), nodes(start).coord(1)], [q_end.coord(2), nodes(start).coord(2)], 'Color', 'r', 'LineWidth', 2);
    hold on
    q_end = nodes(start);
end


