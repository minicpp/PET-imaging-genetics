__author__ = 'wynter'

import sys
import csv

# exclude sex chromosome and add apoe
mapFile = "D:\\mydoc\\research\\adni2\\data\\adni2.map"
outMapfile = "D:\\mydoc\\research\\adni2\\data\\adni2_nosex.map"
genomeFile = "D:\\mydoc\\research\\adni2\\data\\adni2.ped"
newGenomeFile = "D:\\mydoc\\research\\adni2\\data\\adni2_nosex.ped"

apoeFile = "D:\\mydoc\\research\\adni2\\data\\APOERES.csv"



with open(outMapfile, 'w') as fout:
    with open(mapFile) as fin:
        record = fin.readlines()
        for r in record:
            rArray = r.split('\t')
            cid = int(rArray[0])
            if cid < 23:
                fout.write(r)
            else:
                pos = -1*int(rArray[-1])
                fout.write(rArray[0]+'\t'+rArray[1]+'\t'+rArray[2]+'\t'+str(pos)+'\n')
    fout.write('19\trs429358\t0\t44908684\n')
    fout.write( '19\trs7412\t0\t44908822\n')

with open(apoeFile, 'r') as f:
    reader = csv.reader(f)
    apoeList = list(reader)

apoeDict = {}
for item in apoeList[1:]:
    key = int(item[2])
    if not (key in apoeDict):
        apoeDict[key] = [item[8], item[9]]

with open(newGenomeFile, 'w') as fout:
    with open(genomeFile) as fin:
        record = fin.read().splitlines()
        for r in record:
            recPrefix = r[:32]
            strArray = recPrefix.split('\t')
            key = strArray[1]
            key = key.split('_')
            key = int(key[2])
            apoeArray = apoeDict[key]
            a1 = apoeArray[0]
            a2 = apoeArray[1]
            # excahnge for minor and major allele
            rs429358 = ""
            rs7412 = ""
            if a2 == '1':
                rs429358 = 'C'
                rs7412 = 'T'
            elif a2 == '2':
                rs429358 = 'T'
                rs7412 = 'T'
            elif a2 == '3':
                rs429358 = 'T'
                rs7412 = 'C'
            elif a2 == '4':
                rs429358 = 'C'
                rs7412 = 'C'

            if a1 == '1':
                rs429358 += ' C'
                rs7412 += ' T'
            elif a1 == '2':
                rs429358 += ' T'
                rs7412 += ' T'
            elif a1 == '3':
                rs429358 += ' T'
                rs7412 += ' C'
            elif a1 == '4':
                rs429358 += ' C'
                rs7412 += ' C'
            r += '\t'+rs429358+'\t'+rs7412+'\n'
            fout.write(r)


# record = ""
# with open(recordFile) as f:
#     record = f.readlines()
# recordLen = len(record)
# recordDict = {}
# for recStr in

# record[1:]:
#     strArray = recStr.split(',')
#     key = strArray[0]
#     if not (key in recordDict):
#         recordDict[key] = myutility.Individual()
#     recordDict[key].addRecord(strArray)
#     iv = recordDict[key]
#
# print("We get %d individuals from %d records, each individual has average %f rows." % (
#     len(recordDict), recordLen, recordLen / len(recordDict)))
#
# record = ""
# with open(genomeFile) as f:
#     record = f.read().splitlines()
#
# newRecord=[];
# for recStr in record:
#     recPrefix = recStr[:32]
#     strArray = recPrefix.split('\t')
#     key = strArray[1]
#     iv = recordDict[key]
#     assert isinstance(iv, myutility.Individual)
#     a1 = iv.getAPOEA1()
#     a2 = iv.getAPOEA2()
#     # excahnge for minor and major allele
#     rs429358 = ""
#     rs7412 = ""
#     if a2 == '1':
#         rs429358 = 'C'
#         rs7412 = 'T'
#     elif a2 == '2':
#         rs429358 = 'T'
#         rs7412 = 'T'
#     elif a2 == '3':
#         rs429358 = 'T'
#         rs7412 = 'C'
#     elif a2 == '4':
#         rs429358 = 'C'
#         rs7412 = 'C'
#
#     if a1 == '1':
#         rs429358 += ' C'
#         rs7412 += ' T'
#     elif a1 == '2':
#         rs429358 += ' T'
#         rs7412 += ' T'
#     elif a1 == '3':
#         rs429358 += ' T'
#         rs7412 += ' C'
#     elif a1 == '4':
#         rs429358 += ' C'
#         rs7412 += ' C'
#     recStr += '\t'+rs429358+'\t'+rs7412+'\n'
#     newRecord.append(recStr)
#
# with open(newGenomeFile, 'w') as f:
#         f.write(''.join(newRecord))
#
# print('done.')