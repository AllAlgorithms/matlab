disp('reading 64X64 image named image.jpeg from curent directory(must be present)')
img=imread("image.jpeg");
scale=input('enter scale ratio :');
method=input('choose method of interpolating 1)nearest neighbour 2)Bilinear');
if method == 1
    imshowpair(img,RESIZE_NNI(img,scale),'montage');
elseif method == 2
    imshowpair(img,RESIZE_NNI(img,scale),'montage');
else
    disp('enter 1 or 2 only')
end

%Nearest Neighbour Interpolation
function newimg=RESIZE_NNI(image,scale)
    newimg=repmat(uint8(0),size(image,1)*scale,size(image,2)*scale,3);
    for i=0:size(newimg,1)-1
      for j=0:size(newimg,2)-1
          i1=(i-mod(i,scale))/scale;
            j1=(j-mod(j,scale))/scale;
            newimg(i+1,j+1,:)=image(i1+1,j1+1,:);
        end
    end
end

%BiLinear Interpolation
function newimg=RESIZE_BLI(image,scale)
    newimg=repmat(uint8(0),(size(image,1)-1)*scale,(size(image,2)-1)*scale,3);
    for i=1:size(newimg,1)
      for j=1:size(newimg,2)
          I=floor((i-1)/scale)+1;
          J=floor((j-1)/scale)+1;
          p1=image(I,J,:);
          p2=image(I,J+1,:);
          p3=image(I+1,J,:);
          p4=image(I+1,J+1,:);
          rx=i/scale-I+1;
          ry=j/scale-J+1;
          newimg(i,j,:)=ry*(rx*(p4)+(1-rx)*(p2))+(1-ry)*(rx*(p3)+(1-rx)*(p1));
      end
    end
end