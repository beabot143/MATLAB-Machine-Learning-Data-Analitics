%% ELE725 Question 2
clear
clc
close all

database =["hoodie.png", "trees.png", "candle.png", "blocks.png", ...
            "lake.png", "onetree.png", "rose.png", "scarf.png", ...
            "smoke.png", "sunset.png", "greenbulb.png", "pepe.png"];

hist_db = {}

for i = 1:length(database)
    img1 = rgb2hsv(imread(char(database(i))))
    H_img1 = img1(:,:,1), S_img1 = img1(:,:,2), V_img1 = img1(:,:,3);
    hist_img1H = hist(H_img1(:),30), hist_img1S = hist(S_img1(:),15), hist_img1V = hist(V_img1(:),15);
    all3 = [hist_img1H, hist_img1S, hist_img1V]
    hist_db{i,1} = all3, hist_db{i,2} = char(database(i))
end

% This is proof of individually finding the histogram for H, S, V channels
% then combining them into one single histogram (non-overlapping).

figure
subplot(2,2,1)
bar(hist_img1H)
title('H channel')
xlabel('Bin'); ylabel('Frequency (occurences)')
subplot(2,2,2)
bar(hist_img1S)
title('S channel')
xlabel('Bin'); ylabel('Frequency (occurences)')
subplot(2,2,3)
bar(hist_img1V)
title('V channel')
xlabel('Bin'); ylabel('Frequency (occurences)')
all3 = [hist_img1H, hist_img1S, hist_img1V]
subplot(2,2,4)
bar(all3)
title('Concatenated HSV Histogram')
xlabel('Bin'); ylabel('Frequency (occurences)')

CBR('rose.png', hist_db, 5)

%% Question 4
hist_db_blocks = {}

for i = 1:length(database)
    img1 = rgb2hsv(imread(char(database(i))))
    x = size(img1, 1)/4
    y = size(img1, 2)/2
    for j = 1:4
        new_img{j} = img1((x*j)-24 : x*j, 1:y, :)
        new_img{j+4} = img1((x*j)-24 : x*j, y+1:2*y, :)
    end
    for k = 1:length(new_img)
        img1 = cell2mat(new_img(k))
        H_img1 = img1(:,:,1), S_img1 = img1(:,:,2), V_img1 = img1(:,:,3);
        hist_img1H = hist(H_img1(:),30), hist_img1S = hist(S_img1(:),15), hist_img1V = hist(V_img1(:),15);
        all3 = [hist_img1H, hist_img1S, hist_img1V]
        temp_8blocks{i,k} = all3;
    end
    
    hist_db_blocks{i,1} = [temp_8blocks{1,:}]
    hist_db_blocks{i,2} = char(database(i))
end

CBR_block('rose.png', hist_db_blocks, 5)  