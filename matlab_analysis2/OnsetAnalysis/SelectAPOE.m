function [ num, ratio ] = SelectAPOE( dataset, apoeType )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
resLength = length(dataset);
if resLength == 0
    num = 0;
    ratio = 0;
    return;
end
apoeCount = 0;
for i=1:resLength
    res = dataset{i}.apoe(apoeType);
    if res > 0
        apoeCount = apoeCount + 1;
    end
end
num = apoeCount;
ratio = num/resLength;
end

