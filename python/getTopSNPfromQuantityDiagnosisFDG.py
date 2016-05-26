__author__ = 'wynter'
# sort file by p-value for all qassoc in a folder

import sys
from os import listdir
from os.path import isfile, join

topN = 100
qassocFolderPath = "D:\\mydoc\\research\\adni\\data\\qout"
outputFile = "D:\\mydoc\\research\\adni\\data\\qout\\top"
onlyfiles = [f for f in listdir(qassocFolderPath) if isfile(join(qassocFolderPath,f)) and f.endswith('.sort')]
snpMap = {}

def readSortedFile(qassocFile):
    fileHeader = ''
    with open(join(qassocFolderPath, qassocFile), 'r') as f:
        regionName = qassocFile.split('.')[-3]
        line = f.next().strip() #skip header
        for i in range(topN):
            line = f.next().strip()
            str = " ".join(line.split())
            elements = str.split()
            snpName = elements[1]
            item = [regionName, i, line, elements]
            if not snpMap.has_key(snpName):
                snpMap[snpName] = [item]
            else:
                snpMap[snpName].append(item)

print 'total file size:%d' % len(onlyfiles)
for f in onlyfiles:
    readSortedFile(f)

topMap = sorted(snpMap.keys(), key=lambda x: -1 * len(snpMap[x]))
for snp in topMap:
    print "snp name: %s, support number:%d/%d" % ( snp, len(snpMap[snp]), len(onlyfiles))


with open(outputFile+str(topN)+".txt", 'w') as f:
    f.write("SNP, SUPPORT_NUMBER, ")
    voxMap = {"ObiFronCo":'', "PreFrontal":'', "SupFronCo":'', "LatTemporal":'',
                "MedTemporal":'', "Parietal":'', "PosPrecuneus":'', "AntCingulate":'', "PosCingulate":'',
                "Occipital":'', "GlobalCortex":'', "Amygdala":'', "Hippocampus":'', "Caudate":'', "Caudate_LR":'', "Putamen":'', "Putamen_LR":'', "Putamen_L":'', "Putamen_R":'',
                "Putamen_LA":'', "Putamen_LP":'', "Putamen_RA":'',"Putamen_RP":'', "VST":'', "VST_LR":'', "Thalamus":'',
                "Raphe":'', "RapheDorsal":'', "Raphenuclei":'', "SubstantiaNigra":'', "MidBrain":'', "Pons":'',
                "Medulla":'', "CentrumSemiovale":'', "GrayMatter_VBM8":'', "WhiteMatter_VBM8":'', "BrainMask_GM_WM_CSF":''}
    for keyStr in voxMap.keys():
        f.write(keyStr+', ')
    f.write('\n')
    for snp in topMap:

        voxMap = {"ObiFronCo":'', "PreFrontal":'', "SupFronCo":'', "LatTemporal":'',
                "MedTemporal":'', "Parietal":'', "PosPrecuneus":'', "AntCingulate":'', "PosCingulate":'',
                "Occipital":'', "GlobalCortex":'', "Amygdala":'', "Hippocampus":'', "Caudate":'', "Caudate_LR":'', "Putamen":'', "Putamen_LR":'', "Putamen_L":'', "Putamen_R":'',
                "Putamen_LA":'', "Putamen_LP":'', "Putamen_RA":'',"Putamen_RP":'', "VST":'', "VST_LR":'', "Thalamus":'',
                "Raphe":'', "RapheDorsal":'', "Raphenuclei":'', "SubstantiaNigra":'', "MidBrain":'', "Pons":'',
                "Medulla":'', "CentrumSemiovale":'', "GrayMatter_VBM8":'', "WhiteMatter_VBM8":'', "BrainMask_GM_WM_CSF":''}

        region = ''
        snpItem = snpMap[snp]
        for reg in snpItem:
            region = reg[0]
            voxMap[region]= str(reg[3][-1])
        f.write("%s, %d/%d, " % (snp, len(snpMap[snp]), len(onlyfiles)))
        for keyStr in voxMap.keys():
            f.write(voxMap[keyStr]+", ")
        f.write('\n')

print('All done.')