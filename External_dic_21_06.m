originalimage = im2double(imread('Child_original.png' ));
originalimage=imresize(originalimage, [128 128]);
ChannelNumber = size(originalimage , 3);
if ChannelNumber == 3
    img_yiq = RGB2YIQ(originalimage);
    img_y = img_yiq(:,:,1);
    IQLayer = img_yiq(:,:,2:3);
elseif ChannelNumber == 1
    img_y = originalimage;
    IQLayer = [];
end;
k=1;
for i =0.1:0.11:1
   
h = fspecial('Gaussian',[5 5],i);
input_image=imfilter(img_y,h,'same');
subplot(2,5,k)
k=k+1;
imshow(input_image);
title(['Blured image ' num2str(i) '--' num2str(PSNR(img_y,input_image))]);
end
