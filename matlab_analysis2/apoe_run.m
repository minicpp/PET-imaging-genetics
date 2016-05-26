clear;
[IID,bin,apoe,cat1,pp,pc,gc,sex,age,weight,race] = import_apoe_t1('/home/mat/adni/apoe/apoe_trace_1.csv');
t1 = [bin,apoe,pp,pc,gc,sex,age,weight,race];
t1 = removerows(t1,'ind',[32]); %remove outlier
[M,I]=max(t1);

[IID,bin,apoe,cat1,pp,pc,gc,sex,age,weight,race] = import_apoe_t1('/home/mat/adni/apoe/apoe_trace_2.csv');
t2 = [bin,apoe,pp,pc,gc,sex,age,weight,race];

[IID,bin,apoe,cat1,pp,pc,gc,sex,age,weight,race] = import_apoe_t1('/home/mat/adni/apoe/apoe_trace_3.csv');
t3 = [bin,apoe,pp,pc,gc,sex,age,weight,race];

%%
plotDistribution(t1(:,2), t1(:,[3,4,5]), {'trace 1 pp';'trace 1 pc';'trace 1 gc'});
plotDistribution(t2(:,2), t2(:,[3,4,5]), {'trace 2 pp';'trace 2 pc';'trace 2 gc'});
plotDistribution(t3(:,2), t3(:,[3,4,5]), {'trace 3 pp';'trace 3 pc';'trace 3 gc'});

%calcRegressionCat(t1(:,2), t1(:,7), t1(:,[3:5]));
%calcRegressionCat(t2(:,2), t2(:,7), t2(:,[3:5]));
%calcRegressionCat(t3(:,2), t3(:,7), t3(:,[3:5]));


%%
%calcRegressionSub(4, t2(:,2), t2(:,7), t2(:,[3:5]) );
calcRegressionAllCovs(t1(:,2), t1(:,7), t1(:,[3:5]), 't1.csv');
calcRegressionAllCovs(t2(:,2), t2(:,7), t2(:,[3:5]), 't2.csv' );
calcRegressionAllCovs(t3(:,2), t3(:,7), t3(:,[3:5]), 't3.csv' );

%[res1, pval1, pint1, px1, page1] = calcRegression(t1(:,2), t1(:,7), t1(:,[3:5]));
%[res2, pval2, pint2, px2, page2] = calcRegression(t2(:,2), t2(:,7), t2(:,[3:5]));
%[res3, pval3, pint3, px3, page3] = calcRegression(t3(:,2), t3(:,7), t3(:,[3:5]));
%%
%regstats(rec(:,5), rec(:,3));

%regress
