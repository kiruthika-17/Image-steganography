hid_pic=imread('encrypted_Image.jpg');

%LSB ALGORITHM(EXTRACTION)
[n1,m1]=size(hid_pic);
m1=m1/3;
ct=1;temp=M;
for i=1:m1
    for j=1:n1
        for k=1:3
            temp(ct,1)=temp(ct,1)+mod(hid_pic(i,j,k),2);
            if temp(ct,1)==2
                temp(ct,1)=1;
            end
            if ct==L
                break;
            end
            ct=ct+1;
        end
        if ct==L
            break;
        end
    end
    if ct==L
        break;
    end
end
c=0; j=0;
fileID=fopen('output.txt','w');
for i=1:L
    c=c+temp(i,1)*(2^j);
    j=j+1;
    if j==8
        j=0;
        fwrite(fileID,c,'char');
        c=0;
    end
end
fclose(fileID);
h=msgbox('SUCCESSFULLY DECRYPTED');

img=imread('bb.jpg');
hid_pic=imread('encrypted_Image.jpg');

%Displaying the Images
figure,
subplot(1,2,1);
imshow(hid_pic);
title('Stego Image');
subplot(1,2,2);
imshow(img);
title('Original Image');


if ( size ( img,3 ) ~= 1)
    img=rgb2gray(img);
end
if ( size (hid_pic,3 ) ~= 1)
    img2=rgb2gray(hid_pic);
end

%Displaying the Histograms
figure,
subplot(2,1,1);
imhist(img2);
title('Histogram of Embedded Image');
subplot(2,1,2);
imhist(img);
title('Histgram of Original Image');

