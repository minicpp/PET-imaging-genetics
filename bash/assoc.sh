#!/bin/bash


plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_1_list.txt -assoc --pheno v2_trace_1.txt --pheno-name pc --covar v2_trace_1.txt --out out/gwas_v2_trace_1.pc
plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_1_list.txt -assoc --pheno v2_trace_1.txt --pheno-name pp --covar v2_trace_1.txt --out out/gwas_v2_trace_1.pp
plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_1_list.txt -assoc --pheno v2_trace_1.txt --pheno-name gc --covar v2_trace_1.txt --out out/gwas_v2_trace_1.gc


