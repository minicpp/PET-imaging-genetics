function [ dataset ] = LoadGene( dataset )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

for i=keys(dataset)
    subIDStr = char(i);
    info = dataset(subIDStr); 
    info.rs1876152=[];
    info.rs1501228=[];
    info.rs1946867=[];
    dataset(subIDStr)=info;
end

v2_trace1;

for i=1:length(IID)
    subID = char(IID{i});
    info = dataset(subID);
    info.rs1876152=char(rs1876152{i});
    dataset(subID)=info;
end

v2_trace2;
for i=1:length(IID)
    subID = char(IID{i});
    info = dataset(subID);
    info.rs1501228=rs1501228{i};
    dataset(subID)=info;
end

v2_trace3;
for i=1:length(IID)
    subID = char(IID{i});
    info = dataset(subID);
    info.rs1946867=char(rs1946867{i});
    dataset(subID)=info;
end

end

