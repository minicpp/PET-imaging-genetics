__author__ = 'mat'
inputFile = "/home/mat/adni/data/ADNI_cluster_01_forward_757LONI.bim"
outputFile = "/home/mat/adni/data/noSexSNP.txt"

record = []
with open(inputFile) as f:
    record = f.readlines()

print("Read done.")

with open(outputFile,'w') as f:
    for strRecord in record:
        strItem = strRecord.split()
        chromosome = int(strItem[0])
        if chromosome < 23:
            f.write(strRecord)

print("All done.")