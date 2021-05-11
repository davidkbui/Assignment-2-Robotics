addpath('Environment_assets');
addpath('Environment_assets/New_bricks');


% SpawnEnvironment();
%% Environment

axisL = 3

axis([-axisL axisL -axisL axisL 0 axisL]);

hold on

% Walls and Floor
surf([-axisL,-axisL;axisL,axisL],[-axisL,axisL;-axisL,axisL],[0.01,0.01;0.01,0.01],'CData',imread('Rug.jpeg'),'FaceColor','texturemap'); % Concrete floor
surf([-axisL,axisL;-axisL,axisL],[axisL,axisL;axisL,axisL],[0,0;axisL,axisL],'CData',imread('window.jpeg'),'FaceColor','texturemap'); % Concrete floor
surf([axisL,axisL;axisL,axisL],[-axisL,axisL;-axisL,axisL],[0,0;axisL,axisL],'CData',imread('office_wall_1.jpeg'),'FaceColor','texturemap'); % Concrete floor


%%

hold on
PlaceObject('table.ply',[0.75,0,0]);

PlaceObject('container_red.ply',[1.15,0.15,0.225]);
PlaceObject('container_blue.ply',[1.15,-0.15,0.225]);
PlaceObject('container_green.ply',[1.15,0.3,0.225]);
PlaceObject('container_yellow.ply',[1.15,-0.3,0.225]);


%%

hold on

dobot = DobotSpawn();
dobot.PlotAndColourRobot();


dobot.model.base = dobot.model.base * trotz(pi) * transl([-1 0 0]);

dobot.moveJoints(pi/4,pi/4,pi/4,pi/4,pi/4)

dobot.model.teach();



%%


