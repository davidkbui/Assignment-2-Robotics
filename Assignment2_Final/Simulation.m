classdef Simulation < handle
    properties
        initialised;
        trajSteps;
    end
    
    methods
        function self = Simulation()
            self.initialised = false
            self.trajSteps = 100;
        end
        
        function init(self)
            self.initialised = true;
            disp("Initialising System");
        end 
    end
end