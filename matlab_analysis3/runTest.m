clear;
load('dataset.mat');

individualIDIntersect = intersect(individualID1,individualID2);

fprintf('Gene samples in ADNI 1 is %d, in ADNI GO/2 is %d\n', ...
    length(individualID1), length(individualID2));

fprintf('Total Gene samples: %d\n',  length(individualID1) + length(individualID2) );

fprintf('Shared id in ADNI 1 and ADNI GO: %d\n', length(individualIDIntersect));

fprintf('APOE total samples: %d, APOE unique samples: %d\n', length(apoeRid), length(unique(apoeRid)));

fprintf('Diagnosis summary samples: %d, unique samples: %d\n', ...
    length(dxRid), length(unique(dxRid)));

geneRID1 = [cellfun(@GetRIDfromSubjectID, individualID1)];
geneRID2 = [cellfun(@GetRIDfromSubjectID, individualID2)];


%% we focus on the gene data in adni 1