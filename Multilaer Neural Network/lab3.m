%************************************************************************
% ELE888 LAB 3: Multilayer Neurl Networks
% Submission: March 25
% ***********************************************************************
clear ALL
close ALL
%% Part 1: XOR MNN Implementation
% Construct a 2-2-1 Neural Network using back propagation algorithm to
% solve the classical XOR problem

% Inputs, target values,learning rate, threshold
x1=[-1 -1 1 1];
x2=[-1 1 -1 1];
t=[-1 1 1 -1]
eta=0.1
theta=0.001
zk=[0 0 0 0];
r=1;
flag=0;
deltaJ=0;

% Initial Weight Values
wj1=[1 1 1]
wj2=[-2 1 1]
wk=[-1 0.7 -0.5]

while (flag == 0)
    deltawj1=[0 0 0];
    deltawj2=[0 0 0];
    deltawjk=[0 0 0];
    
    for m=1:length(x1)
        xm=[1 x1(m) x2(m)];
        
        netj1=wj1*xm';
        netj2=wj2*xm';
        
        y1_prime=1-(tanh(netj1))^2;
        y2_prime=1-(tanh(netj2))^2;
        y1=tanh(netj1);
        y2=tanh(netj2);
        
        y=[1 y1 y2];
        
        netk=y*wk';
        
        zk(m)=tanh(netk);
        zkprime=1-zk(m)^2;
        
        deltak=(t(m)-zk(m))*zkprime;
        deltaj1=y1_prime*wk(2)*deltak;
        deltaj2=y2_prime*wk(3)*deltak;

        deltawj1=deltawj1+eta*deltaj1*xm;
        deltawj2=deltawj2+eta*deltaj2*xm;
        deltawjk=deltawjk+eta*deltak*y;
         
    end
    
    %Weight Vectors
    wj1=wj1+deltawj1;
    wj2=wj2+deltawj2;
    wk=wk+deltawjk;
    
    %Error criterion
    J(r)=0.5*norm(t-zk)^2;
    
    if (r==1)
        deltaJ(r)=J(r);
    else
        deltaJ(r)=abs(J(r-1)-J(r));
        if ((deltaJ(r)<theta) && r<100000)
            flag=1;
        end
    end
    
    r=r+1;
    
end

%Plot learning curve
figure;
n=[0:1:length(J)-1];
plot(n,J)
hold on; 
title('Learning Curve (XOR)');
xlabel('r');
ylabel('J(r)');
grid MINOR;
axis([0 50 0 2]);

epochIter_XOR = r-1
finalWeigth_XOR = [wj1;wj2;wk]

%Plot the XOR decision boundaries
% figure;
% x11=(-3:3);
% w01=wj1(1);
% w11=wj1(2);
% w21=wj1(3);
% x21=-(w11/w21)*x11-(w01/w21);
% plot(x11,x21,'b');
% 
% w01=wj2(1);
% w11=wj2(2);
% w21=wj2(3);
% x22=-(w11/w21)*x11-(w01/w21);
% hold on;
% bound=plot(x11,x22,'b');
% 
% for i=1:length(x1)
%     if (zk(i)<0)
%         false=plot(x1(i),x2(i),'rx');
%     else
%         true=plot(x1(i),x2(i),'ro');
%     end
% end
% hold on;
% title('x1 vs. x2 Decision Space (XOR)');
% xlabel('x1');
% ylabel('x2');
% legend([true,false,bound],'XOR True(1)','XOR False(-1)','Boundary');
% grid MINOR

%Find the accuracy
correct=0;
accuracy=0;
for i=1:length(x1)
    if floor(zk(i))==t(i) || ceil(zk(i))==t(i)
        correct=correct+1;
    end
end
accuracy=correct*100/length(x1);
accuracy_XOR = accuracy

% figure;
% y11=(-3:3);
% w01=wk(1);
% w11=wk(2);
% w21=wk(3);
% y21=-(w11/w21)*x11-(w01/w21);
% plot(x11,x22,'b');
% hold on; 
% title('y1 vs. y2 Decision Space (XOR)');
% xlabel('y1');
% ylabel('y2');
% grid MINOR

%% Part 2: MNN Implementation with wine.data

