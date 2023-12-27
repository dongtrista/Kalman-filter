
Z=y([3;4;7;12;13;16;22;23],2);%真实值，即参考值
P=1;
B=0; %初始差值
q=10;
R=8;       %q/R为信噪比
pre=[];
result_all=[];
BNEW=0;

for i = 1:length(Z)  % 迭代次数
    [result1] = kf_function(pls(1:b05(i,2),1));  %PLS原始预测值经过kf-function滤波
    result2=result1(b05(i,1):b05(i,2))+sum(BNEW(1:i));
    X_=result2(end);
    B_=B;
    P_ = P+q;  % 初始P
    K = P_*P_/(P_*P_+R*R);  %卡尔曼增益
    B = B_+K*(Z(i)-X_-B_); %卡尔曼滤波校正后的残差
    P = (1-K)/P_; %更新协方差
    result_all(b05(i,1):b05(i,2),:)=result2';  %卡尔曼预测值

    BB(i,:)=Z(i)-X_;  %原始残差
    BNEW(i+1,:)=B;      %卡尔曼校正后的残差
    pre(i,:)=X_+B;    %卡尔曼校正后的值

    
end
