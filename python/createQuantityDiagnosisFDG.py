import myutility
import sys

genomeFile = "D:\\mydoc\\research\\adni\\data\\ADNI_cluster_01_forward_757LONI.fam"

if len(sys.argv) != 3:
    print("HELP: mergecsv FilePath OutputPathAndFilePrefix")
    exit()
else:
    recordFile = sys.argv[1]
    nofoundFile = sys.argv[2] + "_nofound.txt"
    diagnosisFile = sys.argv[2] + "_quantity_fdg_diagnosis.txt"

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


def writeTrace():
    traceId = 1
    listFile = diagnosisFile
    with open(listFile, 'w') as f:
        for iid in bothSet:
            t = recordDict[iid].traceRecord[traceId]
            if len(t["Tracer"]) == 0:
                continue
            else:
                f.write("%s\t%s\n" % (selectedIndividualDict[iid], iid))
    print("Write trace file list %s done." % listFile)
    traceFile = diagnosisFile
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
                continue
            else:
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

    print("Write trace file %s done." % traceFile)

writeTrace()

# generate sh script
traceMap = ["ObiFronCo", "PreFrontal", "SupFronCo", "LatTemporal",
                "MedTemporal", "Parietal", "PosPrecuneus", "AntCingulate", "PosCingulate",
                "Occipital", "GlobalCortex", "Amygdala", "Hippocampus", "Caudate", "Caudate_LR", "Putamen", "Putamen_LR", "Putamen_L", "Putamen_R",
                "Putamen_LA", "Putamen_LP", "Putamen_RA","Putamen_RP", "VST", "VST_LR", "Thalamus",
                "Raphe", "RapheDorsal", "Raphenuclei", "SubstantiaNigra", "MidBrain", "Pons",
                "Medulla", "CentrumSemiovale", "GrayMatter_VBM8", "WhiteMatter_VBM8", "BrainMask_GM_WM_CSF"]
with open('runQuantityScript.sh', 'w') as f:
    for str in traceMap:
        f.write('plink2 --bfile plink/ADNI_filt_nosex_v2_tracer1_update --keep v2_trace_1_list.txt -assoc --pheno test_quantity_fdg_diagnosis.txt --pheno-name %s '
                '--covar test_quantity_fdg_diagnosis.txt --out qout/quantity_FDG.%s\n' % (str,str))
print('done')