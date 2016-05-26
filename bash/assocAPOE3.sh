#!/bin/bash


plink2 --file plink/ADNI_filt_nosex_v2_tracer1_update --keep v2_tracer_1_list.txt --assoc --pheno v2_tracer_1.txt --pheno-name pc --covar v2_trace_1.txt --covar-name age --out out2/v2_trace_1_apoe.pc
plink2 --file plink/ADNI_filt_nosex_v2_tracer1_update --keep v2_tracer_1_list.txt --assoc --pheno v2_tracer_1.txt --pheno-name pp --covar v2_trace_1.txt --covar-name age --out out2/v2_trace_1_apoe.pp
plink2 --file plink/ADNI_filt_nosex_v2_tracer1_update --keep v2_tracer_1_list.txt --assoc --pheno v2_tracer_1.txt --pheno-name gc --covar v2_trace_1.txt --covar-name age --out out2/v2_trace_1_apoe.gc


plink2 --file plink/ADNI_filt_nosex_v2_tracer1_update --keep v2_tracer_2_list.txt --assoc --pheno v2_tracer_2.txt --pheno-name pc --covar v2_trace_2.txt --covar-name age --out out2/v2_trace_2_apoe.pc
plink2 --file plink/ADNI_filt_nosex_v2_tracer1_update --keep v2_tracer_2_list.txt --assoc --pheno v2_tracer_2.txt --pheno-name pp --covar v2_trace_2.txt --covar-name age --out out2/v2_trace_2_apoe.pp
plink2 --file plink/ADNI_filt_nosex_v2_tracer1_update --keep v2_tracer_2_list.txt --assoc --pheno v2_tracer_2.txt --pheno-name gc --covar v2_trace_2.txt --covar-name age --out out2/v2_trace_2_apoe.gc

plink2 --file plink/ADNI_filt_nosex_v2_tracer1_update --keep v2_tracer_3_list.txt --assoc --pheno v2_tracer_3.txt --pheno-name pc --covar v2_trace_3.txt --covar-name age --out out2/v2_trace_3_apoe.pc
plink2 --file plink/ADNI_filt_nosex_v2_tracer1_update --keep v2_tracer_3_list.txt --assoc --pheno v2_tracer_3.txt --pheno-name pp --covar v2_trace_3.txt --covar-name age --out out2/v2_trace_3_apoe.pp
plink2 --file plink/ADNI_filt_nosex_v2_tracer1_update --keep v2_tracer_3_list.txt --assoc --pheno v2_tracer_3.txt --pheno-name gc --covar v2_trace_3.txt --covar-name age --out out2/v2_trace_3_apoe.gc
