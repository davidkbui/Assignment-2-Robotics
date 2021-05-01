%% Assignment 1
clear all
close all
clc
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

axis equal
camlight

%% Initial Brick Poses

initBrick1Pose = ([-0.3,-0.3,0.2])
initBrick2Pose = ([-0.3,0,0.2667])
initBrick3Pose = ([-0.3,0.3,0.2])

initBrick4Pose = ([0,-0.3,0.2])
initBrick5Pose = ([0,0,0.2])
initBrick6Pose = ([0,0.3,0.2])

initBrick7Pose = ([0.3,-0.3,0.2])
initBrick8Pose = ([0.3,0,0.2])
initBrick9Pose = ([0.3,0.3,0.2])

%% Final Brick Poses

finalBrick1Pose = [0,-0.3,0.3333]
finalBrick2Pose = [0,-0.3,0.3333]
finalBrick3Pose = [0,0.2667,0.2]

%finalBrick4Pose = [0,-0.2667,0.2667]
%finalBrick5Pose = [0,0,0.2667]
%finalBrick6Pose = [0,0.2667,0.3333]

finalBrick7Pose = [0,0,0.3333]
finalBrick8Pose = [0,0.3,0.5]
finalBrick9Pose = [0,0.3,0.3333]
    
%% Display the UR5
axis vis3d
axis equal
hold on

UR5Pose = [0,0.3,-0.75];

angle = rad2deg(pi/2);

r1 = LinearUR5(false);

r1.model.base = trotx(pi/2) * troty(pi/2) * transl(UR5Pose);

r1.model.animate(r1.model.getpos) 
hold on
q1 = zeros(1,7)

%% Display the UR3 
initialPose = zeros(1,3);
UR3Pose = [.55,0,0.2];

r2 = UR3();
r2.model.base = transl(UR3Pose) * trotz(pi/2);
r2.model.animate(r2.model.getpos)
hold on
q2 = zeros(1,6)

%% Brick Initial Placement
% first layer
brick1 = PlaceObject('brick.ply',initBrick1Pose)
brick2 = PlaceObject('brick.ply',initBrick2Pose)
brick3 = PlaceObject('brick.ply',initBrick3Pose)
% second layer
brick4 = PlaceObject('brick.ply',initBrick4Pose)
brick5 = PlaceObject('brick.ply',initBrick5Pose)
brick6 = PlaceObject('brick.ply',initBrick6Pose)
%third layer
brick7 = PlaceObject('brick.ply',initBrick7Pose)
brick8 = PlaceObject('brick.ply',initBrick8Pose)
brick9 = PlaceObject('brick.ply',initBrick9Pose)

%% Brick Vertices
brick1_vertices = get(brick1,'Vertices')
brick2_vertices = get(brick2,'Vertices')
brick3_vertices = get(brick3,'Vertices')
brick4_vertices = get(brick4,'Vertices')
brick5_vertices = get(brick5,'Vertices')
brick6_vertices = get(brick6,'Vertices')
brick7_vertices = get(brick7,'Vertices')
brick8_vertices = get(brick8,'Vertices')
brick9_vertices = get(brick9,'Vertices')

%%

steps = 50;

disp('Environment is set up')
pause



%% First Step

UR5Brick1Pose = transl(initBrick1Pose(1),initBrick1Pose(2),initBrick1Pose(3)+0.1667) * troty(pi)
UR3Brick9Pose = transl(initBrick9Pose(1),initBrick9Pose(2),initBrick9Pose(3)+0.1667)

UR5_B1= r1.model.ikcon(UR5Brick1Pose, q1); 
UR5_TRAJ_START_TO_B1 = jtraj(q1,UR5_B1,steps);

UR3_B9 = r2.model.ikcon(UR3Brick9Pose, q2);
UR3_TRAJ_START_TO_B9 = jtraj(q2,UR3_B9,steps);

    for i = 1:steps
        animate(r1.model,UR5_TRAJ_START_TO_B1(i,:));                    % Animate UR5 to current brick location
        animate(r2.model,UR3_TRAJ_START_TO_B9(i,:));
        drawnow();
    end
    
% Second   
UR5_B1_PLACE = transl(finalBrick1Pose(1),finalBrick1Pose(2),finalBrick1Pose(3)) * troty(pi);
UR3_B9_PLACE = transl(finalBrick9Pose(1),finalBrick9Pose(2),finalBrick9Pose(3)) * trotx(pi);

UR5_B1_T= r1.model.ikcon(UR5_B1_PLACE, q1); 
UR5_TRAJ_B1_PLACE = jtraj(UR5_B1,UR5_B1_T,steps);

