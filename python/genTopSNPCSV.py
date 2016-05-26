__author__ = 'mat'
import os
import sys
import numpy

############parameters
bimFile = "/home/mat/adni/data/plink/ADNI_filt_nosex.bim"
traceFile ="/home/mat/adni/data/v1_trace_1.txt"
sortFile ="/home/mat/adni/data/out/gwas_v1_trace_1.gc.assoc.sort.linear"
rawFilePath = "/home/mat/adni/data/v1_trace1/snp_gc"
N = 10
traceID = "1"
phenotype="gc"


if len(sys.argv) != 8:
    print("HELP: getTopSNPCSV bimFile traceFile sortFile rawFilePath N traceID phenotype")
    #exit()
else:
    bimFile = sys.argv[1]
    traceFile = sys.argv[2]
    sortFile = sys.argv[3]
    rawFilePath = sys.argv[4]
    N = int(sys.argv[5])
    traceID = sys.argv[6]
    phenotype = sys.argv[7]

roi = phenotype
if phenotype=="gc":
    roi = "GlobalCortex"
elif phenotype =="pc":
    roi = "PosCingulate"
elif phenotype == "pp":
    roi = "PosPrecuneus"


#########
(pathPath,extPath) = os.path.splitext(sortFile)
if extPath == ".linear":
    rawFilePath += "/linear/"
else:
    rawFilePath += "/assoc/"
outputCSV = rawFilePath+"res.csv"
outputMeanCSV = "/home/mat/adni/data/mean.csv"
#print all parameters
print("bimFile = %s" % bimFile)
print("traceFile = %s" % traceFile)
print("sortFile = %s" % sortFile)
print("rawFilePath = %s" % rawFilePath)
print("N = %d" % N)
print("traceID = %s" % traceID)
print("outputCSV = %s" % outputCSV)

#read bim file as map
bimMap={}
with open(bimFile) as f:
    record = f.readlines()
    for r in record:
        s = r.split()
        bimMap[s[1]] = s

#read trace file
traceMap=[]
with open(traceFile) as f:
    record = f.readlines()
    for r in record[1:]:
        s = r.split()
        s[6] = float(s[6])
        s[4] = float(s[4])
        s[5] = float(s[5])
        traceMap += [s]
#sort traceMap by phonetype value
sortIndex = 0
if phenotype == "gc":
    sortIndex = 6
elif phenotype == "pc":
    sortIndex = 5
elif phenotype == "pp":
    sortIndex = 4

traceMap = sorted(traceMap, key=lambda traceMap:traceMap[sortIndex])
#read sort file
sortRec = []
bCov = False
with open(sortFile) as f:
    record = f.readlines()
    rold = ""
    count = 0
    for r in record[1:]:
        s = r.split()
        if len(rold) == 0 or rold != s[1]:
            count += 1
            if count > N:
                break;
            rold = s[1]
            sortRec += [s]
        elif rold==s[1]:
            #covariate
            sortRec[-1] += [s[4],s[6]]
            bCov = True

#read raw file
rawRecord={}
for r in sortRec:
    snp = r[1]
    snpfile = rawFilePath + snp +".raw"
    indDic = {}
    with open(snpfile) as f:
        record = f.readlines()
        for i in record[1:]:
            sp = i.split()
            indDic[sp[1]] = sp
    rawRecord[snp] = indDic

#get csv file
header = "Subject ID, Diagnosis, Trace, ROI, ROI Value, SNP, Chromosome, Base Position, Allele, Allele 1, Allele 2, P, Beta, SE, Age, Age Beta\n"

class SNPClass:
    def __init__(self):
        self.A1Count = 0
        self.A2Count = 0
        self.A1=""
        self.A2=""
        self.snp = ""
        self.A2A2Roi=[]
        self.A1A2Roi=[]
        self.A1A1Roi=[]
        self.covar = ""
        self.SE = ""
        self.P = ""
        self.Beta = ""

