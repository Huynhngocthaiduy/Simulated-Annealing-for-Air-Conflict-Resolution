for n=1:5
tic

[Data,Cost]=Text2Matrix('cluster_20ac_2err_2.txt');
[Data1,Data2,Data3,Data4]=size(Data);
S = randi([1 151],1,Data1);
C = CountConflicts(S,Data);
i=0;
while C ~= 0
i=i+1;
SNew = FindNeighbor(S);
CNew = CountConflicts(SNew,Data);
if CNew <= C
    S=SNew;
    C=CNew;
end
end
S
toc
end