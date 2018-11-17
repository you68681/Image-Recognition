clear all;
clc;
img0=imread('p1.jpg');
[row col depth]=size(img0);
if depth>0
    img1 = rgb2gray(img0);
end
% figure(1)
% imshow(img1)


img1=medfilt2(img1);
% figure(2)
% imshow(img1)

img2 = imgradient(img1,'Roberts');
% img2 = imgradient(img1);

tou=max(max(img2))*0.1;
img3=zeros(row, col);
for i=1:row
    for j=1:col
        if img2(i,j)>=tou
            img3(i,j)=1;
        end
    end
end
% figure(3)
% imshow(img3)
img4=img3;

img4=bwareaopen(img4,fix(row*col*0.003));

img5 = bwlabel(img4);
img6=zeros(row, col);
rr=regionprops(img5,'Centroid');
aa=regionprops(img5,'Area');
for i=1:max(max(img5))
    cc=rr(i).Centroid;
    dd=aa(i).Area/(cc(1)*cc(2));
if  dd<0.15 %& dd>0.05
    pp=find(img5==i);
    img6(pp)=1;
end
end


se=strel('square',6); 
img7=imclose(img6,se);

% 
figure(4)
imshow(img7)
