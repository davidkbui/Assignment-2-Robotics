

[f,v,data] = plyread('Room89.ply','tri');
vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

% Plot the environment at origin
environment = trisurf(f,v(:,1),v(:,2), v(:,3) ...
    ,'FaceVertexCData',vertexColours,'EdgeColor','interp','EdgeLighting','flat');
axis([-3 3 -3 3 0 3]);
axis equal 


   
%% spawn random NUMBER bricks, 1 - 10
    c = 1;
    d = 10;
    p = (d-c).*rand(1,1)+c;
    
for count = 1:p
    bricks();
end

    
function [] = bricks()
    a = 3;
    b = -3;
    
    x = (b-a).*rand(1,1)+a;
    z = (b-a).*rand(1,1)+a; %no y value because bricks are on the ground
PlaceObject(['Brick',num2str(randi([1,28])),'.ply'],[x 0 z]);
end 
