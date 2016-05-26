function [ output_args ] = DrawAPOEErrorBar( dataset, apoeType,legendStr )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
resLength = length(dataset);
x = zeros(resLength, 1);
y = zeros(resLength, 1);

for i=1:resLength
    x(i) = dataset{i}.apoe(apoeType);
    y(i) = dataset{i}.ageOnSet;
end

figure; % plot error bar
errorX=[];
errorY=[];
E=[];
for i=0:2
    ix = find(x == i);
    if length(ix) > 0
        errorX=[errorX;i];
        if length(ix) > 1 % more than 1 samples
            resY = y(ix);
            pd = fitdist(resY,'Normal');
            ci = paramci(pd); % 95% interval
            
            errorY=[errorY;pd.mu];
            E=[E;pd.mu-ci(1)];
        else
            errorY=[errorY; y(ix)]; % only 1 sample
            E=[E;0];
        end
    end
end
errorbar(errorX, errorY, E, 'bx');
set(gca,'XTick',0:2);
xlim([-1 3]);
xStr = sprintf('The number of APOE \\epsilon-%d', apoeType);
xlabel(xStr);
ylabel('Onset age');
legend(legendStr,'Location','best');

figure;
boxplot(y,x);
xStr = sprintf('The number of APOE Epsilon-%d for %s', apoeType, legendStr);
xlabel(xStr);
ylabel('Onset age');

x = cell(resLength,1);
for i=1:resLength
     res = dataset{i}.apoe(apoeType);
     if res == 0
         x{i} = 'non-existing';
     else
         x{i} = 'existing';
     end
end

figure; % figure for existence/non-existence of a specific gen
boxplot(y,x,'grouporder',{'non-existing','existing'});

xStr = sprintf('The existence of APOE Epsilon-%d for %s', apoeType, legendStr);
xlabel(xStr);
ylabel('Onset age');

end

