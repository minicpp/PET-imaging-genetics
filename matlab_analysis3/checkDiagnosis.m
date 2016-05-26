function [ res ] = checkDiagnosis( current, change )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
change = str2double(change);
if isnan(current)
    if change == 1 || change == 7 || change == 9
        res = 1; %normal
    else
        res = 2;
    end
else
    if current == 1
        res = 1; %normal
    else
        res = 2; %abnormal
    end
end

end

