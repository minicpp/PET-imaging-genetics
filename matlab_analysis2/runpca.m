[FID,IID,bin,cat1,t1ppSlope,t1pcSlope,t1gcSlope,t1pp,t1pc,t1gc,t2pp,t2pc, ...
    t2gc,t3pp,t3pc,t3gc,sex,age,weight,race]= ...
    importTraceForPCA('/home/mat/adni/data/v1_trace_PCA.txt',2,77);

X=[t1pp,t1pc,t1gc,t2pp,t2pc,t2gc,t3pp,t3pc,t3gc];
EX = nanmean(X);
DX = nanstd(X);
[n,m]=size(X);
TX = (X - repmat(EX,[n 1])) ./ repmat(DX,[n 1])
NX = mapminmax(X')
NX = NX'