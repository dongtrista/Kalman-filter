%输入一个参考值，得到一个卡尔曼校正的PLS系数
X=coef_original; %PLS原始模型系数
t=length(X);
Z=ypre05;
P=eye(t); %生成1484*1484的单位矩阵
R=0.5;
V=0.001; 
X_ALL=[];
rereg05=[];
f=length(Z);

for i = 1:f  % 迭代100次
    H=[B4(i,[1:1483 2483:2783]) 1];  % 第i个光谱预处理后的值加上1，1*1484
    X_ = X;  % 原始系数
    P_ = P;  % 初始P
    K = P_*H'/(H*P_*H'+R);  %卡尔曼增益
    X = X_+K*(Z(i)-H*X_+V); %卡尔曼滤波校正后的系数
    P = (eye(t)-K*H)*P_; %更新协方差

    X_ALL(:,i)=X;
    

    rereg05(i,:)=H*X;
end
