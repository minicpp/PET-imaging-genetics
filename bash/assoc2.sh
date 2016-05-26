#!/bin/bash

plink2 --bfile plink/ADNI_filt_nosex --keep v1_trace_1_list.txt -assoc --pheno v1_trace_1.txt --pheno-name pc --covar v1_trace_1.txt --out out/gwas_v1_trace_1.pc
plink2 --bfile plink/ADNI_filt_nosex --keep v1_trace_1_list.txt -assoc --pheno v1_trace_1.txt --pheno-name pp --covar v1_trace_1.txt --out out/gwas_v1_trace_1.pp
plink2 --bfile plink/ADNI_filt_nosex --keep v1_trace_1_list.txt -assoc --pheno v1_trace_1.txt --pheno-name gc --covar v1_trace_1.txt --out out/gwas_v1_trace_1.gc

plink2 --bfile plink/ADNI_filt_nosex --keep v1_trace_2_list.txt -assoc --pheno v1_trace_2.txt --pheno-name pc --covar v1_trace_2.txt --out out/gwas_v1_trace_2.pc
plink2 --bfile plink/ADNI_filt_nosex --keep v1_trace_2_list.txt -assoc --pheno v1_trace_2.txt --pheno-name pp --covar v1_trace_2.txt --out out/gwas_v1_trace_2.pp
plink2 --bfile plink/ADNI_filt_nosex --keep v1_trace_2_list.txt -assoc --pheno v1_trace_2.txt --pheno-name gc --covar v1_trace_2.txt --out out/gwas_v1_trace_2.gc

plink2 --bfile plink/ADNI_filt_nosex --keep v1_trace_3_list.txt -assoc --pheno v1_trace_3.txt --pheno-name pc --covar v1_trace_3.txt --out out/gwas_v1_trace_3.pc
plink2 --bfile plink/ADNI_filt_nosex --keep v1_trace_3_list.txt -assoc --pheno v1_trace_3.txt --pheno-name pp --covar v1_trace_3.txt --out out/gwas_v1_trace_3.pp
plink2 --bfile plink/ADNI_filt_nosex --keep v1_trace_3_list.txt -assoc --pheno v1_trace_3.txt --pheno-name gc --covar v1_trace_3.txt --out out/gwas_v1_trace_3.gc

plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_1_list.txt -assoc --pheno v2_trace_1.txt --pheno-name pc --covar v2_trace_1.txt --out out/gwas_v2_trace_1.pc
plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_1_list.txt -assoc --pheno v2_trace_1.txt --pheno-name pp --covar v2_trace_1.txt --out out/gwas_v2_trace_1.pp
plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_1_list.txt -assoc --pheno v2_trace_1.txt --pheno-name gc --covar v2_trace_1.txt --out out/gwas_v2_trace_1.gc

plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_2_list.txt -assoc --pheno v2_trace_2.txt --pheno-name pc --covar v2_trace_2.txt --out out/gwas_v2_trace_2.pc
plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_2_list.txt -assoc --pheno v2_trace_2.txt --pheno-name pp --covar v2_trace_2.txt --out out/gwas_v2_trace_2.pp
plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_2_list.txt -assoc --pheno v2_trace_2.txt --pheno-name gc --covar v2_trace_2.txt --out out/gwas_v2_trace_2.gc

plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_3_list.txt -assoc --pheno v2_trace_3.txt --pheno-name pc --covar v2_trace_3.txt --out out/gwas_v2_trace_3.pc
plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_3_list.txt -assoc --pheno v2_trace_3.txt --pheno-name pp --covar v2_trace_3.txt --out out/gwas_v2_trace_3.pp
plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_3_list.txt -assoc --pheno v2_trace_3.txt --pheno-name gc --covar v2_trace_3.txt --out out/gwas_v2_trace_3.gc


