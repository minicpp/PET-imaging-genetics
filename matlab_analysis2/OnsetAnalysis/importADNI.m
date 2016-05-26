%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: D:\mydoc\research\adni\program\matlab\OnsetAnalysis\ADNI6y _MasterDB_VBM8.xls
%    Worksheet: PET&MR
%
% To extend the code for use with different selected data or a different
% spreadsheet, generate a function instead of a script.

% Auto-generated by MATLAB on 2015/04/26 17:41:26

%% Import the data, extracting spreadsheet dates in Excel serial date format
[~, ~, raw, dates] = xlsread('ADNI6y _MasterDB_VBM8.xls','PET&MR','A2:BQ823','',@convertSpreadsheetExcelDates);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,9,10,13,18,19,20]);
raw = raw(:,[2,3,4,5,6,7,8,11,12,14,17,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69]);
dates = dates(:,[15,16]);

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),dates); % Find non-numeric cells
dates(R) = {NaN}; % Replace non-numeric Excel dates with NaN

%% Create output variable
data = reshape([raw{:}],size(raw));

%% Allocate imported array to column variable names
SubjectID = cellVectors(:,1);
Sex = data(:,1);
Weight = data(:,2);
Ethnicity = data(:,3);
Race = data(:,4);
Educationyears = data(:,5);
APOEA2 = data(:,6);
APOEA1 = data(:,7);
DXGroup = cellVectors(:,2);
Changeofdiagnosis = cellVectors(:,3);
Diagnosistransition = data(:,8);
CSF = data(:,9);
Visit = cellVectors(:,4);
Tscan = data(:,10);
ArchiveDate = datetime([dates{:,1}].', 'ConvertFrom', 'Excel', 'Format', 'MM/dd/yyyy');
StudyDate = datetime([dates{:,2}].', 'ConvertFrom', 'Excel', 'Format', 'MM/dd/yyyy');
Age = data(:,11);
ABETA = cellVectors(:,5);
TAU = cellVectors(:,6);
PTAU = cellVectors(:,7);
TAU_ABETA = data(:,12);
PTAU_ABETA = data(:,13);
ADAScogTOTAL11 = data(:,14);
ADAScogTOTALMOD = data(:,15);
GlobalCDR = data(:,16);
NPIQTotalScore = data(:,17);
MMSETotalScore = data(:,18);
FunctionalAssessmentQuestionnaireTotalScore = data(:,19);
GDSCALETotalScore = data(:,20);
Tracer = data(:,21);
ObiFronCo = data(:,22);
PreFrontal = data(:,23);
SupFronCo = data(:,24);
LatTemporal = data(:,25);
MedTemporal = data(:,26);
Parietal = data(:,27);
PosPrecuneus = data(:,28);
AntCingulate = data(:,29);
PosCingulate = data(:,30);
Occipital = data(:,31);
GlobalCortex = data(:,32);
Amygdala = data(:,33);
Hippocampus = data(:,34);
Caudate = data(:,35);
Caudate_LR = data(:,36);
Putamen = data(:,37);
Putamen_LR = data(:,38);
Putamen_L = data(:,39);
Putamen_R = data(:,40);
Putamen_LA = data(:,41);
Putamen_LP = data(:,42);
Putamen_RA = data(:,43);
Putamen_RP = data(:,44);
VST = data(:,45);
VST_LR = data(:,46);
Thalamus = data(:,47);
Raphe = data(:,48);
RapheDorsal = data(:,49);
Raphenuclei = data(:,50);
SubstantiaNigra = data(:,51);
MidBrain = data(:,52);
Pons = data(:,53);
Medulla = data(:,54);
CentrumSemiovale = data(:,55);
GrayMatter_VBM8 = data(:,56);
WhiteMatter_VBM8 = data(:,57);
BrainMask_GM_WM_CSF = data(:,58);
PETname_nii = data(:,59);
Cereb = data(:,60);

% For code requiring serial dates (datenum) instead of datetime, uncomment
% the following line(s) below to return the imported dates as datenum(s).

% ArchiveDate=datenum(ArchiveDate);
% StudyDate=datenum(StudyDate);

%% Clear temporary variables
clearvars data raw dates cellVectors R;