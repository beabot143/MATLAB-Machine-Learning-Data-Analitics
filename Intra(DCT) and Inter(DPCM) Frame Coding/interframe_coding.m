function [output] = interframe_coding(image, mode)

    img = rgb2ycbcr(imread(image))
    img_y = img(:,:,1)
    img_size = size(img)
    
    if mode == 1
        for i = 1:img_size(1)
            for j = 1:img_size(2)
                if (j-1 < 1)
                    out_img(i,j) = 0
                else
                    out_img(i,j) = img_y(i,j-1)
                end
            end
        end
        
    elseif mode == 2
        for i = 1:img_size(1)
            for j = 1:img_size(2)
                if (i-1 < 1)
                    out_img(i,j) = 0
                else
                    out_img(i,j) = img_y(i-1,j)
                end
            end
        end
        
    elseif mode == 3
        for i = 1:img_size(1)
            for j = 1:img_size(2)
                if (i-1 < 1 || j-1 < 1)
                    out_img(i,j) = 0
                else
                    out_img(i,j) = img_y(i-1,j-1)
                end
            end
        end
        
    elseif mode == 4
        for i = 1:img_size(1)
            for j = 1:img_size(2)
                if (i-1 < 1 || j-1 < 1)
                    out_img(i,j) = 0
                else
                    out_img(i,j) = img_y(i,j-1) + img_y(i-1,j) - img_y(i-1,j-1)
                end
            end
        end
    end
    
output = out_img