function [ res, pval, pint, px,page ] = calcRegression( x,age,yMatrix )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
ux = unique(x);
seqs = perms(ux);
res = zeros(size(seqs,1), size(yMatrix,2));
res = [seqs,res];
pval = zeros(size(seqs,1),size(yMatrix,2));
pint = zeros(size(seqs,1),size(yMatrix,2));
px = zeros(size(seqs,1),size(yMatrix,2));
page = zeros(size(seqs,1),size(yMatrix,2));;
for ii=1:size(seqs,1)
    seq = seqs(ii,:);
    tx = x;
    for jj=1:numel(seq)
        v = seq(jj);
        I = find(x==v);
        tx(I)=jj;        
    end
    for kk=1:size(yMatrix,2)
        y = yMatrix(:,kk);
        apoeTable = table(tx,age, y);
        mdl = fitlm(apoeTable,'y ~ tx + age');
        mv =table2array(mdl.Coefficients);
        av = anova(mdl,'summary');
        av = table2array(av);
        res(ii,numel(ux)+kk)=mdl.MSE;        
        pval(ii, kk) = double(av(2,5));
        pint(ii, kk) = double(mv(1,4));
        px(ii, kk)=double(mv(2,4));
        page(ii, kk)=double(mv(3,4));
    end
    str = sprintf('Finish %d/%d', ii,size(seqs,1));
    disp(str);
end

