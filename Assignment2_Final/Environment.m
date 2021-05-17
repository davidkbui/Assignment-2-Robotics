classdef Environment < handle
    properties
        
    end
    methods
        function self = Environment()
            addpath('Environment_assets');
            addpath('Environment_assets/New_bricks');
            
            axisL = 3;

            axis([-axisL axisL -axisL axisL 0 axisL]);

            hold on

            % Walls and Floor
            surf([-axisL,-axisL;axisL,axisL],[-axisL,axisL;-axisL,axisL],[0.01,0.01;0.01,0.01],'CData',imread('Rug.jpeg'),'FaceColor','texturemap'); % Concrete floor
            surf([-axisL,axisL;-axisL,axisL],[axisL,axisL;axisL,axisL],[0,0;axisL,axisL],'CData',imread('window.jpeg'),'FaceColor','texturemap'); % Concrete floor
            surf([axisL,axisL;axisL,axisL],[-axisL,axisL;-axisL,axisL],[0,0;axisL,axisL],'CData',imread('office_wall_1.jpeg'),'FaceColor','texturemap'); % Concrete floor
            
            PlaceObject('fence1.ply',[-2 0 0]);
            PlaceObject('fence1.ply',[2 0 0]);
            PlaceObject('fence2.ply',[0 1.2 0]);
            PlaceObject('fence2.ply',[0 -1.2 0]);

            hold on
            PlaceObject('table.ply',[0.25,0,0]);

            %PlaceObject('container_red.ply',[1.15,0.15,0.225]);
            %PlaceObject('container_blue.ply',[1.15,-0.15,0.225]);
            %PlaceObject('container_green.ply',[1.15,0.3,0.225]);
            %PlaceObject('container_yellow.ply',[1.15,-0.3,0.225]);
            
            PlaceObject('firstaid.ply',[2.5,2.5,0]);
            PlaceObject('DANGER.ply',[-1.9 1.2 1]);
            PlaceObject('DANGER.ply',[1.3 1.2 1]);
            
            PlaceObject('teddy.ply', [0.9, 0.3,0.28]);
            %indexed out because these ply files are too huge
            % PlaceObject('car_blue.ply',[-0.9, 0.3, 0.28]); 
            % PlaceObject('car_pink.ply',[-0.8, 0.3, 0.28]);\
        end
    end
end
