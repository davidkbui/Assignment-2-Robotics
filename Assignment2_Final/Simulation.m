classdef Simulation < handle
    properties
        initialised;
        trajSteps;
        robot;
        environment;
        
        brickNo = 0;
    end
    
    methods
        function self = Simulation()
            % Construct instance of class, initialise objects
            self.initialised = false
            self.trajSteps = 100;
            

            disp("Simulation");
        end
        
        function getBrickNo(self)
            disp(self.brickNo);
        end
        
        function init(self)
            self.initialised = true;
            
            hold on;
            disp("Initialising System...");
            
            self.robot = DobotSpawn();
            self.robot.PlotAndColourRobot();
            
            self.robot.moveBase(-1,0,0,180); % input (x,y,z,trotz(deg))
            
            self.environment = Environment();
            
            qMove = [pi/4 pi/4 pi/4 pi/4 pi/4];
            
            self.robot.moveJoints(qMove);
            disp("System Initialised");
            

        end
        
        function eStop(self)
            self.initialised = false;
            disp("E-stop pressed, press to continue");
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