dobot = DobotSpawn();
dobot.PlotAndColourRobot();

q = zeros(1,5)

dobot.moveJoints(pi/4,pi/4,pi/4,pi/4,pi/4)

dobot.spawnPointCloud()

dobot.moveEndEffector(-1,-1,-1);