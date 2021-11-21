%Read different images as input
clc
clear all
cover_Image=imread('bb.jpg');              
cover_Image=imresize(cover_Image, [512 512]);
if ( size ( cover_Image,3 ) ~= 1)
    img=rgb2gray(cover_Image);
end

%CONTRAST ENHANCEMENT
clc;
close all;
pic=imread('bb.jpg'); 
x=rgb2ntsc(pic);
x(:,:,1)=histeq(x(:,:,1));
c2=ntsc2rgb(x);
rimg=histeq(pic(:,:,1));
gimg=histeq(pic(:,:,2));
bimg=histeq(pic(:,:,3));
pic=cat(3,rimg,gimg,bimg);

%LSB ALGORITHM(EMBEDDING)
M='secret.txt';
secret=fopen(M,'rb');  
[M,L]=fread(secret,'ubit1');
[n,m]=size(pic);
m=m/3;
if (m*n*3<L)
    msg=msgbox('your pic is too small','size error','error','model');
    pause(1);
    if (ishandle(msg))
        close(msg);
    end
end
lsb_data=pic;
count=1;
 
for i=1:m
    for j=1:n
        for k=1:3
            lsb_data(i,j,k)=pic(i,j,k)-mod(pic(i,j,k),2)+M(count,1);
            if count==L
                break;
            end
            count=(count+1);
        end
        if count==L
            break;
        end
    end
    if(L==count)
        break;
    end
end

imwrite(lsb_data,'encrypted_Image.jpg','bmp');
CC=M;
count1=1;
for i=1:m
    for j=1:n
        for k=1:3
            CC(count1)=lsb_data(i,j,k)-pic(i,j,k);
            if count1==L
                break;
            end
            count1=count1+1;
        end
        if count1==L
            break;
        end
    end
    if count1==L
        break;
    end
end
h=msgbox('SUCCESSFULLY ENCRYPTED');

%read embedded image
ig2=imread('encrypted_Image.jpg');
if ( size (ig2,3 ) ~= 1)
    ig2=rgb2gray(ig2);
end


%Displaying the Images
figure,
subplot(1,2,1);
imshow(cover_Image);
title('Original Image');
subplot(1,2,2);
imshow(pic);
title('Embedded Image');

%Displaying the Histograms
figure,
subplot(2,1,1);
imhist(img);
title('Histogram of Original Image');
subplot(2,1,2);
imhist(ig2);
title('Histgram of Embedded Image');