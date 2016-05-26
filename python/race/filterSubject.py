__author__ = 'mat'
#Third Step
#We use two csv file to store white subject and minority subject,respectively,
# rid is the first column
#Then we filter the original file into two files
#one file contains record of just matched white subject
#The second file contains minority for asian and black
inputfileWhite = "/home/mat/adni/raceData/rankW.csv"
inputfileMinority = "/home/mat/adni/raceData/minorityInRank.csv"
inputFile = "/home/mat/adni/raceData/PTDEMOG.csv"
outputFileW = "/home/mat/adni/raceData/PTDEMOG_W.csv"
outputFileAB = "/home/mat/adni/raceData/PTDEMOG_AB.csv"

records = None
with open(inputFile) as f:
    records = f.readlines()

includeWhite = None
with open(inputfileWhite) as f:
    includeWhite = f.readlines()

includeMinority = None
with open(inputfileMinority) as f:
    includeMinority = f.readlines()

ridDicWhite = {}
for r in includeWhite[1:]:
    s = r.split(",")
    key = s[0].strip()
    if key not in ridDicWhite:
        ridDicWhite[key]=s[8].strip()

ridSetMinority = set()
for r in includeMinority[1:]:
    s = r.split(",")
    ridSetMinority.add(s[0].strip())

with open(outputFileW,'w') as fw:
    fw.write(records[0].strip() + ",RefRID" +"\n")
    with open(outputFileAB,'w') as fab:
        fab.write(records[0].strip() + ",RefRID" +"\n")
        for r in records[1:]:
            s = r.split(",")
            rid = s[2].strip()
            if rid in ridDicWhite:
                fw.write(r.strip() + ","+ridDicWhite[rid]+"\n")
            elif rid in ridSetMinority:
                fab.write(r.strip() +"," + rid +"\n")
print("Done.")