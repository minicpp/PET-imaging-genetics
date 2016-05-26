__author__ = 'mat'
import numpy
import myutility
import sys
import matplotlib

# recordFile = "/home/mat/adni/data/ADNI6y_MasterDB_update.csv"
# genomeFile = "/home/mat/adni/data/ADNI_cluster_01_forward_757LONI.fam"
genomeFile = "D:\\mydoc\\research\\adni\\data\\ADNI_cluster_01_forward_757LONI.fam"
# outFile = "/home/mat/adni/data/ADNI_intersection.txt"
# nofoundFile = "/home/mat/adni/data/ADNI_nofound.txt"
# diagnosisFile = "/home/mat/adni/data/ADNI_diagnosis.txt"
# traceFilePath = "/home/mat/adni/data/"

if len(sys.argv) != 3:
    print("HELP: mergecsv FilePath OutputPathAndFilePrefix")
    exit()
else:
    recordFile = sys.argv[1]
    outFile = sys.argv[2] + "_intersection.txt"
    nofoundFile = sys.argv[2] + "_nofound.txt"
    diagnosisFile = sys.argv[2] + "_diagnosis.txt"
    traceFilePath = sys.argv[2]



# read csv to get all sample records
record = ""
with open(recordFile) as f:
    record = f.readlines()
recordSet = set()
recordLen = len(record)
recordDict = {}
for recStr in record[1:]:
    strArray = recStr.split(',')
    key = strArray[0]
    recordSet.add(key)
    trace = strArray[29]
    globalCortex = strArray[42]
    if not (key in recordDict):
        recordDict[key] = myutility.Individual()
    recordDict[key].addRecord(strArray)
print("We get %d individuals from %d records, each individual has average %f rows." % (
    len(recordSet), recordLen, recordLen / len(recordSet)))

last = 0
for kstr in recordDict.iterkeys():
    rec = recordDict[kstr]
    last += rec.getLastVisit()
avgLastVisit = last / len(recordDict)
print("Average last visit:" + str(avgLastVisit))

# read .fam to get all genome individuals
genomeIndex = ""
with open(genomeFile) as f:
    genomeIndex = f.readlines()
genomeFamilyDict = {}
genomeLen = len(genomeIndex)
genomeSet = set()
for genStr in genomeIndex:
    strArray = genStr.split()
    key = strArray[1]
    genomeSet.add(key)
    genomeFamilyDict[key] = strArray[0]
print("We get %d individuals from .fam file." % len(genomeSet))


# get and save samples, which have genome information
bothSet = recordSet & genomeSet
print("We get %d individuals for both above sets." % len(bothSet))
selectedIndividualDict = {}
last = 0
for selStr in bothSet:
    selectedIndividualDict[selStr] = genomeFamilyDict[selStr]
    last += recordDict[selStr].getLastVisit()
avgLastVisit = last / len(bothSet)
print("Average last visit:" + str(avgLastVisit))


# read allele data (added on 6/11/2015)
alleleFile = "D:\\mydoc\\research\\adni\\program\\adni_win\\v2_trace_1_alleles.csv"
alleleApoeFile = "D:\\mydoc\\research\\adni\\program\\adni_win\\v2_trace_1_apoe_alleles.csv"
with open(alleleApoeFile, 'w') as fapoe:
    with open(alleleFile) as f:
        alleleRecords = f.read().splitlines()
        fapoe.write("%s\tAPOE2\tAPOE1\n" % (alleleRecords[0]))
        for alleleStr in alleleRecords[1:]:
            strArray = alleleStr.split('\t')
            key = strArray[1]
            fapoe.write("%s\t%s\t%s\n" % (alleleStr, recordDict[key].getAPOEA2(), recordDict[key].getAPOEA1()))

with open(outFile, 'w') as f:
    for iid in selectedIndividualDict:
        family = selectedIndividualDict[iid]
        f.write("%s\t%s\t%s\n" % (family, iid,
                                  recordDict[iid].getTraceCount()))
print("Selected %d individuals are written to %s" % (len(selectedIndividualDict), outFile))

# save diagnosis (both simple and categorical)
unaffected = 0
affected = 0
with open(diagnosisFile, 'w') as f:
    f.write("FID\tIID\tbin\tcat\tsex\tage\tweight\trace\n")
    for iid in selectedIndividualDict:
        family = selectedIndividualDict[iid]
        baffect = recordDict[iid].getBinaryDiagnosis()
        f.write("%s\t%s\t%d\t%s\t%s\t%.2f\t%.2f\t%s\n" % (family, iid, baffect,
                                                          recordDict[iid].getCategoricalDiagnosis(),
                                                          recordDict[iid].getSex(),
                                                          recordDict[iid].getFirstVisitAge(),
                                                          recordDict[iid].getWeight(), recordDict[iid].getRace()))
        if baffect == 1:
            unaffected += 1
        else:
            affected += 1
