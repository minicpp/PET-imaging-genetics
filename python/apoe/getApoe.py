__author__ = 'mat'
import numpy
import myutility
import sys
import matplotlib

recordFile = "/home/mat/adni/apoe/ADNI6y_MasterDB_VBM8.csv"
genomeFile = "/home/mat/adni/data/ADNI_cluster_01_forward_757LONI.fam"
outFile = "/home/mat/adni/apoe/ADNI_apoe.csv"
traceFilePath = "/home/mat/adni/apoe/"
bFilterByGenetic = False

# read csv to get all sample records
record = ""
with open(recordFile) as f:
    record = f.readlines()
recordSet = set()
recordLen = len(record)
recordDict = {}
apoeSet = set()
for recStr in record[1:]:
    strArray = recStr.split(',')
    key = strArray[0]
    recordSet.add(key)
    trace = strArray[29]
    globalCortex = strArray[42]
    if not (key in recordDict):
        recordDict[key] = myutility.Individual()
    recordDict[key].addRecord(strArray)
    iv = recordDict[key]
    assert isinstance(iv, myutility.Individual)
    a1=iv.getAPOEA1()
    a2=iv.getAPOEA2()
    apoeStr = a2+a1
    if apoeStr not in apoeSet:
        apoeSet.add(apoeStr)
print("We get %d individuals from %d records, each individual has average %f rows." % (
    len(recordSet), recordLen, recordLen / len(recordSet)))

print("There are %d different APOE pairs:" % len(apoeSet))
for ap in apoeSet:
    print("\t"+ap)


# read .fam to get all genome individuals
genomeIndex = ""
genomeSet = set()
bothSet = set()
if bFilterByGenetic is True:
    with open(genomeFile) as f:
        genomeIndex = f.readlines()
    genomeLen = len(genomeIndex)
    for genStr in genomeIndex:
        strArray = genStr.split()
        key = strArray[1]
        genomeSet.add(key)
    print("We get %d individuals from .fam file." % len(genomeSet))
    bothSet = recordSet & genomeSet
else:
    print("Skip filter based on genetic records")
    bothSet = recordSet

# get and save samples, which have genome information


print("We get %d individuals after filter." % len(bothSet))

# save diagnosis (both simple and categorical)
unaffected = 0
affected = 0
with open(outFile, 'w') as f:
    f.write("IID,bin,APOE,cat,sex,age,weight,race\n")
    for iid in bothSet:
        baffect = recordDict[iid].getBinaryDiagnosis()
        f.write("%s,%d,%s,%s,%s,%f,%f,%s\n" % (iid, baffect,
                                               recordDict[iid].getAPOEA1() + recordDict[iid].getAPOEA2(),
                                               recordDict[iid].getCategoricalDiagnosis(),
                                               recordDict[iid].getSex(),
                                               recordDict[iid].getAge(),
                                               recordDict[iid].getWeight(),
                                               recordDict[iid].getRace()))
        if baffect == 1:
            unaffected += 1
        else:
            affected += 1
print("Selected %d individuals (affected:%d, unaffected:%d)' binary and categorical phenotypes are written to %s"
      % (len(bothSet), affected, unaffected, outFile))

# write trace 1 2 3
def writeTrace(traceId):
    traceFile = traceFilePath+"apoe_trace_"+str(traceId)+".csv"
    with open(traceFile,'w') as f:
        f.write("IID,bin,apoe,cat,pp,pc,gc,sex,age,weight,race\n")
        for iid in bothSet:
            rec = recordDict[iid]
            t = rec.traceRecord[traceId]
            if len(t["Tracer"]) == 0:
                continue;
            else:
                if traceId == 1:
                    f.write( "%s,%d,%s,%s,%f,%f,%f,%s,%.2f,%.2f,%s\n"
                             % (iid,
                                rec.getBinaryDiagnosis(),
                                recordDict[iid].getAPOEA1() + recordDict[iid].getAPOEA2(),
                                rec.getCategoricalDiagnosis(),
                                rec.getTrace1ScaleOffset("PosPrecuneus"),
                                rec.getTrace1ScaleOffset("PosCingulate"),
                                rec.getTrace1ScaleOffset("GlobalCortex"),
                                rec.getSex(),
                                rec.getTraceAverage(traceId,"Age"),
                                rec.getTraceAverage(traceId, "Weight"),
                                rec.getRace()) )
                else:
                    f.write( "%s,%d,%s,%s,%f,%f,%f,%s,%.2f,%.2f,%s\n"
                             % (iid,
                                rec.getBinaryDiagnosis(),
                                recordDict[iid].getAPOEA1() + recordDict[iid].getAPOEA2(),
                                rec.getCategoricalDiagnosis(),
                                rec.getTraceAverage(traceId,"PosPrecuneus"),
                                rec.getTraceAverage(traceId,"PosCingulate"),
                                rec.getTraceAverage(traceId,"GlobalCortex"),
                                rec.getSex(),
                                rec.getTraceAverage(traceId,"Age"),
                                rec.getTraceAverage(traceId, "Weight"),
                                rec.getRace()))
    print("Write trace file %s done." % traceFile)
writeTrace(1)
writeTrace(2)
writeTrace(3)

print("All done")