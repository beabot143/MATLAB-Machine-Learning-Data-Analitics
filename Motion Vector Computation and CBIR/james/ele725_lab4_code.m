%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ELE725 LAB 4:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Part I:

vid = VideoReader('video.mp4');
% Get first 10 frames and store each frame 
frames = zeros(vid.Height, vid.Width,10);
frames_diff = zeros(vid.Height, vid.Width, 9);
for i = 1:10
    frame = readFrame(vid);
    gframe = rgb2gray(frame);
    frames(:,:,i) = gframe;
    if (i>1)
        frames_diff(:,:,i-1) = frames(:,:,i) - frames(:,:,i-1);
    end
end

% NOTE: We will be using 1st 2 frame for the exercise
frame1 = frames(:,:,1);
frame2 = frames(:,:,2);

% Divide frame to into list of 16x16 frames
frame2_div = zeros(16,16,(vid.Height*vid.Width)/(16*16));
index = 1;
for y = 1:16:size(frame2,2)
    for x = 1:16:size(frame2,1)
        frame2_div(:,:,index) = frame2(x:x+15, y:y+15);
        index=index+1;
    end
end

% Set default search radius
k = 7;

% Compute motion vector
[dx dy] = computeMotionVec(frame1, frame2, 100, 100,k);

% Apply motion vector computation to all blocks in frame 2
mv_data = zeros(size(frame2_div,3),2);
index = 1;
for y = 1:16:size(frame2,2)
    for x = 1:16:size(frame2,1)
        [dx dy] = computeMotionVec(frame1, frame2, x, y, k);
        mv_data(index, :) = [dx dy];
        index=index+1;
    end
end

% Compute difference with motion vector predictor
diff = zeros(size(frame2));
index = 1;
for y = 1:16:size(frame2,2)
    for x = 1:16:size(frame2,1)
        dx = mv_data(index,1); 
        dy = mv_data(index,2);
        diff(x:x+15, y:y+15) = frame2(x:x+15, y:y+15)-frame1(x+dx:x+dx+15,y+dy:y+dy+15);
        index=index+1;
    end
end

% Get Entropy
pv1 = myEntropy(diff(:,:));
entro1 = -sum(pv1.*log2(pv1));

diff_direct = frame2-frame1;
pv2 = myEntropy(diff_direct);
entro2 = -sum(pv2.*log2(pv2));

%% Part II

