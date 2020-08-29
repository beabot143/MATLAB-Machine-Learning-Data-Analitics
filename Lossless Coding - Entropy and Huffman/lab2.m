%*****************************************************************
% ELE725 Lab2: Lossless Coding
% Author: Bethany Santos
% Date: February 14, 2019
%*****************************************************************
clear
close ALL

testSeq = 'HUFFMAN IS THE BEST COMPRESSION ALGORITHM'
img_gray = imread('lena_gray.jpg')
img_colour = imread('lena_colour.jpg')

selfInfo_testSeq = myEntropy(testSeq)
selfInfo_img_gray = myEntropy(img_gray)

img_ycbcr = rgb2ycbcr(img_colour)
img_cb = img_ycbcr(:,:,2)
img_cr = img_ycbcr(:,:,3)

selfInfo_img_cb = myEntropy(img_cb)
selfInfo_img_cr = myEntropy(img_cr)

entropy_testSeq = calcEntropy(selfInfo_testSeq)
entropy_img_gray = calcEntropy(selfInfo_img_gray)
entropy_img_cb = calcEntropy(selfInfo_img_cb)
entropy_img_cr = calcEntropy(selfInfo_img_cr)

% assuming 8bpp for grayscale images and 8 bits each RGB channel
compRate_gray = 8/entropy_img_gray
compRate_cb =8/entropy_img_cb
compRate_cr = 8/entropy_img_cr

symbolscr = unique(img_cr)
plot(symbolscr,selfInfo_img_cr)
title('Cr Channel Histogram')
xlabel('Symbols')
ylabel('Probability')
axis([0 255 0 0.1])
grid MINOR

figure
symbolscb = unique(img_cb)
plot(symbolscb,selfInfo_img_cb)
title('Cb Channel Histogram')
xlabel('Symbols')
ylabel('Probability')
axis([0 255 0 0.1])
grid MINOR

figure
symbolsgray = unique(img_gray)
plot(symbolsgray,selfInfo_img_gray)
title('Grayscale Image Histogram')
xlabel('Symbols')
ylabel('Probability')
axis([0 255 0 0.1])
grid MINOR

% figure
% symbolsTestSeq = unique(testSeq)
% plot(symbolsTestSeq, selfInfo_testSeq)
