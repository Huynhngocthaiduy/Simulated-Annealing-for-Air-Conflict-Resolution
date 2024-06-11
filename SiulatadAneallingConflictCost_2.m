
tic
clear all
alpha = 0.995;
Percent=0.8;
[Data,Cost]=Text2Matrix('cluster_20ac_2err_2.txt');
[Data1,Data2,Data3,Data4]=size(Data);
%Initial temperature conflicts---------
Mcost=max(Cost);
DeltaConfMax= 19*Mcost/2 ;
T_initial=-DeltaConfMax/log(Percent);
%---------------------------------------
S = randi([1 151],1,Data1);
Conflict = CountConflicts(S,Data);
SumCost = sum(Cost(S)); 
Graph=[];
Sbest=S;
ConfBest=CountConflicts(Sbest,Data);CostBest=sum(Cost(Sbest)); 
while (T_initial > 0.01)
  for i=1:2000
    [SNew, DeltaConf, DeltaSumCost] = FindNeighborDeltaCost(S,Data,Cost);
    Delta = DeltaConf*Mcost + DeltaSumCost;
    if ((CountConflicts(SNew,Data)*Mcost+(sum(Cost(SNew))< CostBest)&&((CountConflicts(SNew,Data)==0)))
         Sbest = SNew;
         ConfBest=CountConflicts(Sbest,Data);CostBest=sum(Cost(Sbest));
    end
    Prob = min([1,exp(-Delta/(T_initial))]);
    if rand < Prob
    S=SNew;
    Conflict = Conflict + DeltaConf;
    SumCost = SumCost + DeltaSumCost;
   
    end
    
  end
[T_initial,Conflict,SumCost]
 T_initial=T_initial*alpha ;

end % end while;
 [Conflict,SumCost]
 toc
end