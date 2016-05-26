function [ output_args ] = DrawBar( diseaseChangeMap )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
hFig = figure;
subplot(2,1,1);
yy = bar([ ...,
    length(diseaseChangeMap('Normal')), ...,
    length(diseaseChangeMap('MCI')), ...,
    length(diseaseChangeMap('MCI-AD')), ...,
    length(diseaseChangeMap('MCI-NL')), ...,
    length(diseaseChangeMap('NL-MCI')), ...,
    length(diseaseChangeMap('NL-AD')), ...,    
    length(diseaseChangeMap('NL-MCI-MCI-AD')), ...,
    length(diseaseChangeMap('NL-MCI/AD')), ...,
    ]);
x_loc = get(yy, 'XData');
y_height = get(yy, 'YData');
ylabel('Number of subjects');
text(x_loc,y_height',num2str(y_height','%0.2f'),... 
'HorizontalAlignment','center',... 
'VerticalAlignment','bottom');
set(gca,'XTickLabel',{'Normal', 'MCI', 'MCI-AD', 'MCI-NL', 'NL-MCI', 'NL-AD', 'NL-MCI-MCI-AD', 'NL-MCI/AD'})

subplot(2,1,2);
[normalNum, normalRatio] = SelectAPOE(diseaseChangeMap('Normal'), 4);
[mciNum, mciRatio] = SelectAPOE(diseaseChangeMap('MCI'), 4);
[mci_adNum, mci_adRatio] = SelectAPOE(diseaseChangeMap('MCI-AD'), 4);
[mci_nlNum, mci_nlRatio] = SelectAPOE(diseaseChangeMap('MCI-NL'), 4);
[nl_mciNum, nl_mciRatio] = SelectAPOE(diseaseChangeMap('NL-MCI'), 4);
[nl_adNum, nl_adRatio] = SelectAPOE(diseaseChangeMap('NL-AD'), 4);
[nl_mci_adNum, nl_mci_adRatio] = SelectAPOE(diseaseChangeMap('NL-MCI-MCI-AD'), 4);
[nl_mciadNum, nl_mciadRatio] = SelectAPOE(diseaseChangeMap('NL-MCI/AD'), 4);
yy = bar([normalRatio,mciRatio,mci_adRatio,mci_nlRatio,nl_mciRatio,nl_adRatio,nl_mci_adRatio,nl_mciadRatio]);
ylabel('Ratio of APOE Epsilon-4');
x_loc = get(yy, 'XData');
y_height = get(yy, 'YData');
text(x_loc,y_height',num2str(y_height','%0.2f'),... 
'HorizontalAlignment','center',... 
'VerticalAlignment','bottom');
set(gca,'XTickLabel',{'Normal', 'MCI', 'MCI-AD', 'MCI-NL', 'NL-MCI', 'NL-AD', 'NL-MCI-MCI-AD', 'NL-MCI/AD'})
set(hFig, 'Position', [100 100 1000 400])
end

