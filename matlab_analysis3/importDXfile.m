function [Phase,ID,RID,SITEID,VISCODE,VISCODE2,USERDATE,USERDATE2,EXAMDATE,DXCHANGE,DXCURREN,DXCONV,DXCONTYP,DXREV,DXNORM,DXNODEP,DXMCI,DXMDES,DXMPTR1,DXMPTR2,DXMPTR3,DXMPTR4,DXMPTR5,DXMPTR6,DXMDUE,DXMOTHET,DXMOTHSP,DXDSEV,DXDDUE,DXAD,DXADES,DXAPP,DXAPROB,DXAMETASP,DXAOTHRSP,DXAPOSS,DXAATYSP,DXAMETSP,DXAOTHSP,DXPARK,DXPARKSP,DXPDES,DXPCOG,DXPATYP,DXPOTHSP,DXDEP,DXDEPSP,DXOTHDEM,DXODES,DXOOTHSP,DXCONFID,update_stamp] = importDXfile(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [PHASE,ID,RID,SITEID,VISCODE,VISCODE2,USERDATE,USERDATE2,EXAMDATE,DXCHANGE,DXCURREN,DXCONV,DXCONTYP,DXREV,DXNORM,DXNODEP,DXMCI,DXMDES,DXMPTR1,DXMPTR2,DXMPTR3,DXMPTR4,DXMPTR5,DXMPTR6,DXMDUE,DXMOTHET,DXMOTHSP,DXDSEV,DXDDUE,DXAD,DXADES,DXAPP,DXAPROB,DXAMETASP,DXAOTHRSP,DXAPOSS,DXAATYSP,DXAMETSP,DXAOTHSP,DXPARK,DXPARKSP,DXPDES,DXPCOG,DXPATYP,DXPOTHSP,DXDEP,DXDEPSP,DXOTHDEM,DXODES,DXOOTHSP,DXCONFID,UPDATE_STAMP]
%   = IMPORTFILE(FILENAME) Reads data from text file FILENAME for the
%   default selection.
%
%   [PHASE,ID,RID,SITEID,VISCODE,VISCODE2,USERDATE,USERDATE2,EXAMDATE,DXCHANGE,DXCURREN,DXCONV,DXCONTYP,DXREV,DXNORM,DXNODEP,DXMCI,DXMDES,DXMPTR1,DXMPTR2,DXMPTR3,DXMPTR4,DXMPTR5,DXMPTR6,DXMDUE,DXMOTHET,DXMOTHSP,DXDSEV,DXDDUE,DXAD,DXADES,DXAPP,DXAPROB,DXAMETASP,DXAOTHRSP,DXAPOSS,DXAATYSP,DXAMETSP,DXAOTHSP,DXPARK,DXPARKSP,DXPDES,DXPCOG,DXPATYP,DXPOTHSP,DXDEP,DXDEPSP,DXOTHDEM,DXODES,DXOOTHSP,DXCONFID,UPDATE_STAMP]
%   = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from rows STARTROW
%   through ENDROW of text file FILENAME.
%
% Example:
%   [Phase,ID,RID,SITEID,VISCODE,VISCODE2,USERDATE,USERDATE2,EXAMDATE,DXCHANGE,DXCURREN,DXCONV,DXCONTYP,DXREV,DXNORM,DXNODEP,DXMCI,DXMDES,DXMPTR1,DXMPTR2,DXMPTR3,DXMPTR4,DXMPTR5,DXMPTR6,DXMDUE,DXMOTHET,DXMOTHSP,DXDSEV,DXDDUE,DXAD,DXADES,DXAPP,DXAPROB,DXAMETASP,DXAOTHRSP,DXAPOSS,DXAATYSP,DXAMETSP,DXAOTHSP,DXPARK,DXPARKSP,DXPDES,DXPCOG,DXPATYP,DXPOTHSP,DXDEP,DXDEPSP,DXOTHDEM,DXODES,DXOOTHSP,DXCONFID,update_stamp] = importfile('DXSUM_PDXCONV_ADNIALL.csv',2, 9233);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2015/05/22 00:25:14

%% Initialize variables.
delimiter = ',';
if nargin<=2
    startRow = 2;
    endRow = inf;
end

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3,4,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,30,31,32,33,34,35,36,37,38,39,40,42,43,44,45,48,49,50,51]
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
rawNumericColumns = raw(:, [1,2,3,4,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,30,31,32,33,34,35,36,37,38,39,40,42,43,44,45,48,49,50,51]);
rawCellColumns = raw(:, [5,6,7,8,9,10,28,29,41,46,47,52]);


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),rawNumericColumns); % Find non-numeric cells
rawNumericColumns(R) = {NaN}; % Replace non-numeric cells

