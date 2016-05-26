__author__ = 'mat'
#get file that each individual is attached interested alleles

phenoFile = "/home/mat/adni/data/v2_trace_1.txt"
outputFile = "/home/mat/adni/data/allele/v2_trace_1_alleles.csv"
snpRawFilePath = "/home/mat/adni/data/snp/"
bimFile = "/home/mat/adni/data/plink/ADNI_filt_nosex.bim"

#interestedSNP = ["rs1501228", "rs12565755", "rs12408850",
#            "rs1946867", "rs3905886","rs9951577",
#            "rs4149286", "rs343248", "rs4149284"]

interestedSNP = ["rs1876152"]

phenoRecord = []
with open(phenoFile) as f:
    phenoRecord = f.readlines()

bimMap={}
with open(bimFile) as f:
    record = f.readlines()
    for r in record:
        s = r.split()
        bimMap[s[1]] = s


rawRecord={}
for snp in interestedSNP:
    snpfile = snpRawFilePath + snp +".raw"
    indDic = {}
    with open(snpfile) as f:
        record = f.readlines()
        for i in record[1:]:
            sp = i.split()
            indDic[sp[1]] = sp
    rawRecord[snp] = indDic

with open(outputFile,'w') as f:
    header = phenoRecord[0]
    header = header.strip()
    minorSNP=header.split()[-1]
    minorSNP = minorSNP.split('_')
    minorSNP = minorSNP[-1]
    for snp in interestedSNP:
        header += "\t" + snp + "\t" + snp+"_code"
    header += "\n"
    f.write(header)
    individualAllele = ""
    for i in phenoRecord[1:]:
        i = i.strip()
        j = i.split()
        sid = j[1]
        for snp in interestedSNP:
            p = rawRecord[snp][sid]
            ia1="NA"
            ia2="NA"
            alleleInfo = bimMap[snp]
            a1 = alleleInfo[4];
            a2 = alleleInfo[5];
            individualAllele = p[-1]
            #bug fixed here
            if individualAllele == '0':
                if minorSNP == a1:
                    ia1 = ia2 = a2
                else:
                    ia1 = ia2 = a1
            elif individualAllele == '1':
                ia1 = a1
                ia2 = a2
            elif individualAllele == '2':
                if minorSNP == a1:
                    ia1 = ia2 = a1
                else:
                    ia1 = ia2 = a2

            i += "\t" + ia1+ia2 + "\t"+individualAllele
        i += "\n"
        f.write(i)

print("write file %s done." % outputFile)


#generage paired snp summary
#pair name and number of individuals