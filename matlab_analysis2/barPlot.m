clear;
v2_trace2;

%%
figure;
scatter(rs1501228_code, pc);
figure;
scatter(rs1501228_code, pp);
figure;
scatter(rs1501228_code, gc);

%%
pc_mu = zeros(3,1);
pc_sigma = zeros(3,1);
pc_ci_lower = zeros(3,1);
pc_ci_higher = zeros(3,1);

pp_mu = zeros(3,1);
pp_sigma = zeros(3,1);
pp_ci_lower = zeros(3,1);
pp_ci_higher = zeros(3,1);

gc_mu = zeros(3,1);
gc_sigma = zeros(3,1);
gc_ci_lower = zeros(3,1);
gc_ci_higher = zeros(3,1);

for ii=1:3
    index = find(rs1501228_code == (ii-1) );
    ext = pc(index);
    pd = fitdist(ext,'Normal');
    pc_mu(ii) = pd.mu;
    pc_sigma(ii) = pd.sigma;
    ci = paramci(pd);
    pc_ci_lower(ii) = ci(1,1);
    pc_ci_higher(ii) = ci(2,1);
end

for ii=1:3
    index = find(rs1501228_code == (ii-1) );
    ext = pp(index);
    pd = fitdist(ext,'Normal');
    pp_mu(ii) = pd.mu;
    pp_sigma(ii) = pd.sigma;
    ci = paramci(pd);
    pp_ci_lower(ii) = ci(1,1);
    pp_ci_higher(ii) = ci(2,1);
end

for ii=1:3
    index = find(rs1501228_code == (ii-1) );
    ext = gc(index);
    pd = fitdist(ext,'Normal');
    gc_mu(ii) = pd.mu;
    gc_sigma(ii) = pd.sigma;
    ci = paramci(pd);
    gc_ci_lower(ii) = ci(1,1);
    gc_ci_higher(ii) = ci(2,1);
end

%%
y = randn(3,4);         % random y values (3 groups of 4 parameters) 
  errY = 0.1.*y;          % 10% error
   h = barwitherr(errY, y);% Plot with errorbars
%%

%%
clear;
v2_trace3;

figure;
scatter(rs1946867_code, pc);
figure;
scatter(rs1946867_code, pp);
figure;
scatter(rs1946867_code, gc);

%%
clear;
v2_trace1;

figure;
scatter(rs4149286_code, pc);
figure;
scatter(rs4149286_code, pp);
figure;
scatter(rs4149286_code, gc);

