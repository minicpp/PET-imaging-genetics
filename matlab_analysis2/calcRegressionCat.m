function [ res, pval, pint, px,page ] = calcRegressionCat( x,age,yMatrix )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
ux = unique(x);
size(ux)
ux
for ii=1:size(yMatrix,2)
    x = nominal(x);
    y = yMatrix(:,ii);
    apoeTable = table(x , age, y);
    mdl = fitlm(apoeTable,'y ~ x + age')
end


