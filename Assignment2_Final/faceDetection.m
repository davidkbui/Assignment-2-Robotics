function [] = faceDetection()

close all
clf

obj = imaq.VideoDevice('winvideo',1,'MJPG_640x480');
counter = 0;
videoplayer = vision.VideoPlayer; 
tic;

while(counter < 20000)
    counter=counter+1;
    frame = step(obj);        
    detection = vision.CascadeObjectDetector();
    bboxes = step(detection, frame);
    if ~isempty(bboxes)
        frame = insertObjectAnnotation(frame, 'rectangle', bboxes, 'FACE DETECTED','TextBoxOpacity', 0.4, 'FontSize', 14);
        pause(5);
%         eStop = true;
%         This would be where the eStop button would theoretically pressed
%         shutting off the system 
    end
 
    step(videoplayer, frame);               
    looptime(counter)=toc; 

    while(looptime(counter)<0.15) 
        looptime(counter)=toc;
    end  
    tic;
end

clear obj;
release(videoplayer);
disp('done')

