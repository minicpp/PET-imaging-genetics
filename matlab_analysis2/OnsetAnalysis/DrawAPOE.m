function [  ] = DrawAPOE( set_NL_MCI_AD, set_MCI_AD, apoeType )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
resLength1 = length(set_NL_MCI_AD);
x1 = zeros(resLength1, 1);
y1 = zeros(resLength1, 1);
resLength2 = length(set_MCI_AD);
x2 = zeros(resLength2, 1);
y2 = zeros(resLength2, 1);
for i=1:resLength1
    x1(i) = set_NL_MCI_AD{i}.apoe(apoeType);
    y1(i) = set_NL_MCI_AD{i}.ageOnSet;
end

for i=1:resLength2
    x2(i) = set_MCI_AD{i}.apoe(apoeType);
    y2(i) = set_MCI_AD{i}.ageOnSet;
end

figure;
plot(x1,y1,'rx',x2,y2,'bs');
xStr = sprintf('The number of APOE \\epsilon-%d', apoeType);

xlabel(xStr);
ylabel('Onset age');
set(gca,'XTick',0:2);
xlim([-1 3]);
legend('Normal to MCI/AD','MCI to AD','Location','best');

DrawAPOEErrorBar(set_NL_MCI_AD, apoeType, 'Normal to MCI/AD');
DrawAPOEErrorBar(set_MCI_AD, apoeType,'MCI to AD');

end

