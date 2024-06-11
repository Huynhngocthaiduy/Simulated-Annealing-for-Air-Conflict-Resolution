function [NewSol, DeltaConflict, DeltaCost]= FindNeighborDeltaCost(Solution,Data,Cost)
 DSol2=size(Solution,2);
 B=randi(DSol2);% choose aircraft
 A=Solution(B);
 while A==Solution(B)
 A= randi([1 151]);% choose maneuver
 end
 NewSol = Solution;
 NewSol(B) = A;
 NewConflict=0;
 OldConflict=0;
for k=1:DSol2 
 
    OldConflict= OldConflict+Data(B,k,Solution(B),Solution(k));
    NewConflict= NewConflict+Data(B,k,NewSol(B),NewSol(k));

end
DeltaCost = Cost(A)- Cost(Solution(B));
DeltaConflict=NewConflict-OldConflict;


end