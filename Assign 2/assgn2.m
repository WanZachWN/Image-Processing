
clc;
close all;
clear all;
 
%read image 
image=imread('Fig0338(a)(blurry_moon).tif');
 
[m,n]=size(image);
output=zeros(m,n);


%mean filtering
for i=1:m
    for j=1:n
      %set the neighrborhood boundary 
      rmin=max(1,i-1);
      rmax=min(m,i+1);
      cmin=max(1,j-1);
      cmax=min(n,j+1);
      
      %now the neighborhood matrix, denoting it by temp
      temp=image(rmin:rmax,cmin:cmax);
      
      %the pixel of the output will be the average of this neighborhood
      output(i,j)=mean(temp(:));
      
    end
end
 % convert output to uint8
 output= uint8(output);
 
 figure(1);
 subplot(121),imshow(image),title('original image');
 subplot(122),imshow(output),title('output of mean filtering');


%Guassing filtering
 
sigma=1; % standard derivation of the distribution 
 
% 5x5 kernel
kernel=zeros(5,5);
%sum of elements of kernel(for normalization)
w=0;
for i=1:5
    for j=1:5
    sq_dist=(i-3)^2+(j-3)^2;
    kernel(i,j)=exp(-1*(sq_dist)/(2*sigma*sigma));
    w= w+kernel(i,j);
    end
end
kernel= kernel/w;
%apply the filter to image
[m,n]=size(image);
output=zeros(m,n);
Im=padarray(image,[2 2]);
for i=1:m
    for j=1:n
      temp=Im(i:i+4, j:j+4);
      temp= double(temp);
      conv= temp*kernel;
      output(i,j)=sum(conv(:));
    end
end
 
figure(2);
subplot(121),imshow(image),title('original image');
subplot(122),imshow(output),title('output of gaussian filter');
%median filtering
[m,n]=size(image);
output1=zeros(m,n);
 
for i=1:m
    for j=1:n
      %set the neighrborhood boundary 
      xmin=max(1,i-1);
      xmax=min(m,i+1);
      ymin=max(1,j-1);
      ymax=min(n,j+1);
      
      %now the neighborhood matrix, denoting it by temp
      temp=image(xmin:xmax,ymin:ymax);
      
      %the pixel of the output will be the average of this neighborhood
      output1(i,j)=median(temp(:));
      
    end
end
 figure(3);
 subplot(121),imshow(image),title('original image');
 subplot(122),imshow(output1),title('output of median filter');
 
%Image sharpening 
 
image=double(image);
% rows/ columns of image
M=size(image,1);
N=size(image,2);
%rows/columns of kernel
C=5; D=5;
 
%rows/columns after padding
P=M+C-1; Q=N+D-1;
%after padding, start with zero
fp=zeros(P,Q);
%insert image into image fp
fp(1:M,1:N)=image;
%construct filter matrix hp
hp=zeros(P,Q);
hp(1,1)=-4;hp(2,1)=1;hp(1,2)=1;
hp(P,1)=1;
hp(1,Q)=1;
 
%FFT of image and kernel
Fp=fft2(double(fp),P,Q);
Hp=fft2(double(hp),P,Q);
%swaps the left and right halves of Hp
H=fftshift(Hp);
%get the magnitude
F1=abs(H);
%use log
F1=log(F1+1);
%convert the matrix F1
F1=mat2gray(F1,[0 1]);
imshow(F1);
 
Gp=Fp .*Hp;%product of FFTs
gp=ifft2(Gp);%Inverse FFT
gp=real(gp);% take real part
g=gp(1:M, 1:N);
 
 figure(4);
 subplot(121),imshow(image),title('original image');
 subplot(122),imshow(g),title('output of image shapening');
 
 
%build a guassian pyramid

clc;
close all;
clear all;
 
%read image 
image=imread('Lenna_(test_image).png');
I=rgb2gray(image);
 
sigma=1; % standard derivation of the distribution 
 
I=imnoise(I,'Gaussian',0.04,0.003);
 
% 5x5 kernel
kernel=zeros(5,5);
%sum of elements of kernel(for normalization)
w=0;
for i=1:5
    for j=1:5
    sq_dist=(i-3)^2 + (j-3)^2;
    kernel(i,j)=exp(-1*(sq_dist)/(2*sigma*sigma));
    w= w+kernel(i,j);
    end
end
kernel= kernel/w;
 
%apply the filter to image
[m,n]=size(I);
output=zeros(m,n);
Im= padarray(I,[2 2]);
for i=1:m
    for j=1:n
      temp=Im(i:i+4, j:j+4);
      temp= double(temp);
      conv= temp.*kernel;
      output(i,j)=sum(conv(:));
    end
end
output= uint8(output);
 
        imag=output(1:2:m,1:2:n);
   

figure，imshow(I);
figure，imshow(imag);
 
imagg1=imagg(1:2:m/2,1:2:n/2);
    figure,imshow(imagg1); 
    
     imagg2=imagg1(1:2:m/4,1:2:n/4);
    figure,imshow(imagg2); 
    
     imagg3=imagg2(1:2:m/8,1:2:n/8);
    figure,imshow(imagg3); 
    
     imagg4=imagg3(1:2:m/16,1:2:n/16);
    figure,imshow(imagg4); 
    
     imagg5=imagg4(1:2:m/32,1:2:n/32);
    figure,imshow(imagg5); 
 


