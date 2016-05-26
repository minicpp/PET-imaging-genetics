#!/bin/bash
csvGen="/home/mat/adni/program/py/genTopSNPCSV.py"
mpath="/home/mat/adni/data/"
bimFile="/home/mat/adni/data/plink/ADNI_filt_nosex.bim"
echo $csvGen

###v1 trace 1
v="v1"
trace="1"
pheno="gc"
ftype="assoc"
sortSuffix="sort.qassoc"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


pheno="pc"
ftype="assoc"
sortSuffix="sort.qassoc"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


pheno="pp"
ftype="assoc"
sortSuffix="sort.qassoc"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno

pheno="gc"
ftype="linear"
sortSuffix="assoc.sort.linear"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


pheno="pc"
ftype="linear"
sortSuffix="assoc.sort.linear"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno

pheno="pp"
ftype="linear"
sortSuffix="assoc.sort.linear"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno

######v1 trace 2
v="v1"
trace="2"

pheno="gc"
ftype="assoc"
sortSuffix="sort.qassoc"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


pheno="pc"
ftype="assoc"
sortSuffix="sort.qassoc"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


pheno="pp"
ftype="assoc"
sortSuffix="sort.qassoc"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno

pheno="gc"
ftype="linear"
sortSuffix="assoc.sort.linear"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


pheno="pc"
ftype="linear"
sortSuffix="assoc.sort.linear"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno

pheno="pp"
ftype="linear"
sortSuffix="assoc.sort.linear"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


######v1 trace 3
v="v1"
trace="3"

pheno="gc"
ftype="assoc"
sortSuffix="sort.qassoc"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


pheno="pc"
ftype="assoc"
sortSuffix="sort.qassoc"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


pheno="pp"
ftype="assoc"
sortSuffix="sort.qassoc"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno

pheno="gc"
ftype="linear"
sortSuffix="assoc.sort.linear"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


pheno="pc"
ftype="linear"
sortSuffix="assoc.sort.linear"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno

pheno="pp"
ftype="linear"
sortSuffix="assoc.sort.linear"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


#############################################


###v2 trace 1
v="v2"
trace="1"
pheno="gc"
ftype="assoc"
sortSuffix="sort.qassoc"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


pheno="pc"
ftype="assoc"
sortSuffix="sort.qassoc"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


pheno="pp"
ftype="assoc"
sortSuffix="sort.qassoc"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno

pheno="gc"
ftype="linear"
sortSuffix="assoc.sort.linear"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


pheno="pc"
ftype="linear"
sortSuffix="assoc.sort.linear"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno

pheno="pp"
ftype="linear"
sortSuffix="assoc.sort.linear"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno

######v2 trace 2
v="v2"
trace="2"

pheno="gc"
ftype="assoc"
sortSuffix="sort.qassoc"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


pheno="pc"
ftype="assoc"
sortSuffix="sort.qassoc"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


pheno="pp"
ftype="assoc"
sortSuffix="sort.qassoc"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno

pheno="gc"
ftype="linear"
sortSuffix="assoc.sort.linear"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


pheno="pc"
ftype="linear"
sortSuffix="assoc.sort.linear"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno

pheno="pp"
ftype="linear"
sortSuffix="assoc.sort.linear"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


######v2 trace 3
v="v2"
trace="3"

pheno="gc"
ftype="assoc"
sortSuffix="sort.qassoc"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


pheno="pc"
ftype="assoc"
sortSuffix="sort.qassoc"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


pheno="pp"
ftype="assoc"
sortSuffix="sort.qassoc"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno

pheno="gc"
ftype="linear"
sortSuffix="assoc.sort.linear"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


pheno="pc"
ftype="linear"
sortSuffix="assoc.sort.linear"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno

pheno="pp"
ftype="linear"
sortSuffix="assoc.sort.linear"
python3.4 $csvGen $bimFile "${mpath}${v}_trace_${trace}.txt" "${mpath}out/gwas_${v}_trace_${trace}.${pheno}.${sortSuffix}" "${mpath}${v}_trace${trace}/snp_${pheno}" 10 $trace $pheno


