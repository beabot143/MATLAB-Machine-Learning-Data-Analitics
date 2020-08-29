% Question 1
vid = VideoReader('test.mp4');
% Lets just test the first 10 frames
NumberOfFrames = 11
for img = 1:NumberOfFrames;
    a = rgb2gray(read(vid, img));
    frames{img} = a;
end

for img = 2:NumberOfFrames;
    difference = imsubtract(frames{(img-1)}, frames{img});
    frame_difference{(img-1)} = difference;
end

% Question 2
for i = 1:10 %(NumberOfFrames-1)
    selfInfo = myEntropy(frame_difference{i});
    entropy(i) = calcEntropy(selfInfo);
end
plot(entropy)

% Question 3
mean_entropy = sum(entropy)/10
compression_ratio = 8/mean_entropy

% Question 4
out_mode1 = interframe_coding('original.jpg', 1)
out_mode2 = interframe_coding('original.jpg', 2)
out_mode3 = interframe_coding('original.jpg', 3)
out_mode4 = interframe_coding('original.jpg', 4)

img = rgb2ycbcr(imread('original.jpg'))
img(:,:,1) = out_mode1
img = ycbcr2rgb(img)
imshow(img)