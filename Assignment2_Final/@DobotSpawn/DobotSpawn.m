classdef DobotSpawn < handle
    properties
        model;
        workspace = [-1 1 -1 1 -1 1];
        name = 'Dobot';
        qNeutral = [0,deg2rad(45),deg2rad(90),deg2rad(45),0];
        qSimulation = [0,deg2rad(45),deg2rad(90),deg2rad(45)];
    end
    methods
        %%
        function self = DobotSpawn()
            location = transl(0, 0, 0.2);
            SpawnDobot(self,location);
        end
        %%
        % joint limits differ with different documentation
        function SpawnDobot(self,location)
            pause(0.001);
            name = [self.name];
            L1 = Link('d',0.137,'a',0,'alpha',-pi/2,'offset',0,'qlim',[deg2rad(-135),deg2rad(135)]);
            L2 = Link('d',0,'a',0.1393,'alpha',0,'offset',-pi/2,'qlim',[deg2rad(0),deg2rad(85)]);
            L3 = Link('d',0,'a',0.16193,'alpha',0,'offset',0,'qlim',[deg2rad(-10),deg2rad(95)]);
            L4 = Link('d',0,'a',0.0597,'alpha',pi/2,'offset',-pi/2,'qlim',[deg2rad(-90),deg2rad(90)]);
            L5 = Link('d',0,'a',0,'alpha',0,'offset',0,'qlim',[deg2rad(-85),deg2rad(85)]);
            self.model = SerialLink([L1 L2 L3 L4 L5], 'name', self.name);
            
            self.model.base = location;
        end

        function PlotAndColourRobot(self)%robot,workspace)
            for linkIndex = 0:self.model.n
                [ faceData, vertexData, plyData{linkIndex + 1} ] = plyread(['dobotLink',num2str(linkIndex),'.ply'],'tri');
                self.model.faces{linkIndex+1} = faceData;
                self.model.points{linkIndex+1} = vertexData;
            end

            % Display robot
            self.model.plot3d(self.qNeutral,'noarrow','workspace',self.workspace);
            if isempty(findobj(get(gca,'Children'),'Type','Light'))
                camlight
            end  
            self.model.delay = 0;

            % Try to correctly colour the arm (if colours are in ply file data)
            for linkIndex = 0:self.model.n
                handles = findobj('Tag', self.model.name);
                h = get(handles,'UserData');
                try 
                    h.link(linkIndex+1).Children.FaceVertexCData = [plyData{linkIndex+1}.vertex.red ...
                                                                  , plyData{linkIndex+1}.vertex.green ...
                                                                  , plyData{linkIndex+1}.vertex.blue]/255;
                    h.link(linkIndex+1).Children.FaceColor = 'interp';
                catch ME_1
                    disp(ME_1);
                    continue;
                end
            end
        end 


    end
end