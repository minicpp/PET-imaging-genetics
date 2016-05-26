__author__ = 'mat'

import os
import sys
import subprocess

############parameters
bimFile = "/home/mat/adni/data/plink/ADNI_filt_nosex.bim"
bFile = "/home/mat/adni/data/plink/ADNI_filt_nosex"
traceFile ="/home/mat/adni/data/v1_trace_1.txt"
inputCSV = "/home/mat/adni/data/ADNI6y_MasterDB_v2.csv"
outSNPPath = "/home/mat/adni/data/snp/"
outSNPSummary = "/home/mat/adni/data/MasterDB_SnpSummary.csv"
outMaster = "/home/mat/adni/data/ADNI6y_MasterDB_v2_snp.csv"
(fileName, fileExt) = os.path.splitext(traceFile)
topNFile = fileName+"_list.txt"
traceListFile = topNFile

snpGroup = ["rs1501228", "rs12565755", "rs12408850",
            "rs1946867", "rs3905886","rs9951577",
            "rs4149286", "rs343248", "rs4149284"]

FNULL = open(os.devnull,'w')
count = 0
for i in snpGroup:
    commandStr = "plink2 --bfile %s --keep %s --snp %s  -recodeA --out %s%s" \
                 % (bFile, traceListFile, i, outSNPPath, i)
    commandStrArray = commandStr.split()
    subprocess.call(commandStrArray,stdout=FNULL)
    count += 1
    print("[%d/%d] Generate SNP %s done." % (count, len(snpGroup), i) )

bimMap={}
with open(bimFile) as f:
    record = f.readlines()
    for r in record:
        s = r.split()
        bimMap[s[1]] = s

rawRecord={}
for snp in snpGroup:
    snpfile = outSNPPath + snp +".raw"
    indDic = {}
    with open(snpfile) as f:
        record = f.readlines()
        for i in record[1:]:
            sp = i.split()
            indDic[sp[1]] = sp
    rawRecord[snp] = indDic

#generage snp summary
with open(outSNPSummary,'w') as f:
    f.write("SNP, Chromosome, Base Position, Allele minor, Allele major\n")
    for i in snpGroup:
        info = bimMap[i]
        chromosome = info[0]
        pos = info[3]
        minAllele = info[4]
        majAllele = info[5]
        f.write("%s, %s, %s, %s, %s\n" % (i,chromosome,pos,minAllele,majAllele))
print("Summary file %s done." % outSNPSummary)

#attach snp information
record = []
with open(inputCSV) as f:
    record = f.readlines()
    #attach header
    header= record[0].strip()
    for snp in snpGroup:
        header += ","+snp+" A1, "+snp+" A2"
    record[0] = header + "\n"
    index = 1
    for r in record[1:]:
        s = r.split(',')


        sid = str.strip(s[0])
        attachInfo = ""
        for snp in snpGroup:
            ia1="NA"
            ia2="NA"
            if sid in rawRecord[snp]:
                p = rawRecord[snp][sid]
                alleleInfo = bimMap[snp]
                a1 = alleleInfo[4];
                a2 = alleleInfo[5];
                individualAllele = p[-1]
                if individualAllele == '0':
                    ia1 = ia2 = a2
                elif individualAllele == '1':
                    ia1 = a1
                    ia2 = a2
                elif individualAllele == '2':
                    ia1 = ia2 = a1
            attachInfo +=", %s, %s" % (ia1,ia2)
            r = r.strip()
        record[index] = r +attachInfo + "\n"
        index += 1


with open(outMaster,'w') as f:
    f.writelines(record)
print("Write file %s done." % outMaster)