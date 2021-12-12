% how to read a image
image=imread('Fig0338(a)(blurry_moon).tif');
 
%to get size of image
a = size(image);
length = a(1);
width = a(2);
 
%how to display a image
 
imshow(image);
 
%Build  histogram for grayscale image
 
A=zeros(1,256);
for i=1:length
  for j=1:width
    for m=1:256
        if image(i,j)==m
            A(m)=A(m)+1;
        end    
    end 
 end
end
figure(1)
plot(A);
 
%build cumulative histogram
 
B=zeros(1,256);
B(1)=A(1);
for m1=2:256
   B(m1)=A(m1)+B(m1-1); 
end
figure(2)
plot(B);
 
% histogram equalization
 
s=zeros(1,256);
pr=B/(length*width);
for k=1:256   
s(k)=round(255*pr(k));
end
 
% Assign new values for each gray value in the image
 
for m=1:length
    for n=1:width
     new_imagee(m,n)=s(image(m,n)+1);   
     
    end
end 
figure(3)
imshow(new_imagee,[]); 


