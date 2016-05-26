__author__ = 'mat'

import numpy as np

class Individual:
    smap={"SubjectID":0,"Sex":1,"Weight":2,"Ethnicity":3,"Race":4,"Education":5,"APOEA2":6,"APOEA1":7,
                "DXGroup":8,"DiagnosisTransition":10,"VisitCode":13,"Age":16,"Tracer":29,
          "ObiFronCo":30, "PreFrontal":31, "SupFronCo":32, "LatTemporal":33, "MedTemporal":34, "Parietal":35, "PosPrecuneus":36, "AntCingulate":37, "PosCingulate":38,
            "Occipital":39, "GlobalCortex":40, "Amygdala":41, "Hippocampus":42, "Caudate":43, "Caudate_LR":44, "Putamen":45, "Putamen_LR":46, "Putamen_L":47, "Putamen_R":48,
            "Putamen_LA":49, "Putamen_LP":50, "Putamen_RA":51,"Putamen_RP":52, "VST":53, "VST_LR":54, "Thalamus":55,
          "Raphe":56, "RapheDorsal":57, "Raphenuclei":58, "SubstantiaNigra":59, "MidBrain":60, "Pons":61,
            "Medulla":62, "CentrumSemiovale":63, "GrayMatter_VBM8":64, "WhiteMatter_VBM8":65, "BrainMask_GM_WM_CSF" : 66 }
    traceMap = ["Tracer","VisitCode","Age","Weight","DiagnosisTransition","ObiFronCo", "PreFrontal", "SupFronCo", "LatTemporal",
                "MedTemporal", "Parietal", "PosPrecuneus", "AntCingulate", "PosCingulate",
                "Occipital", "GlobalCortex", "Amygdala", "Hippocampus", "Caudate", "Caudate_LR", "Putamen", "Putamen_LR", "Putamen_L", "Putamen_R",
                "Putamen_LA", "Putamen_LP", "Putamen_RA","Putamen_RP", "VST", "VST_LR", "Thalamus",
                "Raphe", "RapheDorsal", "Raphenuclei", "SubstantiaNigra", "MidBrain", "Pons",
                "Medulla", "CentrumSemiovale", "GrayMatter_VBM8", "WhiteMatter_VBM8", "BrainMask_GM_WM_CSF"]
    traceMapFloat = ["Age", "Weight","ObiFronCo", "PreFrontal", "SupFronCo", "LatTemporal",
                "MedTemporal", "Parietal", "PosPrecuneus", "AntCingulate", "PosCingulate",
                "Occipital", "GlobalCortex", "Amygdala", "Hippocampus", "Caudate", "Caudate_LR", "Putamen", "Putamen_LR", "Putamen_L", "Putamen_R",
                "Putamen_LA", "Putamen_LP", "Putamen_RA","Putamen_RP", "VST", "VST_LR", "Thalamus",
                "Raphe", "RapheDorsal", "Raphenuclei", "SubstantiaNigra", "MidBrain", "Pons",
                "Medulla", "CentrumSemiovale", "GrayMatter_VBM8", "WhiteMatter_VBM8", "BrainMask_GM_WM_CSF"]
    maxVisitCode = -1
    lastDiagnosis = 2
    firstDiagnosis = -1

    def __init__(self):
        self.uniqueRecord = {"SubjectID":"","Sex":"","Ethnicity":"","Race":"","Education":"","APOEA2":"","APOEA1":"",
                    "DXGroup":""}
        self.traceRecord={1:{},2:{},3:{}}

        for i in self.traceRecord:
            v = self.traceRecord[i]
            for j in self.traceMap:
                v[j]=[]


    def addRecord(self,strArray):
        for i in self.uniqueRecord:
            v = strArray[self.smap[i]].strip()
            if len(v) > 0 and len(self.uniqueRecord[i]) == 0:
                self.uniqueRecord[i] = v

        traceId = strArray[self.smap["Tracer"]]
        rec = self.traceRecord[int(traceId)]
        for i in self.traceMap:
            v =strArray[self.smap[i]]
            if i in self.traceMapFloat:
                rec[i] += [float(v)]
            else:
                rec[i] += [int(v)]
        visitCode = int(strArray[self.smap["VisitCode"]])
        if visitCode > self.maxVisitCode:
            if self.maxVisitCode == -1:
                self.firstDiagnosis = int(strArray[self.smap["DiagnosisTransition"]])
            self.lastDiagnosis = int(strArray[self.smap["DiagnosisTransition"]])
            self.maxVisitCode = visitCode

    def getTraceCount(self):
        return "Trace("+"1:"+str(len(self.traceRecord[1]["Tracer"]))\
               +"@2:"+str(len(self.traceRecord[2]["Tracer"]))\
               +"@3:"+str(len(self.traceRecord[3]["Tracer"]))+")"

    def getBinaryDiagnosis(self):
        if self.lastDiagnosis == 2:
            return 1;
        return 2;

    def getCategoricalDiagnosis(self):
        if self.firstDiagnosis == self.lastDiagnosis:
            if self.firstDiagnosis == 2:
                return "NL-NL"
            elif self.firstDiagnosis == 1:
                return "AD-AD"
            elif self.firstDiagnosis == 3:
                return "MCI-MCI"
        else:
            if self.lastDiagnosis == 23:
                return "NL-MCI"
            elif self.lastDiagnosis == 21:
                return "NL-AD"
            elif self.lastDiagnosis == 31:
                return "MCI-AD"
            elif self.lastDiagnosis == 32:
                return "MCI-NL"

    def getSex(self):
        return self.uniqueRecord["Sex"]

    def getAPOEA1(self):
        return self.uniqueRecord["APOEA1"]
    def getAPOEA2(self):
        return self.uniqueRecord["APOEA2"]


    def getAge(self): #return baseline age
        s = set()
        for i in self.traceRecord:
            a = self.traceRecord[i]["Age"]
            s = s.union(a)
        s = list(s)
        s.sort()
        age = self.getMedValue(s)
        return age

    def getFirstVisitAge(self):
        s = set()
        for i in self.traceRecord:
            a = self.traceRecord[i]["Age"]
            s = s.union(a)
        s = list(s)
        s.sort()
        age = s[0]
        return age

    def getLastVisit(self):
        return self.maxVisitCode

    def getWeight(self):
        s = set()
        for i in self.traceRecord:
            a = self.traceRecord[i]["Weight"]
            s = s.union(a)
        s = list(s)
        s.sort()
        weight = self.getMedValue(s)
        return weight

    def getMedValue(self,s):
        if len(s) % 2 == 0:
            return (s[int(len(s)/2)]+s[int(len(s)/2-1)])/2
        else:
            return s[int(len(s)/2)]

    def getRace(self):
        return self.uniqueRecord["Race"]

#mean(before transition value) - mean(after transition value)
    def getTrace1ScaleOffset(self,scaleName):
        t = self.traceRecord[1]
        v = t[scaleName]
        i = self.getTraceTranstionIndex(t["DiagnosisTransition"])
        m = 0
        # p1 = 0
        # p2 = 0
        # if i == 0:  #first part - second part
        #     s1 = v[:int(len(v)/2)]
        #     p1 = np.mean(s1)
        #     s2 = v[int(len(v)/2):]
        #     p2 = np.mean(s2)
        # else:
        #     s1 = v[:i]
        #     p1 = np.mean(s1)
        #     s2 = v[i:]
        #     p2 = np.mean(s2)
        m = v[0] - v[-1]
        return m

    def getTrace1Slope(self,scaleName):
        t = self.traceRecord[1]
        x = t["Age"]
        y = t[scaleName]
        regression = np.polyfit(x, y, 1)
        return regression[0]

    def getTraceTranstionIndex(self, darray):
        a=darray[0]
        index = 1
        for b in darray[1:]:
            if b != a:
                return index
            index += 1;
        return 0

    def getTraceAverage(self,tid,scaleName):
        t = self.traceRecord[tid]
        v = t[scaleName]
        return np.mean(v)
