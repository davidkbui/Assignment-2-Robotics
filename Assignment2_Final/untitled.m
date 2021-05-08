dobot = DobotSpawn();
dobot.PlotAndColourRobot();

q = zeros(1,5)

% dobot.spawnPointCloud()

dobot.moveJoints(pi/4,pi/4,pi/4,pi/4,pi/4)

dobot.model.teach()

% dobot.moveEndEffector(-1,-1,-1);


%% Environment 

PlaceObject('2x2_green.ply',[0,0,0]);