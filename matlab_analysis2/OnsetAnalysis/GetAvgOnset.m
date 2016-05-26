function [ avgFDG, avgF18AV45, avgPIB ] = GetAvgOnset(dataset, regionSet )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% check if all onsetAge are 0, all 0s mean no transistion
dataLength = length(dataset);
onsetAge = [];
for i=1:dataLength
    onsetAge = [onsetAge;dataset{i}.ageOnSet];
end

bTrans = find(onsetAge > 0);
FDG_onset_Total = [];
F18AV45_onset_Total = [];
PIB_onset_Total = [];
if length(bTrans) > 0 % focus on average of onset
    
    for i=1:length(bTrans)
        index = bTrans(i);
        FDG_index = dataset{index}.FDG_onset;
        F18AV45_index = dataset{index}.F18AV45_onset;
        PIB_index = dataset{index}.PIB_onset;
        if FDG_index> 0
            FDG_onset_Total = [FDG_onset_Total, regionSet(FDG_index)];
        end
        if F18AV45_index>0
            F18AV45_onset_Total = [F18AV45_onset_Total, regionSet(F18AV45_index)];
        end
        if PIB_index>0
            PIB_onset_Total = [PIB_onset_Total, regionSet(PIB_index)];
        end
    end
   
else %no on set value, we average all samples
    for i=1:length(dataset)
        FDG_index = dataset{i}.FDG_onset;
        F18AV45_index = dataset{i}.F18AV45_onset;
        PIB_index = dataset{i}.PIB_onset;
        FDG_onset_Total = [FDG_onset_Total; regionSet(FDG_index)];
        F18AV45_onset_Total = [F18AV45_onset_Total; regionSet(F18AV45_index)];
        PIB_onset_Total = [PIB_onset_Total; regionSet(PIB_index)];
    end
end

if isempty(FDG_onset_Total)
    avgFDG = 0;
else
    avgFDG = mean(FDG_onset_Total);
end

if isempty(F18AV45_onset_Total)
    avgF18AV45 = 0;
else
    avgF18AV45 = mean(F18AV45_onset_Total);
end

if isempty(PIB_onset_Total)
    avgPIB = 0;
else
    avgPIB = mean(PIB_onset_Total);
end

end

