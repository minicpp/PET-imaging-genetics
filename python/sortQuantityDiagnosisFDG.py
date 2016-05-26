__author__ = 'wynter'
# sort file by p-value for all qassoc in a folder

import sys
from os import listdir
from os.path import isfile, join

qassocFolderPath = "D:\\mydoc\\research\\adni\\data\\qout"
onlyfiles = [f for f in listdir(qassocFolderPath) if isfile(join(qassocFolderPath,f)) and f.endswith('.qassoc')]


def sortByPValue(qassocFile):
    fileHeader=''
    with open(join(qassocFolderPath, qassocFile), 'r') as f:
        record = f.readlines()
        recordArray =[]
        fileHeader = record[0]
        for str in record[1:]:
            str = " ".join(str.split())
            str = str.split()
            recordArray.append(float(str[-1]))
        sortedIndex = sorted(range(len(recordArray)), key=lambda x:recordArray[x])

        with open(join(qassocFolderPath, qassocFile+'.sort'), 'w') as fs:
            fs.write(fileHeader)
            for i in sortedIndex:
                fs.write(record[i+1])
            print('File: '+qassocFile+' is done.')



for f in onlyfiles:
    sortByPValue(f)

print('All done.')