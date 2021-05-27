camList = webcamlist; % Create a list of all the webcams
cam = webcam(1); % Chooses the first webcam
preview(cam); % Opens webcamfeed
pause(5);
im = snapshot(cam); % Takes snapshot of current frame
imwrite(im, 'bricktest.jpg'); % Writes to jpg file
pause(5);
img = iread('bricktest.jpg', 'double', 'gamma', 4); % Read the image and adjust the gamma for correct filter
image(img);
R = img(:,:,1); % Maxtrix of assigning rgb numerical values
G = img(:,:,2);
B = img(:,:,3);
Y = R + G + B; 
r = R ./ Y;
g = G ./ Y;
b = B ./ Y;
Rbrick = (r > 0.95) & (g < 0.05) & (b < 0.05); % Defining the bounds at which the colours will show up as either 1 or 0
Bbrick = (b > 0.8) & (r < 0.2);
Cr = corner(Rbrick); % Taking verticies from the filtered images
Cb = corner(Bbrick);
figure() % Plot figures of each of the colour masks and then actual image with overlay
imshow(Rbrick);
hold on
plot(Cr(:,1),Cr(:,2),'r*')
figure()
imshow(Bbrick);
hold on
plot(Cb(:,1),Cb(:,2),'b*')
figure()
imshow('bricktest.jpg')
hold on
plot(Cr(:,1),Cr(:,2),'r*')
plot(Cb(:,1),Cb(:,2),'b*')



clear cam
