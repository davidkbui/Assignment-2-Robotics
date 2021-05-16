classdef DobotSpawn < handle
    properties
        model;
        workspace = [3 3 -3 3 0 3];
        name = 'Dobot';
        eStop = false;
        q = zeros(1,5);
        qSimulation = [0,deg2rad(45),deg2rad(90),deg2rad(45),0];
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
            self.eStop = false;
            pause(0.001);
            name = [self.name];
            L1 = Link('d',0.137,'a',0,'alpha',-pi/2,'offset',0,'qlim',[deg2rad(-135),deg2rad(135)]);
            L2 = Link('d',0,'a',0.1393,'alpha',0,'offset',-pi/2,'qlim',[deg2rad(0),deg2rad(85)]);
            L3 = Link('d',0,'a',0.16193,'alpha',0,'offset',0,'qlim',[deg2rad(-10),deg2rad(95)]);
            L4 = Link('d',0,'a',0.0597,'alpha',pi/2,'offset',-pi/2,'qlim',[deg2rad(0),deg2rad(90)]);
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
            self.model.plot3d(self.qSimulation,'noarrow','workspace',self.workspace);
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
        %% Dobot move joints
        %% E-Stop
        function StopCheck(self)
            while(self.eStop == true)
                disp('E-stop pressed');
                pause(0.05);
            end;
        end
        
        function moveJoints(self, qMove)
            if(self.eStop == false)
                self.model.fkine(qMove);
                
                self.model.animate(qMove);
                drawnow();
            end
        end
        
        function moveEndEffector(self,x,y,z)
            steps = 100;
                    
            startEndEffector = self.model.getpos();
                   
            endTransl = transl(x,y,z);
                    
            robotTraj = jtraj(startEndEffector,self.model.ikcon(endTransl,self.qSimulation),steps);
            
            disp(self.model.ikcon(endTransl,self.qSimulation))
            
            endEffectorPos = self.model.fkine(self.model.getpos);
                    
            % disp('moving robot, press to continue');
            % pause;
                    
            for i = 1:steps
                animate(self.model,robotTraj(i,:));
                drawnow();
            end
            
            disp('done');
            % self.getEndEffectorPos();
        end
        
        function moveBase(self,x,y,z,rot)
            self.model.base = self.model.base * trotz(deg2rad(rot)) * transl([x y z]);
        end
        
        function getEndEffectorPos(self)
            endEffectorPos = self.model.fkine(self.model.getpos);
            disp(endEffectorPos);
        end
        
        function spawnPointCloud(self)
            stepRads = deg2rad(60);         % Decrease angle to ge more accurate results
                qlim = self.model.qlim;
                pointCloudSize = prod(floor((qlim(1:5,2)-qlim(1:5,1))/stepRads + 1));
                pointCloud = zeros(pointCloudSize,3);
                
                counter = 1;
                tic

                for q1 = qlim(1,1):stepRads:qlim(1,2)
                    for q2 = qlim(2,1):stepRads:qlim(2,2)
                        for q3 = qlim(3,1):stepRads:qlim(3,2)
                            for q4 = qlim(4,1):stepRads:qlim(4,2)
                                for q5 = 0
                                    % Don't need to worry about joint 6, just assume it=0
                                        qFinal = [q1,q2,q3,q4,q5];
                                        tr = self.model.fkine(qFinal);                        
                                        pointCloud(counter,:) = tr(1:3,4)';
                                        counter = counter + 1; 
                                        if mod(counter/pointCloudSize * 100,1) == 0
                                            disp(['After ',num2str(toc),' seconds, completed ',num2str(counter/pointCloudSize * 100),'% of poses']);
                                        end
                                end
                            end
                        end
                    end
                end

                % To only plot UR3 values ABOVE the table (z = 0.904)
                %for i = 1:pointCloudSize
                %    if  pointCloud(i,3) < 0.904
                %        pointCloud(i,3) = 0.904;
                %    end 
                %end
                
                disp('plotting point cloud');
                plot3(pointCloud(:,1),pointCloud(:,2),pointCloud(:,3),'r.');
        end

    end
end
