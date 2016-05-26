clear;
v2_trace1;
tbl = table(gc, age);
tbl.snp = nominal(rs1876152);
mdl = fitlm(tbl,'gc ~ age + snp')