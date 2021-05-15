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

PlaceObject('fence1.ply',[-2 0 0]);
PlaceObject('fence1.ply',[2 0 0]);
PlaceObject('fence2.ply',[0 1.2 0]);
PlaceObject('fence2.ply',[0 -1.2 0]);

PlaceObject('teddy.ply', [0.8,0,0.28]);
PlaceObject('stop.ply',[0.3, -0.8,0.28]);

PlaceObject('2x4_red.ply',[0.76,0.2,0.225]);
yellowBrick = PlaceObject('2x4_yellow.ply',[0.76,0.3,0.225]);
PlaceObject('2x4_green.ply',[0.9,-0.3,0.225]);

yellow_vertices = get(yellowBrick,'Vertices')

% dobot.model.ikcon(transl([0.9,-0.1,0.265+0.09]),zeros(1,5))

% x offset = 0.6
% y offset = 0.2
% z offset = 1.2

%%

hold on

dobot = DobotSpawn();
dobot.PlotAndColourRobot();


dobot.model.base = dobot.model.base * trotz(pi) * transl([-1 0 0]);

q = [pi/4 pi/4 pi/4 pi/4 pi/4];

dobot.moveJoints(q)

%% Yellow brick

dobot.moveEndEffector(0.9,-0.1,0.34)
dobot.moveEndEffector(0.7,-0.01,0.34)

% dobot.moveEndEffector(0.76-0.1,0.3,0.225+0.12); % Yellow Brick

%dobot.moveEndEffector(1.15,-0.3,0.225+0.12);

% dobot.moveEndEffector(0.76-0.1,0.2-0.05,0.225+0.12);

% dobot.moveEndEffector(1.15,0.15,0.225+0.12);

%dobot.moveEndEffector(0.9-0.04,0.1-0.15,0.225+0.12);

%dobot.moveEndEffector(1.15,0.3,0.225+0.12);




%%


