%%FDG tracer1
%%F18AV45 tracer 2
%%PIB tracer 3

%%
%clear;
%importADNI;
load ADNIxls
%%
mapObj = containers.Map; % subject ID --> samples

% map from subject ID to index of rows.
iSize = size(SubjectID, 1);
for i=1:iSize
    str = char(SubjectID(i));
    res = mapObj.isKey(str);
    if res == 0
        mapObj(str)=[i];
    else
        mapObj(str)=[mapObj(str),i];
    end
end

%% map from subject ID to info (detailed of samples)
for i=keys(mapObj)
    subIDStr = char(i);
    index = mapObj(subIDStr);
    %struct for detailed of samples
    info = struct('subID',subIDStr, 'items',index,'FDG',[],'F18AV45',[],'PIB',[],'ChangeDiagnosis','', ...,
        'ageLow',0,'ageHigh',0,'ageOnSet',0, 'apoe',[0,0,0,0],'FDG_onset',0,'F18AV45_onset',0,'PIB_onset',0);
    j = index(1);
    apoe1 = APOEA1(j);
    apoe2 = APOEA2(j);
    info.apoe(apoe1) = info.apoe(apoe1) + 1;
    info.apoe(apoe2) = info.apoe(apoe2) + 1;
    for j=index
        tracer = Tracer(j);
        if tracer == 1
            info.FDG = [info.FDG, j];
        elseif tracer == 2
            info.F18AV45 = [info.F18AV45, j];
        elseif tracer == 3
            info.PIB = [info.PIB, j];
        else
            fpritnf('Unknow tracer %d at row %d\n',tracer,j);
        end
        strChangeofdiagnosis = char(Changeofdiagnosis(j));
        strLen = length(strChangeofdiagnosis);
        if strLen > 0
            if strcmp(info.ChangeDiagnosis,'') == 1 % Disease Transition point
                info.ChangeDiagnosis= strChangeofdiagnosis;
                info.ageOnSet = Age(j); % onset Age
            else
                fprintf('Error in change status (duplication) at row %d\n',j);
                info.ChangeDiagnosis = strcat(info.ChangeDiagnosis,'-', ...,
                    strChangeofdiagnosis);
            end
        end
    end
    if strcmp(info.ChangeDiagnosis,'')==1
        if(Diagnosistransition(info.FDG(1)) ==  Diagnosistransition(info.FDG(end)) ...,
            && Diagnosistransition(info.FDG(1))== 3)
            info.ChangeDiagnosis='MCI';
        elseif(Diagnosistransition(info.FDG(1)) ==  Diagnosistransition(info.FDG(end)) ...,
            && Diagnosistransition(info.FDG(1))== 2)
        info.ChangeDiagnosis='Normal';
        end
    end
    % get lower bound of Age, upper bound of Age, and onset Age
    info.ageLow = Age(index(1));
    info.ageHigh = Age(index(end));
    mapObj(subIDStr) = info;
end

%% calculate onset value (index) of FDG, F18AV45, PIB
for i=keys(mapObj)
    subIDStr = char(i);
    info = mapObj(subIDStr);
    onsetAge = info.ageOnSet;
    if onsetAge > 0
        % onset of FDG
        if length(info.FDG) > 0
            absAge = abs(Age(info.FDG) - onsetAge);
            [a,b] = min(absAge);
            info.FDG_onset = info.FDG(b);
        end
        if length(info.F18AV45) > 0
            absAge = abs(Age(info.F18AV45) - onsetAge);
            [a,b] = min(absAge);
            info.F18AV45_onset = info.F18AV45(b);
        end
        if length(info.PIB) > 0
            absAge = abs(Age(info.PIB) - onsetAge);
            [a,b] = min(absAge);
            info.PIB_onset = info.PIB(b);
        end
    end
    mapObj(subIDStr)=info;
end

mapObj = LoadGene(mapObj);

%% map from disease transition to samples
diseaseChangeMap=containers.Map;
for i=keys(mapObj)
    subIDStr = char(i);
    info = mapObj(subIDStr);    
    if strcmp(info.ChangeDiagnosis,'') == 0
        res = diseaseChangeMap.isKey(info.ChangeDiagnosis);
        if res == 0
            diseaseChangeMap(info.ChangeDiagnosis) = {info};
        else
            diseaseChangeMap(info.ChangeDiagnosis) = ...,
                [diseaseChangeMap(info.ChangeDiagnosis),info];
        end
    end
end

diseaseChangeMap('NL-MCI/AD')=[diseaseChangeMap('NL-MCI'), diseaseChangeMap('NL-AD')];

%% Sample statistics
% samples from NL-AD, NL-MCI
% samples from MCI-AD

age_low = [];
age_onset = [];
age_high = [];
res = diseaseChangeMap('NL-MCI/AD');
resLength1 = length(res);
for i=1:resLength1
    age_low = [age_low, res{i}.ageLow];
    age_onset = [age_onset, res{i}.ageOnSet];
    age_high = [age_high, res{i}.ageHigh];
end
X_NL_To_AD_or_MCI = [1:resLength1];
age_low = age_onset - age_low;
age_high = age_high - age_onset;
errorbar(X_NL_To_AD_or_MCI, age_onset, age_low, age_high,'rx');
xlabel('Samples');
ylabel('Age');
hold on;

age_onset1 = age_onset;

age_low = [];
age_onset = [];
age_high = [];
res = diseaseChangeMap('MCI-AD');
resLength = length(res);
for i=1:resLength
    age_low = [age_low, res{i}.ageLow];
    age_onset = [age_onset, res{i}.ageOnSet];
    age_high = [age_high, res{i}.ageHigh];
end

age_onset2 = age_onset;

%% Draw ages interval of samples
X_MCI_To_AD = [length(X_NL_To_AD_or_MCI)+1:length(X_NL_To_AD_or_MCI)+resLength];
age_low = age_onset - age_low;
age_high = age_high - age_onset;
errorbar(X_MCI_To_AD, age_onset, age_low, age_high,'bs');
legend('Normal to MCI/AD onset age', 'MCI to AD onset age', 'Location','best');
title('The onset age of each sample, and the age of first/last diagnosis in each sample');
hold off;

%% Draw bloxplot for onset ages of two types of diagnosis transition
group = cell(length(age_onset1)+length(age_onset2),1);
group(1:length(age_onset1))={'Normal to MCI/AD'};
group(length(age_onset1)+1:end) = {'MCI to AD'};
figure;
boxplot([age_onset1,age_onset2],group);
title('Age distribution for diagnosis transition');
xlabel('Transition types');
ylabel('Age of onset (Normal to MCI/AD, or MCI to AD)');

%% Draw APOE plot of samples
%DrawAPOE(diseaseChangeMap('NL-MCI/AD'), diseaseChangeMap('MCI-AD'), 2);
%DrawAPOE(diseaseChangeMap('NL-MCI/AD'), diseaseChangeMap('MCI-AD'), 3);
DrawAPOE(diseaseChangeMap('NL-MCI/AD'), diseaseChangeMap('MCI-AD'), 4);

%% bar
DrawBar(diseaseChangeMap);

DrawGeneBar(diseaseChangeMap, 'rs1876152', 'G', 'A');
DrawGeneBar(diseaseChangeMap, 'rs1501228', 'T', 'G');
DrawGeneBar(diseaseChangeMap, 'rs1946867', 'G', 'A');