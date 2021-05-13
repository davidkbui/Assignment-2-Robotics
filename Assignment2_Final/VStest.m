camList = webcamlist;
cam = webcam(1);
preview(cam);
pause(5);
im = snapshot(cam);
imwrite(im, 'bricktest.jpg');
pause(5);
img = iread('bricktest.jpg', 'double', 'gamma', 4);
image(img);
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
Y = R + G + B;
r = R ./ Y;
g = G ./ Y;
b = B ./ Y;
Rbrick = (r > 0.95) & (g < 0.05) & (b < 0.05);
Bbrick = (b > 0.8) & (r < 0.2);
Cr = corner(Rbrick);
Cb = corner(Bbrick);
figure()
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
