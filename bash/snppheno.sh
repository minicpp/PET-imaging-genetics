#!/bin/bash
#plink2 --bfile out/ADNI_filt --snp $1 --pheno $2  -recodeA --out out/$1
plink2 --bfile out/ADNI_filt --keep v1_trace_1_list.txt  --snp $1 --pheno v1_trace_1.txt --pheno-name gc -recodeA --out out/$1

