clear;
load('dataset.mat');

geneRID1 = [cellfun(@GetRIDfromSubjectID, individualID1)];
geneRID2 = [cellfun(@GetRIDfromSubjectID, individualID2)];

geneRID = geneRID1;
familyID = familyID1;
individualID = individualID1;

fid = fopen('phenotype.txt','w');
fprintf(fid,'FID\tIID\tfirst\tlast\n');
firstCase = 0;
firstControl =0;
lastCase = 0;
lastControl = 0;
for i=1:length(geneRID)
    I = find(dxRid == geneRID(i));
    F = I(1);
    L = I(end);
    firstVisitPhenotype = checkDiagnosis(DxCurrent(F),DxChange(F));
    if firstVisitPhenotype == 2
        firstCase = firstCase + 1;
    else
        firstControl = firstControl + 1;
    end
    
    lastVisitPhenotype = checkDiagnosis(DxCurrent(L),DxChange(L));
    
    if lastVisitPhenotype == 2
        lastCase = lastCase + 1;
    else
        lastControl = lastControl + 1;
    end
    
    fprintf(fid, '%d\t%s\t%d\t%d\n', familyID(i), char(individualID(i)), firstVisitPhenotype, lastVisitPhenotype);
end

fclose(fid);

fprintf('First case: %d, First control: %d; Last case: %d, last control: %d\n', ...
    firstCase, firstControl, lastCase, lastControl);