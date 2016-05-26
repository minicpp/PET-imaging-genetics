function [ output_args ] = DrawSampleBar( diseaseChangeMap )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
hFig = figure;

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

set(hFig, 'Position', [100 100 1000 200])
end

