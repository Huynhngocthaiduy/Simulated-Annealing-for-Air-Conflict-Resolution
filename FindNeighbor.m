function NewSol = FindNeighbor(Solution);
[DSol1,DSol2]=size(Solution);
 B=randi(DSol2);
 A= randi([1 151]);
 NewSol = Solution;
 NewSol(B) = A;
end

