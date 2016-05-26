function [ output_args ] = calcRegressionSub(key, x, age, yMatrix)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

ux = unique(x);
P = zeros(numel(ux,1), size(yMatrix,2), 2);
for ii=1:numel(ux)
    ele = ux(ii)
    str = sprintf('%d',ele);
    p1 =str2num(str(1));
    p2 =str2num(str(2));
    v = 0;
    if p1~=key && p2~=key
        v = 0;
    elseif p1==key && p2==key
        v = 2;
    else
        v = 1;
    end
    I = find(x==ele);
    x(I) = v;  
    
end

ux=unique(x);
for ii=1:numel(ux)
    for jj=1:size(yMatrix,2)
        I = find(x== (ii-1))
        if numel(I) == 1
            P(ii, jj,:) = [yMatrix(I,jj),0];
        else
            P(ii, jj,:) = mle(yMatrix(I,jj));
        end
    end
end


for ii=1:size(yMatrix,2)
    figure;
    plot(x,yMatrix(:,ii),'bo');
    hold on;
    errorbar(ux,P(ux+1,ii,1),P(ux+1,ii,2)*2,'ro','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor',[.49 1 .63],...
                'MarkerSize',10)
    title(sprintf('%d',key));
    hold off;
end
