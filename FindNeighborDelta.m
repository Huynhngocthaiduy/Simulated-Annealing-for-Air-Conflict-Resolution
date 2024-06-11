function [NewSol Delta]= FindNeighborDelta(Solution,Data);
[DSol1,DSol2]=size(Solution);
 B=randi(DSol2);% choose aircraft
 A= randi([1 151]);% choose maneuver
 NewSol = Solution;
 NewSol(B) = A;
 NewConflict=0;
 OldConflict=0;
for k=1:DSol2 
 
    OldConflict= OldConflict+Data(B,k,Solution(B),Solution(k));
    NewConflict= NewConflict+Data(B,k,NewSol(B),NewSol(k));

end

Delta=NewConflict-OldConflict;


end