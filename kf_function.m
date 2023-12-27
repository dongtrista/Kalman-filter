function [result] = kf_function(single)
% single 需要滤波的数据，来自PLS模型的预测值
% result 滤波后的数据

%% 卡尔曼滤波
p1 = 1;
c1 = 0.8;  %初始值
q = 5;   %q/r是信噪比
r = 10;

T=1:length(single);

for i = T

p2 = p1 + q;
kg = p2 * p2 / (p2 * p2 + r * r);   %卡尔曼增益
c2 = c1 + kg * (single(i) - c1);    %卡尔曼滤波
p1 = (1 - kg) / p2;
c1 = c2;   %不断迭代

result(i) = c1;

end

%plot(T,single, 'r', T, result,'b');

end

