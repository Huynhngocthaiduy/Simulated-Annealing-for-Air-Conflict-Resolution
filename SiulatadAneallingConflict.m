clc
tic
DeltaAverage = 19;
alpha = 0.99;
T_initial=DeltaAverage/0.2231;
[Data,Cost]=Text2Matrix('cluster_20ac_2err_2.txt');
[Data1,Data2,Data3,Data4]=size(Data);
S = randi([1 151],1,Data1);
C = CountConflicts(S,Data);

while T_initial > 0.001
 for i=1:1000
    [SNew, Delta] = FindNeighborDelta(S,Data);
if (Delta <= 0)||(rand < exp(-Delta/T_initial))
    S=SNew;
    C=C+Delta;
end
 end
T_initial = T_initial*alpha;
[T_initial,C]
end
[S,C,sum(Cost(S))]
toc