img = imread('Fig0338(a)(blurry_moon).tif');
figure,imhist(img);

[row,col,~] = size(img);

%image histogram
hist = zeros(1,256);
for i = 1:row
    for j = 1:col
        hist(img(i,j)+1) = hist(img(i,j)+1)+1;
    end
end

% cumulative histogram
cum_hist = zeros(1,256);
for k = 2:256
    cum_hist(k) = hist(k) + cum_hist(k-1);
end

%histogram equalization
hist_eq = zeros(1,256);
pr = cum_hist/(row*col);
for h = 1:256
    hist_eq(h) = round(255*pr(h));
end

%make new image
new_img = zeros(row, col);
for i = 1:row
    for j = 1:col
        if img(i,j)-1 <= 0
            new_img(i,j) = hist_eq(img(i,j)+1);
        else
            new_img(i,j) = hist_eq(img(i,j)-1);
        end
    end
end

%show and save new image
figure
subplot(2,3,1)
bar(hist);
subplot(2,3,2)
bar(cum_hist);
subplot(2,3,3)
bar(hist_eq);
subplot(2,3,4)
imshow(img);
subplot(2,3,5)
imshow(new_img);
imwrite(new_img, 'output.tif');