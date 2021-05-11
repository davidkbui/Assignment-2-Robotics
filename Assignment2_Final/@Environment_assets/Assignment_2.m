% spawnEnvironment();
addpath('New_bricks');
 yellowBrick();



% Functions

function [] = spawnEnvironment()

hold on

axis([-3 3 -3 3 0 3]);
surf([-3,-3;3,3],[-3,3;-3,3],[0.01,0.01;0.01,0.01],'CData',imread('hardwood-floor.jpeg'),'FaceColor','texturemap'); % Concrete floor
surf([-3,3;-3,3],[3,3;3,3],[0,0;3,3],'CData',imread('office_wall_1.jpeg'),'FaceColor','texturemap'); % Concrete floor
surf([3,3;3,3],[-3,3;-3,3],[0,0;3,3],'CData',imread('window.jpeg'),'FaceColor','texturemap'); % Concrete floor

PlaceObject('table.ply',[0 0 0]);
PlaceObject('dummy.ply',[1.5 2 0]);
PlaceObject('chair.ply',[-2 -2 0]);
PlaceObject('chair.ply',[0 -2 0]);
PlaceObject('chair.ply',[2 -2 0]);
PlaceObject('fence1.ply',[-2 0 0]);
PlaceObject('fence1.ply',[2 0 0]);
PlaceObject('fence2.ply',[0 1.2 0]);
PlaceObject('fence2.ply',[0 -1.2 0]);
PlaceObject('firstaid.ply',[-2 2.5 0]);
PlaceObject('stop.ply',[2.7 2.9 1.5]);
PlaceObject('yellowBrick.ply',[0,0,0]);

axis equal
camlight

initBrickPose = [-0.3 -0.3 0.2; -0.3 0 0.2; -0.3 0.3 0.2; 0 -0.3 0.2; 0 0 0.2; 0 0.3 0.2;0.3 -0.3 0.2; 0.3 0 0.2; 0.3 0.3 0.2]

PlaceObject('brick.ply',initBrickPose(1,1:3))
PlaceObject('brick.ply',initBrickPose(2,1:3))
PlaceObject('brick.ply',initBrickPose(3,1:3))
% second layer
PlaceObject('brick.ply',initBrickPose(4,1:3))
PlaceObject('brick.ply',initBrickPose(5,1:3))
PlaceObject('brick.ply',initBrickPose(6,1:3))
%third layer
PlaceObject('brick.ply',initBrickPose(7,1:3))
PlaceObject('brick.ply',initBrickPose(8,1:3))
PlaceObject('brick.ply',initBrickPose(9,1:3))

disp('SPAWN ENVIRONMENT COMPLETE')
end

function [] = yellowBrick()

hold on

% surf([-3,-3;3,3],[-3,3;-3,3],[0.01,0.01;0.01,0.01],'CData',imread('hardwood-floor.jpeg'),'FaceColor','texturemap');
PlaceObject('2x4_yellow.ply',[0 0 0]);
axis equal
camlight
end