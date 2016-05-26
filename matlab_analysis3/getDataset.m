[familyID1, individualID1, ~, ~, sex1, phenotype1]=importADNI1file('D:\mydoc\research\adni2\data\ADNI_cluster_01_forward_757LONI.fam');
[familyID2, individualID2, ~, ~, sex2, phenotype2]=importADNIGO2file('D:\mydoc\research\adni2\data\ADNI_GO_2_Forward_Bin.fam');
[phase,~,dxRid,~,~,~,~,~,examDate,DxChange, DxCurrent, DxConv] = importDXfile('D:\mydoc\research\adni2\data\DXSUM_PDXCONV_ADNIALL.csv');

%%
[~,~,apoeRid,~,~,~,~,~,apgen1,apgen2] = importAPOERESfile('D:\mydoc\research\adni2\data\APOERES.csv');
save('dataset');
fprintf('\nDone.\n');