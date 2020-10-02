function GaussianHighpass
a=imread('cameraman.tif');
figure,imshow(a),title('Original');
[m,n]=size(a);
f_transform=fft2(a);
f_shift=fftshift(f_transform);
p=m/2;
q=n/2;
d0=50;
low_filter=zeros(m,n);
for i=1:m
    for j=1:n
        distance=sqrt((i-p)^2+(j-q)^2);
        low_filter(i,j)=1-exp(-(distance)^2/(2*(d0^2)));
    end
end
figure,imshow(low_filter),title('Filter Applied');
filter_apply=f_shift.*low_filter;
image_orignal=ifftshift(filter_apply);
image_filter_apply=abs(ifft2(image_orignal));
figure,imshow(image_filter_apply,[]),title('Sharpned Image');
