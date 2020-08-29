%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ELE725 LAB4: Motion Compensation and CBIR
% Submission Date: April 11, 2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close ALL
clear 

%% Part 1: Motion Vector Computation
% block Size = 16x16

video = VideoReader('video1.mp4')
k = 7 % search radius set to 7

frame1 = rgb2gray(read(video,10)) %first frame of the video
frame2 = rgb2gray(read(video,20))

%cut frames to debuggable size
frame1 = frame1(1:video.Height,1:video.Width)
frame2 = frame2(1:video.Height,1:video.Width)

figure
imshow(frame1)
figure
imshow(frame2)

% Compute Motion Vector
i = 1
for y = 1:16:size(frame2,2)
    for x = 1:16:size(frame2,1) x
        [dx dy] = computeMotionVec(frame1, frame2, x, y, k)
%       frameDiff(x:x+15, y:y+15) = frame2(x:x+15, y:y+15)-frame1(x+dx:x+dx+15,y+dy:y+dy+15);
        MV_values(i, :) = [dx dy]
        i=i+1
    end
end

% Compute frameDifference
i = 1 %reset i to 1
for y = 1:16:size(frame2,2)
    for x = 1:16:size(frame2,1)
        dx = MV_values(i,1)
        dy = MV_values(i,2)
        frameDiff(x:x+15, y:y+15) = frame2(x:x+15, y:y+15)-frame1(x+dx:x+dx+15,y+dy:y+dy+15)
        i=i+1;
    end
end

% Calculate Entropy
pv1 = myEntropy(frameDiff(:,:));
entropy1 = -sum(pv1.*log2(pv1));

frameDiff_direct = frame2-frame1;
pv2 = myEntropy(frameDiff_direct);
entropy2 = -sum(pv2.*log2(pv2));

