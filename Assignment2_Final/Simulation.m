classdef Simulation < handle
    properties
        initialised;
        trajSteps;
        robot;
        environment;
        estop = false;
        
        brickPoseMatrix = [];
        randBrickMatrix = [];
        brickVertices = [];
        brickPlotMatrix = [];
        brickNo = 1;
        
        yellowx = -0.2
        yellowy = 0.25
        yellowz = 0.36;
    end
    
    methods
        function self = Simulation()
            % Construct instance of class, initialise objects
            self.initialised = false
            self.trajSteps = 100;
            
            disp("|===========[Welcome to the Lego Sorting System]===========|");
            fprintf("\n");
            disp("Press 1. Initialise Properties then 2.Initialise Simulation");
            disp("to simulate the environment");
            fprintf("\n\n");
        end
        
        function getBrickNo(self)
            fprintf("Number of bricks selected: %d\n\n", self.brickNo);
            
            X = 0.08:0.01:0.3;
            Y = -0.3:0.02:0.3;
            
            for i=1:self.brickNo
                brickPose = [X(randi([1,numel(X)])) Y(randi([1,numel(Y)])) 0.225];
                self.brickPoseMatrix = [self.brickPoseMatrix;brickPose];
                randBrick = randi([1,4]);
                self.randBrickMatrix = [self.randBrickMatrix;randBrick];
            end
        end
        
        function spawnBricks(self)
            %brick1 = blue, brick2 = green, brick3 = yellow, brick4 = red
            % 2628 vertices
            % 2628, 5256, 7884, 10512, 13140, 15768, 18396, 21024, 23652
            
            a = 1;
            hold on
            for i=1:self.brickNo
                % disp(size(self.brickVertices));
                brickPlot = PlaceObject(['brick',num2str(self.randBrickMatrix(a,:)),'.ply'],self.brickPoseMatrix(a,:));
                
                self.brickPlotMatrix = [self.brickPlotMatrix;brickPlot];
               
                self.brickVertices = [self.brickVertices;get(brickPlot,'Vertices')];
                % disp(size(self.brick_vertices);
                a = a+1;
            end
        end
        
        function estopPress(self)
            if self.estop
            self.estop = false;
            end
            disp(self.estop);
        end
        
        function init(self)
            self.initialised = true;
            
            hold on;
            disp("Initialising System...");
            
            self.robot = DobotSpawn();
            self.robot.PlotAndColourRobot();
            
            disp("Dobot Magician spawned...");
            
            self.environment = Environment();
            
            self.spawnBricks();
            
            disp("Environment created...");
            
            qMove = [pi/4 pi/4 pi/4 pi/4 pi/4];
            
            self.robot.moveJoints(qMove);
            
            disp("System Initialised");
        end
        
        function moveBricks(self)
            while ~self.estop
                if self.estop
                    return
                end
                a = 0;
                a = a+1
                for i=1:self.brickNo
                    disp(self.estop);
                    if self.estop
                        return
                    end
                    fprintf('Moving brick %d.(\n', a);
                    x = self.brickPoseMatrix(a,1);
                    y = self.brickPoseMatrix(a,2);
                    z = self.brickPoseMatrix(a,3);

                    self.robot.moveEndEffector(x,y,z);
                    self.detectBrick(self.randBrickMatrix(a,:));
                    a = a+1;
                end

                %self.robot.moveEndEffector(0.4,0,0.4);
                %disp('Legos sorted');
            end
        end
        
        function detectBrick(self,numBrick)
            %brick1 = blue, brick2 = green, brick3 = yellow, brick4 = red
            if (numBrick == 3)
                self.robot.moveEndEffector(self.yellowx,self.yellowy,self.yellowz);
            elseif (numBrick == 1)
                self.robot.moveEndEffector(self.yellowx,(self.yellowy-0.24),self.yellowz);
            elseif (numBrick == 4)
                self.robot.moveEndEffector(self.yellowx,(self.yellowy-0.26),self.yellowz);
            elseif (numBrick == 2)
                self.robot.moveEndEffector(self.yellowx,(self.yellowy-0.5),self.yellowz);
            else
                self.robot.moveEndEffector(0.4,0,0.4);
            end
        end
        
        function addController(self, id)
            try
                self.gameController = GameController(id)
            catch
                disp("Can't find controller");
            end
        end
        
        function eePose = setMATLABRobotQ(self,q)
            eePose = self.robot.moveJoints(q);
        end
            
    end
end