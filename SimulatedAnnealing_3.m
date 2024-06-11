clc
clear all;
tic
% Parametres setup----------------------------
Percent=0.5;alpha = 0.99;
cd('Donnee')
[Data,Cost]=Text2Matrix('cluster_20ac_1err_2.txt');
cd ../
[Data1,Data2,Data3,Data4]=size(Data);
%Initial temperate of cost--------------------
DeltaCostMax =max(Cost) ;
%TCost_initial=-DeltaCostMax/log(Percent);
TCost_initial=-19/log(Percent);
%--------------------------------------------
S = randi([1 151],1,Data1);
Conflict = CountConflicts(S,Data);
SumCost = sum(Cost(S)); 
T_initial = TCost_initial;
Graph=[];
Sbest=S;
ConfBest=CountConflicts(Sbest,Data);CostBest=sum(Cost(Sbest)); 
while (T_initial > 0.001)
  for i=1:1500
    [SNew, DeltaConf, DeltaSumCost] = FindNeighborDeltaCost(S,Data,Cost);
    if ((CountConflicts(SNew,Data)< ConfBest)||(sum(Cost(SNew))< CostBest)&&((CountConflicts(SNew,Data)==0)))
         Sbest = SNew;
         ConfBest=CountConflicts(Sbest,Data);CostBest=sum(Cost(Sbest));
    end
     Bool = ((DeltaConf <= 0)&&(Conflict > 0))||((DeltaSumCost <= 0)&&(DeltaConf == 0));
     Prob = max([Bool,min([exp(-DeltaConf/(T_initial)),exp(-DeltaSumCost/(T_initial*100))])]);
    %[ DeltaConf, DeltaSumCost,exp(-DeltaConf/TConf_initial),exp(-DeltaSumCost/TCost_initial),Bool, Prob]
    if rand < Prob
    S=SNew;
    Conflict = Conflict + DeltaConf;
    SumCost = SumCost + DeltaSumCost;
    end
    
  end %end for
G=[T_initial,Conflict,SumCost,CountConflicts(Sbest,Data),sum(Cost(Sbest))]
Graph = [Graph;G];
T_initial=T_initial*alpha ;
end % end while
   if (CountConflicts(Sbest,Data)<=CountConflicts(S,Data))&&(sum(Cost(Sbest))<=sum(Cost(S)))
    S=Sbest;
   end
[CountConflicts(S,Data),sum(Cost(S))]
toc





