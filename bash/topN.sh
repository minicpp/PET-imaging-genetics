#!/bin/bash
topN="/home/mat/adni/program/py/getTopNAllele.py"
mpath="/home/mat/adni/data/"
echo $topN

v="v1"
tt="pc"
trace="1"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.qassoc" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/assoc/"

v="v1"
tt="pp"
trace="1"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.qassoc" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/assoc/"

v="v1"
tt="gc"
trace="1"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.qassoc" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/assoc/"

v="v1"
tt="pc"
trace="2"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.qassoc" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/assoc/"

v="v1"
tt="pp"
trace="2"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.qassoc" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/assoc/"

v="v1"
tt="gc"
trace="2"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.qassoc" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/assoc/"

v="v1"
tt="pc"
trace="3"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.qassoc" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/assoc/"

v="v1"
tt="pp"
trace="3"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.qassoc" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/assoc/"

v="v1"
tt="gc"
trace="3"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.qassoc" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/assoc/"

##########


v="v1"
tt="pc"
trace="1"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.assoc.linear" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/linear/"

v="v1"
tt="pp"
trace="1"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.assoc.linear" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/linear/"

v="v1"
tt="gc"
trace="1"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.assoc.linear" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/linear/"

v="v1"
tt="pc"
trace="2"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.assoc.linear" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/linear/"

v="v1"
tt="pp"
trace="2"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.assoc.linear" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/linear/"

v="v1"
tt="gc"
trace="2"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.assoc.linear" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/linear/"

v="v1"
tt="pc"
trace="3"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.assoc.linear" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/linear/"

v="v1"
tt="pp"
trace="3"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.assoc.linear" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/linear/"

v="v1"
tt="gc"
trace="3"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.assoc.linear" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/linear/"

######################
v="v2"
tt="pc"
trace="1"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.qassoc" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/assoc/"

v="v2"
tt="pp"
trace="1"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.qassoc" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/assoc/"

v="v2"
tt="gc"
trace="1"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.qassoc" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/assoc/"

v="v2"
tt="pc"
trace="2"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.qassoc" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/assoc/"

v="v2"
tt="pp"
trace="2"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.qassoc" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/assoc/"

v="v2"
tt="gc"
trace="2"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.qassoc" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/assoc/"

v="v2"
tt="pc"
trace="3"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.qassoc" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/assoc/"

v="v2"
tt="pp"
trace="3"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.qassoc" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/assoc/"

v="v2"
tt="gc"
trace="3"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.qassoc" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/assoc/"

##########


v="v2"
tt="pc"
trace="1"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.assoc.linear" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/linear/"

v="v2"
tt="pp"
trace="1"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.assoc.linear" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/linear/"

v="v2"
tt="gc"
trace="1"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.assoc.linear" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/linear/"

v="v2"
tt="pc"
trace="2"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.assoc.linear" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/linear/"

v="v2"
tt="pp"
trace="2"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.assoc.linear" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/linear/"

v="v2"
tt="gc"
trace="2"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.assoc.linear" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/linear/"

v="v2"
tt="pc"
trace="3"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.assoc.linear" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/linear/"

v="v2"
tt="pp"
trace="3"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.assoc.linear" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/linear/"

v="v2"
tt="gc"
trace="3"
python3.4 $topN "${mpath}plink/ADNI_filt_nosex" "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${tt}.assoc.linear" ${tt} 10 "${mpath}${v}_trace${trace}/snp_${tt}/linear/"

######################
