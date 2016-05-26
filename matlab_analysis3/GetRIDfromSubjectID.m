function [ res ] = GetRIDfromSubjectID( sid )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here


sid = char(sid);
[token,remain] = strtok(sid,'_');
[token,remain] = strtok(remain,'_');
[token,remain] = strtok(remain,'_');
res = str2num(token);


end

