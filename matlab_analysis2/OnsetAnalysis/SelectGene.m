function [ num, ratio ] = SelectGene( dataset, geneName, geneType )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

resLength = length(dataset);
if resLength == 0
    num = 0;
    ratio = 0;
    return;
end
geneCount = 0;
for i=1:resLength
    value = getfield(dataset{i}, geneName)
    if isempty(value)~=1
        if value(1) == geneType || value(2) == geneType
            geneCount = geneCount + 1;
        end
    end
end
num = geneCount;
ratio = geneCount/resLength;

end

