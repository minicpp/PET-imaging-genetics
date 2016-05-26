__author__ = 'mat'
#Second step
#rank each white subject to asian or black
#rank with gender, age, and education
#the smaller rank value means more similar between a white and an asian or black
#We found that the dataset has many white subjects
#it is very easy to found a white matches a minority with same age, education and gender
#Therefore, usually, we just need to choose white subject with rank = 0.

dictRecord={}
inputFile = "/home/mat/adni/raceData/unique_PTDEMOG.csv"
outputFile = "/home/mat/adni/raceData/rank_PTDEMOG.csv"
outputFileMinority = "/home/mat/adni/raceData/minorityInRank.csv"
genderWeight = 0.2

class Subject:
    def __init__(self, s):
        self.rid = s[0]
        self.age = s[1]
        self.education = s[2]
        self.gender = s[3]
        self.race = s[4]
        self.normAge = s[5]
        self.normEdu = s[6]
        self.rank = 0
        self.rankRid = 0
        self.bmatch = 0

    def runRank(self,subList):
        if self.race != 5:
            self.rank = 0
            self.rankRid = self.rid
            return 0
        tRank = 65535.0
        tRid = 0
        for r in subList:
            assert isinstance(r, Subject)
            distance = self.__getRank(r)
            if distance < tRank:
                tRank = distance
                tRid = r.rid
        self.rank = tRank
        self.rankRid = tRid
        return tRid

    def __getRank(self, item):
        assert isinstance(item, Subject)
        distance = ((self.normEdu - item.normEdu)**2 + (self.normAge - item.normAge)**2 )**0.5
        if self.gender != item.gender:
            distance += genderWeight
        return distance

records = None
with open(inputFile) as f:
    records = f.readlines()

noWhiteRecord = []
whiteRecord = []
totalRecord = []
dictTotalRecord = {}
ageMax = 0
ageMin = 65535
eduMax = 0
eduMin = 65535
for r in records[1:]:
    s = r.split(",")
    m = []
    rid = int(s[2])
    age = 2015 - int(s[11])
    if ageMax < age:
        ageMax = age
    if ageMin > age:
        ageMin = age
    education = int(s[14])
    if eduMax < education:
        eduMax = education
    if eduMin > education:
        eduMin = education
    gender = int(s[9])
    race = int(s[-2])
    #the structure of s is rid, age, edu, gender, race, norm age, norm edu
    s = [rid, age, education, gender, race, 0, 0]
    sub = Subject(s)
    totalRecord += [sub]
    if race == 5:
        whiteRecord += [sub]
    else:
        noWhiteRecord += [sub]
    dictTotalRecord[rid] = sub
#
for r in totalRecord:
    assert isinstance(r, Subject)
    r.normAge = (r.age - ageMin) / (ageMax - ageMin)
    r.normEdu = (r.education - eduMin) / (eduMax - eduMin)

for r in totalRecord:
    assert isinstance(r, Subject)
    tRid = r.runRank(noWhiteRecord)
    if tRid > 0:
        dictTotalRecord[tRid].bmatch += 1


#output ranked subjects

whiteRecord = sorted(whiteRecord, key=lambda ss: ss.rank)

with open(outputFile,'w') as f:
    f.write("RID, AGE, EDU, GENDER, RACE, NormAge, NormEdu, Rank, "
            "RankRID, refAGE, refEDU, refGENDER, refRACE, refNormAge, refNormEdu, refRank, refRankRID\n")
    for r in whiteRecord:
        assert isinstance(r, Subject)
        refSubject = dictTotalRecord[r.rankRid]
        assert isinstance(refSubject, Subject)
        f.write("%d,%d,%d,%d,%d,%.6f,%.6f,%.6f,%d,"
                % (r.rid, r.age, r.education, r.gender, r.race, r.normAge, r.normEdu, r.rank, r.rankRid))
        f.write("%d,%d,%d,%d,%.6f,%.6f,%.6f,%d\n"
                % (refSubject.age, refSubject.education,refSubject.gender,refSubject.race,
                   refSubject.normAge, refSubject.normEdu, refSubject.rank, refSubject.rankRid))

minorityMatchCount = 0
with open(outputFileMinority,'w') as f:
    f.write("RID, AGE, EDU, GENDER, RACE, NormAge, NormEdu, Rank, RankRID\n")
    for r in noWhiteRecord:
        assert isinstance(r, Subject)
        f.write("%d,%d,%d,%d,%d,%.6f,%.6f,%.6f,%d\n"
                % (r.rid, r.age, r.education, r.gender, r.race, r.normAge, r.normEdu, r.rank, r.rankRid))
        if r.bmatch > 0:
            minorityMatchCount += 1

print("White record: %d, no White record: %d, matched Minority:%d/%d\n"
      % (len(whiteRecord), len(noWhiteRecord), minorityMatchCount, len(noWhiteRecord)))