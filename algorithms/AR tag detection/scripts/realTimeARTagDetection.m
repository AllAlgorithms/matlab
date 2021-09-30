clear;clc;
N = 7; 

cam = webcam;
vp = vision.VideoPlayer;
vp1 = vision.VideoPlayer;
vp2 = vision.VideoPlayer;
vp3 = vision.VideoPlayer;
k = 0 ;
while 1
    Ir = snapshot(cam);
    I1 = rgb2gray(Ir);
    T_Gaus= imgaussfilt(I1);
    I = imbinarize(T_Gaus,0.6);

    % edge detection
    BW = edge(I,'Sobel');     
    se1 = strel('disk', 5);
    se2 = strel('disk', 4);
    BW = imdilate(BW,se1);
    BW = imerode(BW,se2);
    F = imfill(BW,'holes');   % fill the image 

    %Fill a gap 
    se = strel('disk',2);
    F = imclose(F,se);
    F = bwareaopen(F, 5000);

    %% boundries 

    B1 = bwboundaries(F, 8, 'noholes');           % Boundary detection
    B_size = size(B1);

    D = zeros(N,N,B_size(1,1));                   % ar tag data
    ID  = zeros(B_size(1,1));                     % tag id 
%     figure;
%     subplot(double(int16((B_size(1,1)/2)+0.9)),2,1);
%     imshow(Ir);

    %%

    for k = 1:B_size(1,1)
        BB = B1{k};
        ps = dpsimplify(BB,50);                       %Douglas-Peucker Algorithm

        ps_size = size(ps);
        final_corners = zeros(4,2);

        if(ps_size(1)>=5 && ps_size(1)<=5)                           %If it is a polygon with 4 corners, then detect as quad
            for k1=1:ps_size(1)-1
                for kk=1:2 
                    final_corners(k1,kk) = ps(k1,kk); %Only four corners
                end
            end
            
            %%
%             BB_size = size(BB);
%             for i = 1:BB_size(1)
%                 Ir(BB(i,1),BB(i,2)-1,:) = [0 255 0];
%                 Ir(BB(i,1)-1,BB(i,2),:) = [0 255 0];
%                 Ir(BB(i,1),BB(i,2),:) = [0 255 0];
%                 Ir(BB(i,1)+1,BB(i,2),:) = [0 255 0];
%                 Ir(BB(i,1),BB(i,2)+1,:) = [0 255 0];
%             end
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
%            subplot(double(int32((B_size(1,1)/2)+.9)),2,k+1);
%            imshow(img);
%            title("decoded part ");
%             img_s = size(img);
%             Ir_s = size(Ir);
%             Ir(Ir_s(1)-img_s(1):)
%             text = ID()
%             Ir = insertImage(Ir,[(fc(1,2)+fc(2,2)+fc(3,2)+fc(4,2))/4 (fc(1,1)+fc(2,1)+fc(3,1)+fc(4,1))/4],)
            step(vp2,img);
            mat = D(:,:,k);
            mat = imresize(mat2gray(mat),[420 420],'nearest');
            step(vp3,mat);
        end
    end
    step(vp1,F);
    step(vp,Ir);
    k = k +1;
end
clear('cam');
release(vp);
release(vp1);
release(vp2);
release(vp3);