%% Allocate imported array to column variable names
Phase = cell2mat(rawNumericColumns(:, 1));
ID = cell2mat(rawNumericColumns(:, 2));
RID = cell2mat(rawNumericColumns(:, 3));
SITEID = cell2mat(rawNumericColumns(:, 4));
VISCODE = rawCellColumns(:, 1);
VISCODE2 = rawCellColumns(:, 2);
USERDATE = rawCellColumns(:, 3);
USERDATE2 = rawCellColumns(:, 4);
EXAMDATE = rawCellColumns(:, 5);
DXCHANGE = rawCellColumns(:, 6);
DXCURREN = cell2mat(rawNumericColumns(:, 5));
DXCONV = cell2mat(rawNumericColumns(:, 6));
DXCONTYP = cell2mat(rawNumericColumns(:, 7));
DXREV = cell2mat(rawNumericColumns(:, 8));
DXNORM = cell2mat(rawNumericColumns(:, 9));
DXNODEP = cell2mat(rawNumericColumns(:, 10));
DXMCI = cell2mat(rawNumericColumns(:, 11));
DXMDES = cell2mat(rawNumericColumns(:, 12));
DXMPTR1 = cell2mat(rawNumericColumns(:, 13));
DXMPTR2 = cell2mat(rawNumericColumns(:, 14));
DXMPTR3 = cell2mat(rawNumericColumns(:, 15));
DXMPTR4 = cell2mat(rawNumericColumns(:, 16));
DXMPTR5 = cell2mat(rawNumericColumns(:, 17));
DXMPTR6 = cell2mat(rawNumericColumns(:, 18));
DXMDUE = cell2mat(rawNumericColumns(:, 19));
DXMOTHET = cell2mat(rawNumericColumns(:, 20));
DXMOTHSP = cell2mat(rawNumericColumns(:, 21));
DXDSEV = rawCellColumns(:, 7);
DXDDUE = rawCellColumns(:, 8);
DXAD = cell2mat(rawNumericColumns(:, 22));
DXADES = cell2mat(rawNumericColumns(:, 23));
DXAPP = cell2mat(rawNumericColumns(:, 24));
DXAPROB = cell2mat(rawNumericColumns(:, 25));
DXAMETASP = cell2mat(rawNumericColumns(:, 26));
DXAOTHRSP = cell2mat(rawNumericColumns(:, 27));
DXAPOSS = cell2mat(rawNumericColumns(:, 28));
DXAATYSP = cell2mat(rawNumericColumns(:, 29));
DXAMETSP = cell2mat(rawNumericColumns(:, 30));
DXAOTHSP = cell2mat(rawNumericColumns(:, 31));
DXPARK = cell2mat(rawNumericColumns(:, 32));
DXPARKSP = rawCellColumns(:, 9);
DXPDES = cell2mat(rawNumericColumns(:, 33));
DXPCOG = cell2mat(rawNumericColumns(:, 34));
DXPATYP = cell2mat(rawNumericColumns(:, 35));
DXPOTHSP = cell2mat(rawNumericColumns(:, 36));
DXDEP = rawCellColumns(:, 10);
DXDEPSP = rawCellColumns(:, 11);
DXOTHDEM = cell2mat(rawNumericColumns(:, 37));
DXODES = cell2mat(rawNumericColumns(:, 38));
DXOOTHSP = cell2mat(rawNumericColumns(:, 39));
DXCONFID = cell2mat(rawNumericColumns(:, 40));
update_stamp = rawCellColumns(:, 12);


