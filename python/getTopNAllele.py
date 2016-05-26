__author__ = 'mat'

#input 1: trace list
#input 2: trace file
#input 3: gwas file
#input 4: top N
#input 5: plinkfile prefix

#input 5: raw file folder
#output : sorted top N gwas file
import os
import sys

bFile = "/home/mat/adni/data/plink/ADNI_filt_nosex"
traceFile = "/home/mat/adni/data/v1_trace_3.txt"
gwasFile = "/home/mat/adni/data/out/gwas_v1_trace_3.gc.qassoc"
phenoName = "gc"
N = 10
outSNPPath = "/home/mat/adni/data/snp_v1_gc/assoc/"


if len(sys.argv) != 7:
    print("HELP: getTopNAllele PlineFilePrefix traceFile gwasFile phenoName topN outSNPPath")
    exit()
else:
    bFile = sys.argv[1]
    traceFile = sys.argv[2]
    gwasFile = sys.argv[3]
    phenoName = sys.argv[4]
    N = int(sys.argv[5])
    outSNPPath = sys.argv[6]

(fileName, fileExt) = os.path.splitext(traceFile)
topNFile = fileName+"_list.txt"
traceListFile = topNFile

print("Parameters")
print("bFile=%s" % bFile)
print("traceFile=%s" % traceFile)
print("gwasFile=%s" % gwasFile)
print("phenoName=%s" % phenoName)
print("N=%d" % N)
print("outSNPPath=%s" % outSNPPath)

gwas = ""
with open(gwasFile) as f:
    record = f.readlines()
print("read %d records done." % (len(record)-1) )
#convert records to array records
gwasArray = []
for i in range(1,len(record)):
    rArray = record[i].split()
    rArray[0] = i
    if rArray[-1] == 'NA':
        rArray[-1] = 1.0
    else:
        rArray[-1] = float(rArray[-1])
    gwasArray += [rArray]
print("convert record to array done.")

#check number of covars in the file
count = 1
snp = ""
for i in gwasArray:
    if len(snp)==0:
        snp = i[1]
    elif snp == i[1]:
        count += 1
    else:
        break;
print("Covariate number is %d" % count)
#put records into dictionary
gwasFactor = []
#gwasDict = {}
maxi = len(gwasArray)/count
for i in range(int(maxi)):
    j = gwasArray[i*count]
#    gwasDict[j[1]] = j[0]
    gwasFactor += [ [j[0],j[1],j[-1]] ]
print("mapping %d record done." % maxi)
#sort by p-value
sortedGwasFactor = sorted(gwasFactor, key=lambda gwasFactor:gwasFactor[-1])
print("sort %d record done." % len(gwasFactor))

#write sorted to file

(fileName, fileExt) = os.path.splitext(gwasFile)
topNFile = fileName+".sort"+fileExt
with open(topNFile,'w') as f:
    f.write(record[0])
    for i in sortedGwasFactor:
        index = i[0]
        for j in range(count):
            rindex = index + j
            f.write(record[rindex])
print("Write %d to %s done." % (len(sortedGwasFactor), topNFile) )

import subprocess
#get individuals' snp for their top N snp
commandStr = "";
FNULL = open(os.devnull,'w')
for i in range(N):
    commandStr = "plink2 --bfile %s --keep %s --snp %s --pheno %s --pheno-name %s -recodeA --out %s%s" \
                 % (bFile, traceListFile, sortedGwasFactor[i][1], traceFile, phenoName, outSNPPath, sortedGwasFactor[i][1] )
    commandStrArray = commandStr.split()
    subprocess.call(commandStrArray,stdout=FNULL)
    print("[%d/%d] Generate SNP %s done." % ((i+1), N ,  sortedGwasFactor[i][1]) )

print("Generate individual SNP files done at %s." % outSNPPath)