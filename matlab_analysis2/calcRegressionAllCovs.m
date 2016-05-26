function [ output_args ] = calcRegressionAllCovs(x, age, yMatrix, tname)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
e2e3e4=zeros(numel(x),3);

ux = unique(x);
for ii=1:numel(ux)
    ele = ux(ii);
    I = find(x==ele);
    if ele == 22
        e2e3e4(I,1) = 2;
    elseif ele == 23
        e2e3e4(I,1) = 1;
        e2e3e4(I,2) = 1;
    elseif ele == 24
        e2e3e4(I,1) = 1;
        e2e3e4(I,3) = 1;
    elseif ele == 33
        e2e3e4(I,2) = 2;
    elseif ele == 34
        e2e3e4(I,2) = 1;
        e2e3e4(I,3) = 1;
    elseif ele == 44
        e2e3e4(I,3) = 2;
    else
        disp('unknow element');
    end
end

for ii=1:size(yMatrix,2)
    e2 = e2e3e4(:,1);
    e3 = e2e3e4(:,2);
    e4 = e2e3e4(:,3);
    y=yMatrix(:,ii);
    apoeTable = table(e2,e3,e4,age,y);    
    mdl = fitlm(apoeTable,'y ~ e2 + e3 + e4')
end

y1=yMatrix(:,1);
y2=yMatrix(:,2);
y3=yMatrix(:,3);
fullTable = table(e2,e3,e4,age, y1,y2,y3);
writetable(fullTable, tname,'Delimiter',',')
