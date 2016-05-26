#!/bin/bash

#select individuals and add phenotypes
plink2 --bfile ADNI_cluster_01_forward_757LONI --keep ADNI_intersection.txt --pheno ADNI_simple_diagnosis.txt --make-bed --set-hh-missing --out out/ADNI_selected
#plink2 --bfile out/ADNI_selected --missing --out out/ADNI_nomiss
plink2 --bfile out/ADNI_selected --maf 0.01 --geno 0.05 --make-bed --out out/ADNI_filt

#Remove sex snp
plink2 --bfile out/ADNI_filt --extract noSexSNP.txt  --make-bed --out out/ADNI_filt_nosex
