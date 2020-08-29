%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ELE888 LAB$: Unsupervised Learning
% Submission Date: April 8, 2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
close ALL

% Transform pixel data into 2D array of input samples
I=imread('house.tiff'); 
imshow(I);
[M,N,D]=size(I); 
X=reshape(I,M*N,3); 
X=double(X); 

% Plot array of pixel samples in RGB space
figure;
plot3(X(:,1),X(:,2),X(:,3),'c.') 
xlim([0 255]); 
ylim([0 255]); 
zlim([0 255]); 
grid;
title('All pixels in RGB'); 
xlabel('Red'); ylabel('Green'); zlabel('Blue');

%% Part (a) 
% c=2

M0 = [
  167.3447  239.5471   61.5625;
  244.9756  117.2189  195.5579
    ]; 

%M0 = rand(2,3);
%M0 = M0*256
M = M0
pre_M = zeros(size(M));  

J = [];
M1_old = [M(1,:)];
M2_old = [M(2,:)];

while (pre_M ~= M)

    pre_M = M;
    
    J1 = (X - repmat(M(1,:), size(X,1), 1));
    J1 = sum(J1.^2, 2);  

    J2 = (X - repmat(M(2,:), size(X,1), 1));
    J2 = sum(J2.^2, 2);  

    cluster1 = J1 < J2;
    cluster2 = ~cluster1;  

    M(1,:) = sum(X(cluster1, :)) / sum(cluster1);
    M(2,:) = sum(X(cluster2, :)) / sum(cluster2);
    
    J = [J sum(min(J1, J2))];  
    M1_old = [M1_old; M(1,:)];
    M2_old = [M2_old; M(2,:)];
   
end

% Part (a) 1.
% plot error Citerion
figure
plot(J)  
title("Error Criterion")
xlabel("# of Iterations")
ylabel("J")
grid MINOR

% Part (a) ii
figure
plot3(M1_old(:, 1), M1_old(:, 2), M1_old(:, 3), 'b*')
hold on
plot3(M2_old(:, 1), M2_old(:, 2), M2_old(:, 3), 'r*')
title('Cluster'); 
xlabel('Red'); ylabel('Green'); zlabel('Blue');
grid MINOR

% Part (a) iii
figure
X1 = X(cluster1, :);
X2 = X(cluster2, :);  

plot3(X1(:,1), X1(:,2), X1(:,3),'.','Color', M(1,:)/256)
hold on
plot3(X2(:,1), X2(:,2), X2(:,3),'.','Color', M(2,:)/256)  
title('All Pixels in RGB Space'); 
xlabel('Red'); ylabel('Green'); zlabel('Blue');
grid MINOR

% Part(a) iv
figure
XX = repmat(M(1,:), size(X,1), 1) .* repmat(cluster1, 1, size(X,2));
XX = XX + repmat(M(2,:), size(X,1), 1) .* repmat(cluster2, 1, size(X,2));
XX = reshape(XX, size(I, 1), size(I, 2), 3);

subplot(1,2,1);
imshow(I)
title("Original Image")
subplot(1,2,2);
imshow(XX/256)
title("Image Sample when c = 2")


%% Part (b)
% Repeat Part (a) with c = 5

c = 5;  

M1 = [
    166.4100  106.2267   96.4162
    95.1760   60.8064   75.5500
    162.7258  197.8992  217.7845
    159.7422  113.5673  222.8516
    125.4946  112.9992  118.9453
    ];

% M1 = rand(c,3)
% M1 = M1*255;

XX = [];
M = M1;

pre_M = zeros(size(M));

while (pre_M ~= M)

    pre_M = M;
    
    J = zeros(size(X,1), c);
    
    for i = [1:c]
        j = (X - repmat(M(i,:), size(X,1), 1));
        j = sum(j.^2, 2);
        J(:,i) = j;
    end
    [a, cluster] = min(J, [], 2);
    
    for i = [1:c]
        this_cluster = (cluster==i);
        M(i, :) = sum(X(this_cluster, :)) / sum(this_cluster);

    end
    
XX = zeros(size(X));

for i = [1:c]
    this_cluster = (cluster==i);
    XX = XX + repmat(M(i,:), size(X,1), 1) .* repmat(this_cluster, 1, size(X,2));
end

XX = reshape(XX, size(I, 1), size(I, 2), 3);
figure
subplot(1,2,1);
imshow(I)
title("Original Image")
subplot(1,2,2);
imshow(XX/256)
title("Image Sample when c = 5")

end

M1 = M
cluster1 = cluster;

figure
for i = [1:c]
    this_cluster = (cluster==i);
    Xi = X(this_cluster, :);
    plot3(Xi(:,1), Xi(:,2), Xi(:,3),'.','Color', M(i,:)/256)
    title('All pixels in RGB'); 
    xlabel('Red'); ylabel('Green'); zlabel('Blue');
    grid MINOR
    hold on
end

% second initial state
M2 = [                     
    245.9278  167.1520  203.4467
    110.2837   27.9875  124.3390 
    177.1618  238.1088  196.0844
    193.3153   47.8025  100.9817
    110.3238   67.8756   69.5994
];

% M2 = rand(c,3)
% M2 = M2*255
M = M2
pre_M = zeros(size(M));

while (pre_M ~= M)

    pre_M = M;
    
    J = zeros(size(X,1), c);
    
    for i = [1:c]
        j = (X - repmat(M(i,:), size(X,1), 1));
        j = sum(j.^2, 2);
        J(:,i) = j;
    end
    [a, cluster] = min(J, [], 2);
    
    for i = [1:c]
        this_cluster = (cluster==i);
        M(i, :) = sum(X(this_cluster, :)) / sum(this_cluster);
    end
    
end
M2 = M
cluster2 = cluster;

figure
for i = [1:c]
    this_cluster = (cluster==i);
    Xi = X(this_cluster, :);
    plot3(Xi(:,1), Xi(:,2), Xi(:,3),'.','Color', M(i,:)/256)
    title('All pixels in RGB'); 
    xlabel('Red'); ylabel('Green'); zlabel('Blue');
    grid MINOR
    hold on
end

%% Part (c)
% Xei-Beni

N = size(X,1);
XB1 = 0;  

for i = [1:c]
    this_cluster = (cluster1==i);
    Xi = X(this_cluster, :);
    mu_j = sort(sum((M1 - repmat(M1(i,:), c, 1)).^2, 2).^.5);
    XB1 = XB1 + sum(sum((Xi - repmat(M1(i,:), size(Xi,1), 1)).^2, 2).^.5) / mu_j(2);  %update XB
end

XB1 = XB1 / N
XB2 = 0;

for i = [1:c]
    this_cluster = (cluster2==i);
    Xi = X(this_cluster, :);
    mu_j = sort(sum((M2 - repmat(M2(i,:), c, 1)).^2, 2).^.5);
    XB2 = XB2 + sum(sum((Xi - repmat(M2(i,:), size(Xi,1), 1)).^2, 2).^.5) / mu_j(2);
end

XB2 = XB2 / N