snpClassArray=[]
with open(outputCSV,'w') as f:
    f.write(header)
    for j in sortRec:
        snpObject = SNPClass()
        snpClassArray += [snpObject]
        snpObject.snp = j[1]
        snpObject.A1 = bimMap[snpObject.snp][4];
        snpObject.A2 = bimMap[snpObject.snp][5];
        snpObject.P = j[8]

        if bCov == True:
            snpObject.Beta = j[6]
            snpObject.SE = "NA"

        else:
            snpObject.SE = j[5]
            snpObject.Beta = j[4]
        if len(j) > 9:
            snpObject.covar = "Age"
        else:
            snpObject.covar = "NA"
        for r in traceMap:
            sid = r[1]
            diagnosis = r[3]
            snp = j[1]
            chromosome = j[0]
            pos = j[2]
            alleleInfo = bimMap[snp]
            a1 = alleleInfo[4];
            a2 = alleleInfo[5];
            alleleStr = "[%s/%s]" % (a1,a2)
            individualAllele = rawRecord[snp][sid][-1]
            roiValue = rawRecord[snp][sid][-2]
            ia1="NA"
            ia2="NA"
            if individualAllele == '0':
                ia1 = ia2 = a2
                snpObject.A2Count += 2
                snpObject.A2A2Roi += [float(roiValue)]
            elif individualAllele == '1':
                ia1 = a1
                ia2 = a2
                snpObject.A1Count += 1
                snpObject.A2Count += 1
                snpObject.A1A2Roi += [float(roiValue)]
            elif individualAllele == '2':
                ia1 = ia2 = a1
                snpObject.A1Count += 1
                snpObject.A1A1Roi += [float(roiValue)]
            p = j[8]
            if bCov == True:
                beta = j[6]
                sError = "NA"
            else:
                sError = j[5]
                beta = j[4]
            age = r[-3]
            if len(j) > 9: #there is additional information attached
                age_beta = j[-1]
            else:
                age_beta = ""
            f.write(sid+","+diagnosis+","+traceID+","+roi+","+roiValue+","+snp+","+chromosome+","
                    +pos+","+alleleStr+","+ia1+","+ia2+","+p+","+beta+","+sError+","+age+","+age_beta+"\n")

meanHeader = "Time,Trace, Covar, SNP, ROI, P, Beta, SE, Allele 1, Allele 2, A1A1=2, meanROI(A1A1),A1A2=1, meanROI(A1A2),A2A2=0,meanROI(A2A2)," \
             " Counts(A1A1), Counts(A1A2), Counts(A2A2), Counts(A1), Counts(A2), Freq(A1), Freq(A2), totalSubjects, RawFilePath\n"

import os.path
import time
res = os.path.isfile(outputMeanCSV)
openText = ""
if res == False:
    with open(outputMeanCSV,'w') as f:
        f.write(meanHeader)

with open(outputMeanCSV,'a') as f:
    f.write("\n")
    strTime = time.strftime("%H:%M:%S")
    A1A1Roi = "NA"
    A1A2Roi = "NA"
    A2A2Roi = "NA"
    freqA1 = "NA"
    freqA2 = "NA"
    for i in snpClassArray:
        if len(i.A1A1Roi) > 0:
            #A1A1Roi = str(sum(i.A1A1Roi)/len(i.A1A1Roi))
            A1A1Roi = str(numpy.mean(i.A1A1Roi))
        if len(i.A1A2Roi) > 0:
            #A1A2Roi = str(sum(i.A1A2Roi)/len(i.A1A2Roi))
            A1A2Roi = str(numpy.mean(i.A1A2Roi))
        if len(i.A2A2Roi) > 0:
            #A2A2Roi = str(sum(i.A2A2Roi)/len(i.A2A2Roi))
            A2A2Roi = str(numpy.mean(i.A2A2Roi))
        if i.A1Count + i.A2Count != 0:
            freqA1 = str(i.A1Count/(i.A1Count+i.A2Count))
            freqA2 = str(i.A2Count/(i.A1Count+i.A2Count))
        f.write(strTime + "," +traceID+","+i.covar+"," + i.snp + "," + roi +"," +
             i.P +"," +i.Beta + "," + i.SE + "," + i.A1+"," + i.A2+"," +
             i.A1+i.A1+","+A1A1Roi + "," + i.A1+i.A2+","+A1A2Roi  +","+
             i.A2+i.A2+","+A2A2Roi + "," + str(len(i.A1A1Roi)) +"," + str(len(i.A1A2Roi)) + "," +
             str(len(i.A2A2Roi)) +"," + str(i.A1Count) + "," + str(i.A2Count) + "," +
               freqA1     +"," + freqA2
                     +"," + str(len(traceMap)) + ","+rawFilePath+ "\n")

print("Write file %s done" % outputMeanCSV)

print("All done.")