__author__ = 'wynter'

import myutility
import sys

# this file add apoe to genetic dataset (windows platform)

# we first read csv file, and get apoe information for each subject
#then we add apoe info to genetic dataset

recordFile = "D:\\mydoc\\research\\adni\\apoe\\ADNI6y_MasterDB_VBM8.csv"
genomeFile = "D:\\mydoc\\research\\adni\\data\\plink\\ADNI_filt_nosex_v2_tracer1.ped"
newGenomeFile = "D:\\mydoc\\research\\adni\\data\\plink\\ADNI_filt_nosex_v2_tracer1_update.ped"

record = ""
with open(recordFile) as f:
    record = f.readlines()
recordLen = len(record)
recordDict = {}
for recStr in record[1:]:
    strArray = recStr.split(',')
    key = strArray[0]
    if not (key in recordDict):
        recordDict[key] = myutility.Individual()
    recordDict[key].addRecord(strArray)
    iv = recordDict[key]

print("We get %d individuals from %d records, each individual has average %f rows." % (
    len(recordDict), recordLen, recordLen / len(recordDict)))

record = ""
with open(genomeFile) as f:
    record = f.read().splitlines()

newRecord=[];
for recStr in record:
    recPrefix = recStr[:32]
    strArray = recPrefix.split('\t')
    key = strArray[1]
    iv = recordDict[key]
    assert isinstance(iv, myutility.Individual)
    a1 = iv.getAPOEA1()
    a2 = iv.getAPOEA2()
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
    recStr += '\t'+rs429358+'\t'+rs7412+'\n'
    newRecord.append(recStr)

with open(newGenomeFile, 'w') as f:
        f.write(''.join(newRecord))

print('done.')