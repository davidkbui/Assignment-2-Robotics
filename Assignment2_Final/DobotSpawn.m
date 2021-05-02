classdef DobotSpawn < handle
    properties
        model;
        workspace = [-1 1 -1 1 -1 1];
        name = 'Dobot'
        
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
            L1 = Link('d',0,'a',0.1393,'alpha',0,'offset',-pi/2,'qlim',[deg2rad(0),deg2rad(85)]);
            L1 = Link('d',0,'a',0.16193,'alpha',0,'offset',0,'qlim',[deg2rad(-10),deg2rad(95)]);
            L1 = Link('d',0,'a',0.0597,'alpha',pi/2,'offset',-pi/2,'qlim',[deg2rad(-90),deg2rad(90)]);
            L1 = Link('d',0,'a',0,'alpha',0,'offset',0,'qlim',[deg2rad(-85),deg2rad(85)]);
            self.model = SerialLink([L1 L2 L3 L4 L5], 'name', self.name);
            
            self.model.base = location;
        end
    end
end