print("Selected %d individuals (affected:%d, unaffected:%d)' binary and categorical phenotypes are written to %s"
      % (len(selectedIndividualDict), affected, unaffected, diagnosisFile))

# write unselected samples (the samples without genome information) to a file
nofoundSet = recordSet - genomeSet
print("We do not find %d individuals in .fam file." % len(nofoundSet))
with open(nofoundFile, 'w') as f:
    for iid in nofoundSet:
        f.write("%s\t%s\n" % (iid, recordDict[iid].getTraceCount()))
print("The unselected %d individuals are written to %s" % (len(nofoundSet), nofoundFile))

# write trace
def writeTrace(traceId):
    listFile = traceFilePath + "_tracer_" + str(traceId) + "_list.txt"
    with open(listFile, 'w') as f:
        for iid in bothSet:
            t = recordDict[iid].traceRecord[traceId]
            if len(t["Tracer"]) == 0:
                continue;
            else:
                f.write("%s\t%s\n" % (selectedIndividualDict[iid], iid))
    print("Write trace file list %s done." % listFile)
    traceFile = traceFilePath + "_tracer_" + str(traceId) + ".txt"
    with open(traceFile, 'w') as f:
        f.write(
            "FID\tIID\tbin\tcat\tObiFronCo\tPreFrontal\tSupFronCo\t"
            "LatTemporal\tMedTemporal\tParietal\tPosPrecuneus\tAntCingulate\tPosCingulate\t"
            "Occipital\tGlobalCortex\tAmygdala\tHippocampus\tCaudate\tCaudate_LR\tPutamen\tPutamen_LR\tPutamen_L\tPutamen_R\t"
            "Putamen_LA\tPutamen_LP\tPutamen_RA\tPutamen_RP\tVST\tVST_LR\tThalamus\tRaphe\tRapheDorsal\tRaphenuclei\tSubstantiaNigra\tMidBrain\tPons\t"
            "Medulla\tCentrumSemiovale\tGrayMatter_VBM8\tWhiteMatter_VBM8\tBrainMask_GM_WM_CSF\tsex\tage\tweight\trace\n")
        for iid in bothSet:
            rec = recordDict[iid]
            t = rec.traceRecord[traceId]
            if len(t["Tracer"]) == 0:
                continue;
            else:
                if traceId == 1:
                    f.write(
                        "%s\t%s\t%d\t%s\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%s\t%.2f\t%.2f\t%s\n"
                        % (selectedIndividualDict[iid],
                           iid,
                           rec.getBinaryDiagnosis(),
                           rec.getCategoricalDiagnosis(),
                           rec.getTrace1ScaleOffset("ObiFronCo"),
                           rec.getTrace1ScaleOffset("PreFrontal"),
                           rec.getTrace1ScaleOffset("SupFronCo"),
                           rec.getTrace1ScaleOffset("LatTemporal"),
                           rec.getTrace1ScaleOffset("MedTemporal"),
                           rec.getTrace1ScaleOffset("Parietal"),
                           rec.getTrace1ScaleOffset("PosPrecuneus"),
                           rec.getTrace1ScaleOffset("AntCingulate"),
                           rec.getTrace1ScaleOffset("PosCingulate"),
                           rec.getTrace1ScaleOffset("Occipital"),
                           rec.getTrace1ScaleOffset("GlobalCortex"),
                           rec.getTrace1ScaleOffset("Amygdala"),
                           rec.getTrace1ScaleOffset("Hippocampus"),
                           rec.getTrace1ScaleOffset("Caudate"),
                           rec.getTrace1ScaleOffset("Caudate_LR"),
                           rec.getTrace1ScaleOffset("Putamen"),
                           rec.getTrace1ScaleOffset("Putamen_LR"),
                           rec.getTrace1ScaleOffset("Putamen_L"),
                           rec.getTrace1ScaleOffset("Putamen_R"),
                           rec.getTrace1ScaleOffset("Putamen_LA"),
                           rec.getTrace1ScaleOffset("Putamen_LP"),
                           rec.getTrace1ScaleOffset("Putamen_RA"),
                           rec.getTrace1ScaleOffset("Putamen_RP"),
                           rec.getTrace1ScaleOffset("VST"),
                           rec.getTrace1ScaleOffset("VST_LR"),
                           rec.getTrace1ScaleOffset("Thalamus"),
                           rec.getTrace1ScaleOffset("Raphe"),
                           rec.getTrace1ScaleOffset("RapheDorsal"),
                           rec.getTrace1ScaleOffset("Raphenuclei"),
                           rec.getTrace1ScaleOffset("SubstantiaNigra"),
                           rec.getTrace1ScaleOffset("MidBrain"),
                           rec.getTrace1ScaleOffset("Pons"),
                           rec.getTrace1ScaleOffset("Medulla"),
                           rec.getTrace1ScaleOffset("CentrumSemiovale"),
                           rec.getTrace1ScaleOffset("GrayMatter_VBM8"),
                           rec.getTrace1ScaleOffset("WhiteMatter_VBM8"),
                           rec.getTrace1ScaleOffset("BrainMask_GM_WM_CSF"),
                           rec.getSex(),
                           # rec.getTraceAverage(traceId,"Age"),
                           rec.getFirstVisitAge(),
                           rec.getTraceAverage(traceId, "Weight"),
                           rec.getRace()))
                else:
                    f.write("%s\t%s\t%d\t%s\t%f\t%f\t%f\t%s\t%.2f\t%.2f\t%s\n"
                            % (selectedIndividualDict[iid],
                               iid,
                               rec.getBinaryDiagnosis(),
                               rec.getCategoricalDiagnosis(),
                               rec.getTraceAverage(traceId, "PosPrecuneus"),
                               rec.getTraceAverage(traceId, "PosCingulate"),
                               rec.getTraceAverage(traceId, "GlobalCortex"),
                               rec.getSex(),
                               # rec.getTraceAverage(traceId,"Age"),
                               rec.getFirstVisitAge(),
                               rec.getTraceAverage(traceId, "Weight"),
                               rec.getRace()))
    print("Write trace file %s done." % traceFile)


