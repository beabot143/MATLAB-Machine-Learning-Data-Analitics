%*****************************************************************
% ELE725 Lab3: Intra and Inter Frame Coding
% Date: February 14, 2019
%*****************************************************************
clear all
close all
%% Part 1: Intra-Frame coding (DCT)

% (1)
pic = imread('lena_gray.jpg')
dctPic = dct2(pic)

%(2) 
crop4 = pic(250:253,250:253)
crop8 = pic(300:307,300:307)
crop32 = pic(450:481,450:481)

% Perform DCT
dct4 = dct2(crop4)
dct8 = dct2(crop8)
dct32 = dct2(crop32)

% (3) 
idct4 = idct2(dct4)
idct8 = idct2(dct8)
idct32 = idct2(dct32)

figure % Figure 1
subplot(3,3,1)
imshow(crop4)
title('4x4')
subplot(3,3,2)
imshow(crop8)
title('8x8')
subplot(3,3,3)
imshow(crop32)
title('32x32')
subplot(3,3,4)
imshow(log(abs(dct4)))
subplot(3,3,5)
imshow(log(abs(dct8)))
subplot(3,3,6)
imshow(log(abs(dct32)))
subplot(3,3,7)
imshow(idct4,[0 255])
subplot(3,3,8)
imshow(idct8,[0 255])
subplot(3,3,9)
imshow(idct32,[0 255])

% (4)
% zero out DC component
dct4zDC = dct4
dct4zDC(1,1) = 0
dct8zDC = dct8
dct8zDC(1,1) = 0
dct32zDC = dct32
dct32zDC(1,1) = 0

idct4zDC = idct2(dct4zDC)
idct8zDC = idct2(dct8zDC)
idct32zDC = idct2(dct32zDC)

figure % Figure 2
subplot(3,3,1)
imshow(crop4)
title('4x4')
subplot(3,3,2)
imshow(crop8)
title('8x8')
subplot(3,3,3)
imshow(crop32)
title('32x32')
subplot(3,3,4)
imshow(log(abs(dct4zDC)))
subplot(3,3,5)
imshow(log(abs(dct8zDC)))
subplot(3,3,6)
imshow(log(abs(dct32zDC)))
subplot(3,3,7)
imshow(idct4zDC,[0 255])
subplot(3,3,8)
imshow(idct8zDC,[0 255])
subplot(3,3,9)
imshow(idct32zDC,[0 255])

% Zero out low frequency components
ind4 = zigzag(dct4)
ind8 = zigzag(dct8)
ind32 = zigzag(dct32)

dct4zLF = dct4
dct8zLF = dct8
dct32zLF = dct32

dct4zLF(ind4(2:6)) = 0
dct8zLF(ind8(2:15)) = 0
dct32zLF(ind32(2:210)) = 0

idct4zLF = idct2(dct4zLF)
idct8zLF = idct2(dct8zLF)
idct32zLF = idct2(dct32zLF)

figure %Figure 3
subplot(3,3,1)
imshow(crop4)
title('4x4')
subplot(3,3,2)
imshow(crop8)
title('8x8')
subplot(3,3,3)
imshow(crop32)
title('32x32')
subplot(3,3,4)
imshow(log(abs(dct4zLF)))
subplot(3,3,5)
imshow(log(abs(dct8zLF)))
subplot(3,3,6)
imshow(log(abs(dct32zLF)))
subplot(3,3,7)
imshow(idct4zLF,[0 255])
subplot(3,3,8)
imshow(idct8zLF,[0 255])
subplot(3,3,9)
imshow(idct32zLF,[0 255])

% Zero out high frequency components
dct4zHF = dct4
dct8zHF = dct8
dct32zHF = dct32

dct4zHF(ind4(7:length(ind4))) = 0
dct8zHF(ind8(16:length(ind8))) = 0
dct32zHF(ind32(211:length(ind32))) = 0

idct4zHF = idct2(dct4zHF)
idct8zHF = idct2(dct8zHF)
idct32zHF = idct2(dct32zHF)

figure %Figure 4
subplot(3,3,1)
imshow(crop4)
title('4x4')
subplot(3,3,2)
imshow(crop8)
title('8x8')
subplot(3,3,3)
imshow(crop32)
title('32x32')
subplot(3,3,4)
imshow(log(abs(dct4zHF)))
subplot(3,3,5)
imshow(log(abs(dct8zHF)))
subplot(3,3,6)
imshow(log(abs(dct32zHF)))
subplot(3,3,7)
imshow(idct4zHF,[0 255])
subplot(3,3,8)
imshow(idct8zHF,[0 255])
subplot(3,3,9)
imshow(idct32zHF,[0 255])

% (5) and (6)
Qy = [16,11,10,16,24,40,51,61;
      12,12,14,19,26,58,60,55;
      14,13,16,24,40,57,69,56;
      14,17,22,29,51,87,80,62;
      18,22,37,56,68,109,103,77;
      24,35,55,64,81,104,113,92;
      49,64,78,87,103,121,120,101;
      72,92,95,98,112,100,103,99]

cPic = pic(100:163,100:163)
dim = size(cPic)
for i = 1:8:dim(1,1)
    for j = 1:8:dim(1,2)
        dctcPic(i:i+7,j:j+7) = dct2(cPic(i:i+7,j:j+7))
        QdctcPic(i:i+7,j:j+7) = dctcPic(i:i+7,j:j+7)./Qy
        RdctcPic(i:i+7,j:j+7) = round(QdctcPic(i:i+7,j:j+7))
        dQdctcPic(i:i+7,j:j+7) = RdctcPic(i:i+7,j:j+7).*Qy
        reconstructed(i:i+7,j:j+7) = idct2(dQdctcPic(i:i+7,j:j+7))
    end
end

figure
subplot(2,3,1)
imshow(log(abs(dctcPic)))
title('DCT')
subplot(2,3,2)
imshow(QdctcPic)
title('Quantized')
subplot(2,3,3)
imshow(RdctcPic)
title('Rounded Quant')
subplot(2,3,4)
imshow(cPic)
title('Original')
subplot(2,3,5)
imshow(reconstructed,[0 255])
title('Reconstructed')

% Calculate MSE
% mse = 0
% numData = dim(1,1)*dim(1,2)
% for i = 1:dim(1,1)
%     for j = 1: dim(1,2)
%         mse = mse + (reconstructed(i,j) - vpa(cPic(i,j),5))^2
%     end
% end
% mse = (mse/numData)

MSE = immse(reconstructed, double(cPic))
SNR = snr(reconstructed, double(cPic))
PSNR = psnr(reconstructed, double(cPic))










