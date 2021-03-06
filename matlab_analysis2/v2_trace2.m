%% Import data from text file.
% Script for importing data from the following text file:
%
%    /home/mat/adni/data/allele/v2_trace_2_alleles.csv
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2015/01/12 00:51:19

%% Initialize variables.
filename = '/home/mat/adni/data/allele/v2_trace_2_alleles.csv';
delimiter = '\t';
startRow = 2;

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,3,5,6,7,8,9,10,11,13,15,17,19,21,23,25,27,29]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end


%% Split data into numeric and cell columns.
rawNumericColumns = raw(:, [1,3,5,6,7,8,9,10,11,13,15,17,19,21,23,25,27,29]);
rawCellColumns = raw(:, [2,4,12,14,16,18,20,22,24,26,28]);


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),rawNumericColumns); % Find non-numeric cells
rawNumericColumns(R) = {NaN}; % Replace non-numeric cells

%% Allocate imported array to column variable names
FID = cell2mat(rawNumericColumns(:, 1));
IID = rawCellColumns(:, 1);
bin = cell2mat(rawNumericColumns(:, 2));
cat1 = rawCellColumns(:, 2);
pp = cell2mat(rawNumericColumns(:, 3));
pc = cell2mat(rawNumericColumns(:, 4));
gc = cell2mat(rawNumericColumns(:, 5));
sex = cell2mat(rawNumericColumns(:, 6));
age = cell2mat(rawNumericColumns(:, 7));
weight = cell2mat(rawNumericColumns(:, 8));
race = cell2mat(rawNumericColumns(:, 9));
rs1501228 = rawCellColumns(:, 3);
rs1501228_code = cell2mat(rawNumericColumns(:, 10));
rs12565755 = rawCellColumns(:, 4);
rs12565755_code = cell2mat(rawNumericColumns(:, 11));
rs12408850 = rawCellColumns(:, 5);
rs12408850_code = cell2mat(rawNumericColumns(:, 12));
rs1946867 = rawCellColumns(:, 6);
rs1946867_code = cell2mat(rawNumericColumns(:, 13));
rs3905886 = rawCellColumns(:, 7);
rs3905886_code = cell2mat(rawNumericColumns(:, 14));
rs9951577 = rawCellColumns(:, 8);
rs9951577_code = cell2mat(rawNumericColumns(:, 15));
rs4149286 = rawCellColumns(:, 9);
rs4149286_code = cell2mat(rawNumericColumns(:, 16));
rs343248 = rawCellColumns(:, 10);
rs343248_code = cell2mat(rawNumericColumns(:, 17));
rs4149284 = rawCellColumns(:, 11);
rs4149284_code = cell2mat(rawNumericColumns(:, 18));


%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me rawNumericColumns rawCellColumns R;