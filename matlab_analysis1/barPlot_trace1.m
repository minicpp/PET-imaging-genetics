clear;
v2_trace1;
trace_code = rs1876152_code


group_num = 3

%%
pc_mu = zeros(group_num,1);
pc_sigma = zeros(group_num,1);
pc_ci_lower = zeros(group_num,1);
pc_ci_higher = zeros(group_num,1);
pc_error = zeros(group_num,1);

pp_mu = zeros(group_num,1);
pp_sigma = zeros(group_num,1);
pp_ci_lower = zeros(group_num,1);
pp_ci_higher = zeros(group_num,1);
pp_error = zeros(group_num,1);

gc_mu = zeros(group_num,1);
gc_sigma = zeros(group_num,1);
gc_ci_lower = zeros(group_num,1);
gc_ci_higher = zeros(group_num,1);
gc_error = zeros(group_num,1);

for ii=1:group_num
    index = find( trace_code == (ii-1) );
    ext = pc(index);
    pd = fitdist(ext,'Normal');
    pc_mu(ii) = pd.mu;
    pc_sigma(ii) = pd.sigma;
    ci = paramci(pd);
    pc_ci_lower(ii) = ci(1,1);
    pc_ci_higher(ii) = ci(2,1);
    pc_error(ii) = (ci(2,1) - ci(1,1))/2
end

%%

for ii=1:group_num
    index = find(trace_code == (ii-1) );
    ext = pp(index);
    pd = fitdist(ext,'Normal');
    pp_mu(ii) = pd.mu;
    pp_sigma(ii) = pd.sigma;
    ci = paramci(pd);
    pp_ci_lower(ii) = ci(1,1);
    pp_ci_higher(ii) = ci(2,1);
    pp_error(ii) = (ci(2,1) - ci(1,1))/2
end

%%
for ii=1:group_num
    index = find(trace_code == (ii-1) );
    ext = gc(index);
    pd = fitdist(ext,'Normal');
    gc_mu(ii) = pd.mu;
    gc_sigma(ii) = pd.sigma;
    ci = paramci(pd);
    gc_ci_lower(ii) = ci(1,1);
    gc_ci_higher(ii) = ci(2,1);
    gc_error(ii) = (ci(2,1) - ci(1,1))/2
end

%%
y = [pc_mu,pp_mu,gc_mu] %3 group, each group for an XX alleles

errY = [pc_error,pp_error,gc_error]
h = barwitherr(errY, y);% Plot with errorbars
set(gca,'XTickLabel',{'GG','GA','AA'})
legend('Pos-cingulate','Pos-precuneus','GlobalCortex','Location', 'northwest')
%legend('Pos-cingulate','Pos-precuneus','Global-cortex')
%ylabel('SUVR(FDG) mean difference between diagnosis transitions')
ylabel('SUVR(FDG) difference')
xlabel('SNP genotyping on rs1876152')
set(h(1),'FaceColor','y');
%set(h(1),'FaceColor', [0.027, 0.988, 0.859]);
set(h(3),'FaceColor', [0.008, 0.78, 0.984]);
hFig = figure(1);
set(hFig, 'Position', [0 0 600 300])
set(gca,'fontsize', 15);
%%



