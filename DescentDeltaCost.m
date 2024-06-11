clc
tic
cd('Donnee')
[Data,Cost]=Text2Matrix('cluster_20ac_3err_4.txt');
cd ../
[Data1,Data2,Data3,Data4]=size(Data);
S = randi([1 151],1,Data1);
Conflict = CountConflicts(S,Data);
SumCost = sum(Cost(S)); 
G=[];
i=1;g=0;
DeltaOut = zeros(4,2);
Out = zeros(4,2);

   switch(Data1)
   case 5 
      Gout=7000;Iout=1000000;
   case 10 
      Gout=90000;Iout=1500000;
   case 15
      Gout=140000; Iout=2000000;
   case 20
      Gout=200000; Iout=1500000;
   end
 Graph=[];  
while (g < Gout)&&(i < Iout)
    [SNew, DeltaConf, DeltaSumCost] = FindNeighborDeltaCost(S,Data,Cost);
    %((DeltaConf <= 0)&&(Conflict > 0))||((DeltaSumCost <= 0)&&(DeltaConf == 0))
    %(DeltaConf<0) || (DeltaCost<=0 && DeltaConf==0)
if (DeltaConf<0) || (DeltaSumCost<=0 && DeltaConf==0)
    G=[G,g];
    S=SNew;
    Conflict = Conflict + DeltaConf;
    SumCost = SumCost + DeltaSumCost;
    G=[i,Conflict, SumCost]
    Graph = [Graph;G];
    g=0;
else
  g=g+1;
 end
i=i+1;

end % end while;
