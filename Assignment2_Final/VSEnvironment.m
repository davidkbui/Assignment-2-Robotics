%% Visual Servoing Test Environment
% This is a test environment for the simulated visual servoing in MATLAB.
% Ideally this would be combined with the other webcam visual servoing

classdef VSEnvironment < handle
    properties
        
    end
    
    methods
        function self = VSEnvironment()
            addpath('Environment_assets');
            addpath('Environment_assets/New_bricks');
            workspaceSize = 3;
            axis([-workspaceSize, workspaceSize, -workspaceSize, workspaceSize, 0, workspaceSize]);
            surf([-workspaceSize,-workspaceSize;workspaceSize,workspaceSize],[-workspaceSize,workspaceSize;-workspaceSize,workspaceSize],[0.01,0.01;0.01,0.01],'CData',imread('Rug.jpeg'),'FaceColor','texturemap'); % Concrete floor
            surf([-workspaceSize,workspaceSize;-workspaceSize,workspaceSize],[workspaceSize,workspaceSize;workspaceSize,workspaceSize],[0,0;workspaceSize,workspaceSize],'CData',imread('window.jpeg'),'FaceColor','texturemap'); % Concrete floor
            surf([workspaceSize,workspaceSize;workspaceSize,workspaceSize],[-workspaceSize,workspaceSize;-workspaceSize,workspaceSize],[0,0;workspaceSize,workspaceSize],'CData',imread('office_wall_1.jpeg'),'FaceColor','texturemap'); % Concrete floor
            PlaceObject('table.ply',[0.25,0,0]);
            placeObject('2x2_yellow.ply',[0,0,0.2]);
        end
    end
end