writeTrace(1)
writeTrace(2)
writeTrace(3)



# write trace to prepare PCA
pcaFile = traceFilePath + "_tracer_PCA.txt"
with open(pcaFile, 'w') as f:
    f.write(
        "FID\tIID\tbin\tcat\tt1ppSlope\tt1pcSlope\tt1gcSlope\tt1pp\tt1pc\tt1gc\tt2pp\tt2pc\tt2gc\tt3pp\tt3pc\tt3gc\tsex\tage\tweight\trace\n")
    for iid in bothSet:
        rec = recordDict[iid]
        t1ppSlope = rec.getTrace1Slope("PosPrecuneus")
        t1pcSlope = rec.getTrace1Slope("PosCingulate")
        t1gcSlope = rec.getTrace1Slope("GlobalCortex")
        t1pp = rec.getTrace1ScaleOffset("PosPrecuneus")
        t1pc = rec.getTrace1ScaleOffset("PosCingulate")
        t1gc = rec.getTrace1ScaleOffset("GlobalCortex")
        t = rec.traceRecord[2]
        t2ppStr = "NaN"
        t2pcStr = "NaN"
        t2gcStr = "NaN"
        if len(t["Tracer"]) > 0:
            t2pp = rec.getTraceAverage(2, "PosPrecuneus")
            t2pc = rec.getTraceAverage(2, "PosCingulate")
            t2gc = rec.getTraceAverage(2, "GlobalCortex")
            t2ppStr = "{:f}".format(t2pp)
            t2pcStr = "{:f}".format(t2pc)
            t2gcStr = "{:f}".format(t2gc)
        t = rec.traceRecord[3]
        t3ppStr = "NaN"
        t3pcStr = "NaN"
        t3gcStr = "NaN"
        if len(t["Tracer"]) > 0:
            t3pp = rec.getTraceAverage(3, "PosPrecuneus")
            t3pc = rec.getTraceAverage(3, "PosCingulate")
            t3gc = rec.getTraceAverage(3, "GlobalCortex")
            t3ppStr = "{:f}".format(t3pp)
            t3pcStr = "{:f}".format(t3pc)
            t3gcStr = "{:f}".format(t3gc)
        f.write("%s\t%s\t%d\t%s\t%f\t%f\t%f\t%f\t%f\t%f\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%.2f\t%.2f\t%s\n" %
                (
                    selectedIndividualDict[iid],
                    iid,
                    rec.getBinaryDiagnosis(),
                    rec.getCategoricalDiagnosis(),
                    t1ppSlope,
                    t1pcSlope,
                    t1gcSlope,
                    t1pp, t1pc, t1gc,
                    t2ppStr, t2pcStr, t2gcStr,
                    t3ppStr, t3pcStr, t3gcStr,
                    rec.getSex(),
                    # rec.getAge(),
                    rec.getFirstVisitAge(),
                    rec.getWeight(),
                    rec.getRace()
                ))
print("Write preliminary PCA file %s done." % pcaFile)

print("All done")
