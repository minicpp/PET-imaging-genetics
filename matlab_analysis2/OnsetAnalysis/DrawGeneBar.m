function [ output_args ] = DrawGeneBar( diseaseChangeMap, genName, a1, a2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
hFig = figure;

[normalNum1, normalRatio1] = SelectGene(diseaseChangeMap('Normal'), genName, a1);
[normalNum2, normalRatio2] = SelectGene(diseaseChangeMap('Normal'), genName, a2);

[mciNum1, mciRatio1] = SelectGene(diseaseChangeMap('MCI'), genName, a1);
[mciNum2, mciRatio2] = SelectGene(diseaseChangeMap('MCI'), genName, a2);

[mci_adNum1, mci_adRatio1] = SelectGene(diseaseChangeMap('MCI-AD'), genName, a1);
[mci_adNum2, mci_adRatio2] = SelectGene(diseaseChangeMap('MCI-AD'), genName, a2);

[mci_nlNum1, mci_nlRatio1] = SelectGene(diseaseChangeMap('MCI-NL'), genName, a1);
[mci_nlNum2, mci_nlRatio2] = SelectGene(diseaseChangeMap('MCI-NL'), genName, a2);

[nl_mciNum1, nl_mciRatio1] = SelectGene(diseaseChangeMap('NL-MCI'), genName, a1);
[nl_mciNum2, nl_mciRatio2] = SelectGene(diseaseChangeMap('NL-MCI'), genName, a2);


[nl_adNum1, nl_adRatio1] = SelectGene(diseaseChangeMap('NL-AD'),genName, a1);
[nl_adNum2, nl_adRatio2] = SelectGene(diseaseChangeMap('NL-AD'),genName, a2);

[nl_mci_adNum1, nl_mci_adRatio1] = SelectGene(diseaseChangeMap('NL-MCI-MCI-AD'),genName, a1);
[nl_mci_adNum2, nl_mci_adRatio2] = SelectGene(diseaseChangeMap('NL-MCI-MCI-AD'),genName, a2);

[nl_mciadNum1, nl_mciadRatio1] = SelectGene(diseaseChangeMap('NL-MCI/AD'),genName, a1);
[nl_mciadNum2, nl_mciadRatio2] = SelectGene(diseaseChangeMap('NL-MCI/AD'),genName, a2);

yy = bar([normalRatio1 normalRatio2; mciRatio1 mciRatio2; mci_adRatio1 mci_adRatio2; mci_nlRatio1 mci_nlRatio2; ...,
    nl_mciRatio1 nl_mciRatio2; nl_adRatio1 nl_adRatio2; nl_mci_adRatio1 nl_mci_adRatio2; ...,
    nl_mciadRatio1 nl_mciadRatio2]);
ylabel('Ratio');
x_loc = get(yy, 'XData');
y_height = get(yy, 'YData');
% text(x_loc,y_height',num2str(y_height','%0.2f'),... 
% 'HorizontalAlignment','center',... 
% 'VerticalAlignment','bottom');
set(gca,'XTickLabel',{'Normal', 'MCI', 'MCI-AD', 'MCI-NL', 'NL-MCI', 'NL-AD', 'NL-MCI-MCI-AD', 'NL-MCI/AD'})
set(hFig, 'Position', [100 100 1000 400])

end

