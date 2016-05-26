#!/bin/bash

plink2 --bfile plink/ADNI_filt_nosex_v2_tracer1_update --keep v2_trace_1_list.txt --pheno v2_trace_1.txt --pheno-name bin  --out out/gwas_v2_trace_1_apoe.bin
plink2 --bfile plink/ADNI_filt_nosex_v2_tracer1_update --keep v2_trace_2_list.txt --pheno v2_trace_2.txt --pheno-name bin  --out out/gwas_v2_trace_2_apoe.bin
plink2 --bfile plink/ADNI_filt_nosex_v2_tracer1_update --keep v2_trace_3_list.txt --pheno v2_trace_3.txt --pheno-name bin  --out out/gwas_v2_trace_3_apoe.bin
