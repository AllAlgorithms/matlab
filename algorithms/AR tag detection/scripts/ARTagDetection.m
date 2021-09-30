clear;
clc;

%% INPUT IMAGE AND EDGES 

N = 7; % no of cubes in a row  in artag 
% cam = webcam;
% Ir = snapshot(cam);
% preview(cam);
% figure, imshow(Ir), title('Input image');
% clear('cam');

Ir = imread('sample1.jpg');
I1 = rgb2gray(Ir);
figure, imshow(Ir);

T_Gaus= imgaussfilt(I1);
I = imbinarize(T_Gaus,0.5);
%figure,imshow(I), title('Binarized image after applying Gaussian filter');

BW = edge(I,'Sobel');    % edge detection 
%figure, imshow(BW), title('Edge detection using sobel method');
se1 = strel('disk', 5);
se2 = strel('disk', 4);
BW = imdilate(BW,se1);
%figure, imshow(BW) , title('After applying dilation filter');
BW = imerode(BW,se2);
%figure, imshow(BW), title('After applying erosion filter');
F = imfill(BW,'holes');   % fill the image 
%figure, imshow(F), title('Filling the gaps in the edges');

%Fill a gap 
se = strel('disk',2);
F = imclose(F,se);
F = bwareaopen(F, 5000);
figure, imshow(F), title('Removing small boundaries');

%% boundries 
B1 = bwboundaries(F, 8, 'noholes'); % Boundary detection
B_size = size(B1);


% figure, imshow(Ir);
% hold on
% for k = 1:B_size(1,1)
% plot(B1{k}(:,2),B1{k}(:,1),'b*')
% end
% hold off

%%

D = zeros(N,N,B_size(1,1));   % ar tag data
ID  = zeros(B_size(1,1));         % tag id 
 
for k = 1:B_size(1,1)
    BB = B1{k};
 ps = dpsimplify(BB,10); %Douglas-Peucker Algorithm
        
        ps_size = size(ps);
        ps_size
        final_corners = zeros(4,2);
        
             if(  ps_size(1) == 5)                                              %If it is a polygon with 4 corners, then detect as quad
            for k1=1:ps_size(1)-1
                for kk=1:2 
                    final_corners(k1,kk) = ps(k1,kk); %Only four corners
                end
            end
            
            fc = final_corners; 
            Ir = insertShape(Ir,'FilledPolygon',[fc(1,2) fc(1,1) fc(2,2) fc(2,1) fc(3,2) fc(3,1) fc(4,2) fc(4,1)],'Color','green','Opacity',0.6);
     
%% HOMOGRAPHY
             %Reference marker points
             
             quad_pts(1,:) = [1, 1];
             quad_pts(2,:) = [600, 1];
             quad_pts(3,:) = [600, 600];
             quad_pts(4,:) = [1, 600];
             
             %Corner points
             final_pts = [final_corners(:,2), final_corners(:,1)];
             
             
             %Estimate homography with the 2 sets of four points
             H = fitgeotrans( final_pts,quad_pts,'projective');
             
             %Warp the marker to image plane
             RA = imref2d([quad_pts(3,1) quad_pts(3,2)], [1 quad_pts(3,1)-1], [1 quad_pts(3,1)-1]);
             [warp,r] = imwarp(I1, H, 'OutputView', RA); 
          
              
              th = graythresh(warp);
              markBin = imbinarize(warp, th);
              se3 = strel('square', 1);
              markBin = imerode(markBin,se3);
              
              % decoding the ar tag 
              [D(:,:,k),ID(k),img] = DECODE_AR_TAG(markBin,N);
              
              figure,imshow(img), title('AR tag after decoding');              
             end
end
figure,imshow(Ir);
