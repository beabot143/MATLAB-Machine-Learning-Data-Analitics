%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ELE725 Lab4 : computeMotionVec
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [dx dy] = computeMotionVec(frame_pre, frame_cur, p, q, k)

% frame_pre = previous frame
% frame_cur = current frame
% p q = pixel location (x y) x->vertical, q->vertical
% k = search radius

win_size = (2*k+1)*(2*k+1);
mn = prod(size(frame_cur));
mad_data = zeros(win_size,3);
mv_index = 1;

for i = -k:k
    for j = -k:k
        % Calculate current mad value
        if (p+i < 1 || q+j < 1 || p+i+15> size(frame_cur,1) || q+j+15>size(frame_cur,2))
            diff = 99999;
        else
            diff = abs(frame_cur(p:p+15, q:q+15)-frame_pre(p+i:p+i+15,q+j:q+j+15));
        end
        mad = sum(diff(:))/mn;
        mad_data(mv_index,:) = [i j mad];
        mv_index = mv_index + 1;
    end
end

mv_param = mad_data(find(mad_data(:,3)==min(mad_data(:,3))),:);
dx = mv_param(1,1);
dy = mv_param(1,2);
%dx = 1;
%dy = 1;

