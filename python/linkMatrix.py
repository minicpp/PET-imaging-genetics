__author__ = 'mat'
filePath = "/home/mat/adni/data/out"
outputCSV = "/home/mat/adni/data/out/matrix.csv"
import os
N = 10
fileCollector=[]
for file in os.listdir(filePath):
    res = file.find("sort")
    if res != -1:
        fileCollector += [file]

print(len(fileCollector))

snpMap = {}
count = 0
fileMap = {}
for file in fileCollector:
    fileMap[file]={}
for file in fileCollector:
    with open(filePath+"/"+file) as f:
        r = f.readlines()
        oldsnp = ""
        lines = 1
        for i in r[1:]:
            s = i.split()
            if oldsnp == "":
                oldsnp = s[1]
            elif oldsnp == s[1]:
                lines += 1
            else:
                break;
        totalcount = lines*N
        for i in range(1,totalcount+1):
            if (i-1) % lines == 0:
                s = r[i].split()
                snp = s[1]
                if snp in snpMap:
                    snpMap[snp] += 1
                else:
                    snpMap[snp] = 1
                if snp in fileMap[file]:
                    fileMap[file][snp] += 1
                else:
                    fileMap[file][snp] = 1

snpArray = snpMap.values()
maxv = max(snpArray)

with open(outputCSV,'w') as f:
    f.write("SNP,count")
    for i in fileMap:
        f.write(","+i)
    f.write("\n")
    for i in snpMap:
        f.write(i+","+str(snpMap[i]))
        for j in fileMap:
            if i in fileMap[j]:
                f.write(",1")
            else:
                f.write(",")
        f.write("\n")


print("done, the maximal counts is %d" % maxv)