WineData=load('wine.data');
TrainingSet=zeros(107,3);
TrainingSet(1:59,:,:)=WineData(1:59,1:3); %Class 1=w1
TrainingSet(60:107,:,:)=WineData(131:178,1:3); %Class 3=w2

% Normalize TrainingSet such that w2=-1
for i=60:length(TrainingSet)
    TrainingSet(i,1)=-1;
end

t=TrainingSet(:,1)'; %Targets values are the actual class labels
x1=TrainingSet(:,2)'; %Set x1 to represent alcohol content
x2=TrainingSet(:,3)'; %Set x2 to represent malic acid content

%Normalize x1 and x2 to be within x1=(-3:3)
x1 = normalize(x1)
x2 = normalize(x2);

zk=[0 0 0 0];
r=1;
flag=0;
deltaJ=0;

while flag==0
    deltawj1=[0 0 0];
    deltawj2=[0 0 0];
    deltawjk=[0 0 0];
    
    for m=1:length(x1)
        xm=[1 x1(m) x2(m)];
        
        netj1=wj1*xm';
        netj2=wj2*xm';
        
        y1_prime=1-(tanh(netj1))^2;
        y2_prime=1-(tanh(netj2))^2;
        y1=tanh(netj1);
        y2=tanh(netj2);
        
        y=[1 y1 y2];
        
        netk=y*wk';
        
        zk(m)=tanh(netk);
        zkprime=1-zk(m)^2;
        
        deltak=(t(m)-zk(m))*zkprime;
        deltaj1=y1_prime*wk(2)*deltak;
        deltaj2=y2_prime*wk(3)*deltak;

        deltawj1=deltawj1+eta*deltaj1*xm;
        deltawj2=deltawj2+eta*deltaj2*xm;
        deltawjk=deltawjk+eta*deltak*y;
        
    end
    
    %Weight Vectors
    wj1=wj1+deltawj1;
    wj2=wj2+deltawj2;
    wk=wk+deltawjk;
    
    %Error criterion
    J(r)=0.5*norm(t-zk)^2;
    
    if (r==1)
        deltaJ(r)=J(r);
    else
        deltaJ(r)=abs(J(r-1)-J(r));
        if ((deltaJ(r)<theta) && r<100000)
            flag=1;
        end
    end
    
    r=r+1;
    
end

%Plot learning curve
figure;
n=[0:1:length(J)-1];
plot(n,J)
hold on; 
title('Learning Curve (wine)');
xlabel('r');
ylabel('J(r)');
grid MINOR

epochIter_wine = r-1;
finalWeight_wine = [wj1;wj2;wk]

%Plot the XOR decision boundaries
% figure;
% x11=(-3:3);
% w01=wj1(1);
% w11=wj1(2);
% w21=wj1(3);
% x21=-(w11/w21)*x11-(w01/w21);
% plot(x11,x21,'b');
% 
% w01=wj2(1);
% w11=wj2(2);
% w21=wj2(3);
% x22=-(w11/w21)*x11-(w01/w21);
% hold on;
% bound=plot(x11,x22,'b');
% 
% for i=1:length(x1)
%     if (zk(i)<0)
%         false=plot(x1(i),x2(i),'rx');
%     else
%         true=plot(x1(i),x2(i),'ro');
%     end
% end
% hold on; 
% title('x1 vs. x2 Decision Space (wine)');
% xlabel('Alcohol Content (%)');
% ylabel('Malic Acid Content');
% legend([true,false,bound],'Class 1','Class 2','Boundary');
% grid MINOR

%Find the accuracy
correct=0;
accuracy=0;
for i=1:length(x1)
    if floor(zk(i))==t(i) || ceil(zk(i))==t(i)
        correct=correct+1;
    end
end
accuracy=correct*100/length(x1);
disp('Accuracy');
accuracy_wine = accuracy;

% figure;
% y11=(-3:3);
% w01=wk(1);
% w11=wk(2);
% w21=wk(3);
% y21=-(w11/w21)*x11-(w01/w21);
% plot(x11,x22,'b');
% hold on; 
% title('y1 vs. y2 Decision Space (wine)');
% xlabel('y1');
% ylabel('y2');
% grid MINOR;

