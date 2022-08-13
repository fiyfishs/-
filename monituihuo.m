function [solBest, resBest] = monituihuo(solution, solMin, solMax, a, t0, tMin, Markov)
%% 模拟退火算法
% 每一行代表一个变量
%% 参数说明
% a 衰减系数0.95
% t0 初始温度120
% tMin 终止温度0
% Markov 马尔科夫链长度

%%
[r, c] = size(solution); %r表示变量个数
resBest = objFun(solution);
res = objFun(solution);
solBest = solution;
solutions = solution;
t = t0;

%% 外循环开始——降温
while t >= tMin
    %% 内循环
    for i = 1 : Markov
        % 产生新解
        y = randn(1, r);
        z = y / sqrt(sum(y .^ 2));
        x = solutions + z * t;
     
        % 如果新解超出范围，进行调整
        for j = 1 : r
           if x(j) < solMin
               rr = rand(1);
               x = rr * solMin(j) + (1 - rr) * solutions(j);
           elseif x(j) > solMax
               rr = rand(1);
               x = r * solMax + (1 - r) * solutions(j);
           end
        end
        resX = objFun(x);
        
        %% 最大值最小值可能需要更改处
        if resX < res
            solutions = x;
            res = resX;
        else
            p =  exp(-(resX - res)/t); %根据蒙特卡洛准则计算一个概率
            if rand(1) <= p
                solutions = x;
                res = resX;  
            end
        end
        
        % 判断更新最佳点
        if res < resBest
            solBest = solutions;
            resBest = res;
        end
    end
    % 温度下降
    t = a * t;
end