plink2 --bfile plink/ADNI_filt_nosex --keep v1_trace_1_list.txt --linear --pheno v1_trace_1.txt --pheno-name pc --covar v1_trace_1.txt --covar-name age --out out/gwas_v1_trace_1.pc
plink2 --bfile plink/ADNI_filt_nosex --keep v1_trace_1_list.txt --linear --pheno v1_trace_1.txt --pheno-name pp --covar v1_trace_1.txt --covar-name age --out out/gwas_v1_trace_1.pp
plink2 --bfile plink/ADNI_filt_nosex --keep v1_trace_1_list.txt --linear --pheno v1_trace_1.txt --pheno-name gc --covar v1_trace_1.txt --covar-name age --out out/gwas_v1_trace_1.gc

plink2 --bfile plink/ADNI_filt_nosex --keep v1_trace_2_list.txt --linear --pheno v1_trace_2.txt --pheno-name pc --covar v1_trace_2.txt --covar-name age --out out/gwas_v1_trace_2.pc
plink2 --bfile plink/ADNI_filt_nosex --keep v1_trace_2_list.txt --linear --pheno v1_trace_2.txt --pheno-name pp --covar v1_trace_2.txt --covar-name age --out out/gwas_v1_trace_2.pp
plink2 --bfile plink/ADNI_filt_nosex --keep v1_trace_2_list.txt --linear --pheno v1_trace_2.txt --pheno-name gc --covar v1_trace_2.txt --covar-name age --out out/gwas_v1_trace_2.gc

plink2 --bfile plink/ADNI_filt_nosex --keep v1_trace_3_list.txt --linear --pheno v1_trace_3.txt --pheno-name pc --covar v1_trace_3.txt --covar-name age --out out/gwas_v1_trace_3.pc
plink2 --bfile plink/ADNI_filt_nosex --keep v1_trace_3_list.txt --linear --pheno v1_trace_3.txt --pheno-name pp --covar v1_trace_3.txt --covar-name age --out out/gwas_v1_trace_3.pp
plink2 --bfile plink/ADNI_filt_nosex --keep v1_trace_3_list.txt --linear --pheno v1_trace_3.txt --pheno-name gc --covar v1_trace_3.txt --covar-name age --out out/gwas_v1_trace_3.gc

plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_1_list.txt --linear --pheno v2_trace_1.txt --pheno-name pc --covar v2_trace_1.txt --covar-name age --out out/gwas_v2_trace_1.pc
plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_1_list.txt --linear --pheno v2_trace_1.txt --pheno-name pp --covar v2_trace_1.txt --covar-name age --out out/gwas_v2_trace_1.pp
plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_1_list.txt --linear --pheno v2_trace_1.txt --pheno-name gc --covar v2_trace_1.txt --covar-name age --out out/gwas_v2_trace_1.gc

plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_2_list.txt --linear --pheno v2_trace_2.txt --pheno-name pc --covar v2_trace_2.txt --covar-name age --out out/gwas_v2_trace_2.pc
plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_2_list.txt --linear --pheno v2_trace_2.txt --pheno-name pp --covar v2_trace_2.txt --covar-name age --out out/gwas_v2_trace_2.pp
plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_2_list.txt --linear --pheno v2_trace_2.txt --pheno-name gc --covar v2_trace_2.txt --covar-name age --out out/gwas_v2_trace_2.gc

plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_3_list.txt --linear --pheno v2_trace_3.txt --pheno-name pc --covar v2_trace_3.txt --covar-name age --out out/gwas_v2_trace_3.pc
plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_3_list.txt --linear --pheno v2_trace_3.txt --pheno-name pp --covar v2_trace_3.txt --covar-name age --out out/gwas_v2_trace_3.pp
plink2 --bfile plink/ADNI_filt_nosex --keep v2_trace_3_list.txt --linear --pheno v2_trace_3.txt --pheno-name gc --covar v2_trace_3.txt --covar-name age --out out/gwas_v2_trace_3.gc