UR3_B9_T = r2.model.ikcon(UR3_B9_PLACE, q2);
UR3_TRAJ_B9_PLACE= jtraj(UR3_B9,UR3_B9_T,steps);

    for i = 1:steps
        animate(r1.model,UR5_TRAJ_B1_PLACE(i,:));                    
        
        tr_B1 = r1.model.fkine(r1.model.getpos) * transl(-initBrick1Pose);
        transformedVertices_B1 = [brick1_vertices,ones(size(brick1_vertices,1),1)]*tr_B1';
        set(brick1,'Vertices',transformedVertices_B1(:,1:3));
        
        animate(r2.model,UR3_TRAJ_B9_PLACE(i,:));
        
        tr_B9 = r2.model.fkine(r2.model.getpos) * transl(-initBrick9Pose);
        transformedVertices_B9 = [brick9_vertices,ones(size(brick9_vertices,1),1)]*tr_B9';
        set(brick9,'Vertices',transformedVertices_B9(:,1:3));
        
        drawnow();
    end
    
% Third
    
UR5Brick2Pose = transl(initBrick2Pose(1),initBrick2Pose(2),initBrick2Pose(3)) * troty(pi)
UR3Brick8Pose = transl(initBrick8Pose(1),initBrick8Pose(2),initBrick8Pose(3))

UR5_B2= r1.model.ikcon(UR5Brick2Pose, q1); 
UR5_TRAJ_START_TO_B2 = jtraj(UR5_B1_T,UR5_B2,steps);

UR3_B8 = r2.model.ikcon(UR3Brick8Pose, q2);
UR3_TRAJ_START_TO_B8 = jtraj(UR3_B9_T,UR3_B8,steps);

for i = 1:steps      
     animate(r1.model,UR5_TRAJ_START_TO_B2(i,:));                    
     animate(r2.model,UR3_TRAJ_START_TO_B8(i,:));
     drawnow();
end

% Fourth

UR5_B2_PLACE = transl(finalBrick2Pose(1),finalBrick2Pose(2),finalBrick2Pose(3)) * troty(pi);
UR3_B8_PLACE = transl(finalBrick8Pose(1),finalBrick8Pose(2),finalBrick8Pose(3)) * trotx(pi);

UR5_B2_T= r1.model.ikcon(UR5_B2_PLACE, q1); 
UR5_TRAJ_B2_PLACE = jtraj(UR5_B2,UR5_B2_T,steps);

UR3_B8_T = r2.model.ikcon(UR3_B8_PLACE, q2);
UR3_TRAJ_B8_PLACE= jtraj(UR3_B8,UR3_B8_T,steps);

    for i = 1:steps
        animate(r1.model,UR5_TRAJ_B2_PLACE(i,:));                    
        
        tr_B2 = r1.model.fkine(r1.model.getpos) * transl(-initBrick2Pose);
        transformedVertices_B2 = [brick2_vertices,ones(size(brick2_vertices,1),1)]*tr_B2';
        set(brick2,'Vertices',transformedVertices_B2(:,1:3));
        
        animate(r2.model,UR3_TRAJ_B8_PLACE(i,:));
        
        tr_B8 = r2.model.fkine(r2.model.getpos) * transl(-initBrick8Pose);
        transformedVertices_B8 = [brick8_vertices,ones(size(brick8_vertices,1),1)]*tr_B8';
        set(brick8,'Vertices',transformedVertices_B8(:,1:3));
        
        drawnow();
    end  
    
% Fifth

UR5Brick3Pose = transl(initBrick3Pose) * troty(pi);
UR3Brick7Pose = transl(initBrick7Pose);

UR5_B3 = r1.model.ikcon(UR5Brick3Pose, q1);
UR5_TRAJ_B3_TO_START = jtraj(UR5_B2_T,UR5_B3,steps);

UR3_B7 = r2.model.ikcon(UR3Brick7Pose, q2);
UR3_TRAJ_START_TO_B8 = jtraj(UR3_B8_T,UR3_B7,steps);


    for i = 1:steps
      animate(r1.model,UR5_TRAJ_B3_TO_START(i,:));
      animate(r2.model,UR3_TRAJ_START_TO_B8(i,:));
      drawnow();
    end
    
% Sixth

UR3_B7_PLACE = transl(finalBrick7Pose) * trotx(pi);

UR3_B7_T = r2.model.ikcon(UR3_B7_PLACE, q2);
UR3_TRAJ_B7_PLACE= jtraj(UR3_B7,UR3_B7_T,steps);

    for i = 1:steps
        animate(r2.model,UR3_TRAJ_B7_PLACE(i,:));
        
        tr_B7 = r2.model.fkine(r2.model.getpos) * transl(-initBrick7Pose);
        transformedVertices_B7 = [brick7_vertices,ones(size(brick7_vertices,1),1)]*tr_B7';
        set(brick8,'Vertices',transformedVertices_B7(:,1:3));
        
        drawnow();
    end


%% Define End-Effector Transformation
%steps = 50

%T1 = transl(0,-0.3,0.2)                                                  % Create translation matrix
%q1 = r1.model.ikine(T1)                                                        % Derive joint angles for required end-effector transformation
%T2 = transl(0,-0.2667,0.2)                                                   % Define a translation matrix            
%q2 = r1.model.ikine(T2)                                                        % Use inverse kinematics to get the joint angles

%qMatrix = jtraj(q1,q2,steps)

%% Functions








   
   
   
 
   
   
   
   
 
 