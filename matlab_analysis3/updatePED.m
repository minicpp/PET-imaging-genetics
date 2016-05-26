genomeFile='D:\mydoc\research\adni2\data\adni1_nosex.ped'
outGenomeFile='D:\mydoc\research\adni2\data\adni1_nosex.ped'

fid = fopen(genomeFile,'r');
fidW = fopen(outGenomeFile,'w');
tline=fgets(fid);
i=0;
while ischar(tline)
    A=strsplit(tline);
    chromosomeID = str2double(char(A(1)));
    if chromosomeID<23
        fwrite(fidW, tline);
    else
        lastPos = (-1)*str2double(char(A(4)));
        fprintf(fidW, '%s\t%s\t%s\t%d\n',char(A(1)), char(A(2)), char(A(3)), lastPos);
    end        
    i=i+1;
    if mod(i,10000) == 0
        fprintf(' %d',i);
    end
    
    tline=fgets(fid);
end
fclose(fid);