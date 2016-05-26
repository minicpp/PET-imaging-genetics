#!/bin/bash

plink2 --bfile out/ADNI_filt --snp $1 -recodeA --out out/$1
