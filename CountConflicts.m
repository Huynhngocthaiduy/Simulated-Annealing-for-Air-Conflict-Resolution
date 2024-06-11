function C = CountConflicts( Solution,Data) 
C=0;
[DSol1,DSol2]=size(Solution);
  for i=1:DSol2-1
    for j=i+1:DSol2
        C=C+Data(i,j,Solution(i),Solution(j));
        %if Data(i,j,Solution(i),Solution(j))==1
         %   [i,j,Solution(i),Solution(j)]
    end
  end
end