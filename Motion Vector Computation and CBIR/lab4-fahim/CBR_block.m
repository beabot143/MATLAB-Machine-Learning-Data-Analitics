function [output] = CBR_block(img, database, equation)  
    
    img1 = rgb2hsv(imread(img))
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
        temp_8blocks{1,k} = all3;
    end
    
    img_HSV = [temp_8blocks{1,:}]
 
    if equation == 3
        for i = 1:size(database,1)
            if strcmp(img, char(database(i,2))) == 1
                continue
            end
            temp = cell2mat(database(i,1));
            sum = 0
            for j = 1:size(img_HSV, 2)
                sum = sum + (abs(img_HSV(j) - temp(j)));
            end
            hist_match{i,1} = sum, hist_match{i,2} = char(database(i,2))            
        end
    end
    
    if equation == 4
        for i = 1:size(database,1)
            if strcmp(img, char(database(i,2))) == 1
                continue
            end
            temp = cell2mat(database(i,1));
            sum = 0
            for j = 1:size(img_HSV, 2)
                sum = sum + ((img_HSV(j) - temp(j))^2);
            end
            hist_match{i,1} = sum, hist_match{i,2} = char(database(i,2))            
        end
    end
    
    if equation == 5
        for i = 1:size(database,1)
            if strcmp(img, char(database(i,2))) == 1
                continue
            end
            temp = cell2mat(database(i,1));
            sum = 0
            for j = 1:size(img_HSV, 2)
                sum = sum + ( min(img_HSV(j), temp(j)) );
            end
            sum = sum/ min(length(img_HSV), length(database(i,1)))
            hist_match{i,1} = sum, hist_match{i,2} = char(database(i,2))            
        end
    end
    
row_has_empty = any(cellfun(@isempty, hist_match), 2);  
hist_match(row_has_empty,:) = [];   
hist_match = sortrows(hist_match, 1)

figure
for i = 1:length(hist_match)
    subplot(1,length(hist_match),i)
    tmp = imresize(imread(char(hist_match(i,2))), [300, 300]) 
    imshow(tmp)
end

figure
subplot(1,2,1)
bar(img_HSV)
title('Histogram of Input Image')
xlabel('Bin'); ylabel('Frequency (occurences)')
subplot(1,2,2)
[row, col] = find(strcmp(database, hist_match{1,2}))
bar(database{row, 1})
title('Histogram of Best Matched Image')
xlabel('Bin'); ylabel('Frequency (occurences)')

output = hist_match