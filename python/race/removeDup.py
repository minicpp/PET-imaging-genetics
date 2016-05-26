__author__ = 'mat'
#First step
#load a csv file that has all the information of subjects
#some subjects are shown more than one times
#we just keep one record of the subject, also we just keep race for asia,black,and white
#then we output the pre-processed records to a new csv file
#also we can filter with genetic file, that only patient with genetic files are kept

inputFile = "/home/mat/adni/raceData/PTDEMOG.csv"
outputFile = "/home/mat/adni/raceData/unique_PTDEMOG.csv"
inputPlinkFile="/home/mat/adni/data/ADNI_cluster_01_forward_757LONI.fam"

records = None
with open(inputFile) as f:
    records = f.readlines()

print("Total records: %d\n" % len(records))

fam = None
with open(inputPlinkFile) as f:
    fam = f.readlines()
print("Total plink fam records:%d\n" % len(fam))

famSet = set()
for r in fam:
    ra = r.split()
    ra2 = ra[1].split('_')
    rid = int(ra2[2])
    if rid not in famSet:
        famSet.add(rid)



setRecord = set()
uniqueRecords = []
uniqueRecords += [records[0]]
dictRace = {2: 0, 4: 0, 5: 0}
for r in records[1:]:
    s = r.split(',')
    key = int(s[2])
    race = s[-2].strip()
    year = s[11].strip()
    education = s[14].strip()
    gender = s[9].strip()
    if len(race) > 0 and len(year) > 0 and len(education) > 0 and len(gender) > 0:
        race = int(race)
        if race in dictRace:
            if key not in setRecord and key in famSet:
                dictRace[race] += 1
                setRecord.add(key)
                uniqueRecords += [r]

print("Total unique records: %d\n" % len(uniqueRecords))
print("Asian(2):%d, Black(4):%d, White(5):%d\n" % (dictRace[2], dictRace[4], dictRace[5]))
with open(outputFile, 'w') as f:
    for r in uniqueRecords:
        f.write(r)
print("Done.\n")