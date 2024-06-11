function [Data, Cost]= Text2Matrix(filename);
FileID = fopen(filename,'rt');
OneLine = fgets(FileID);
Dimensions = str2num(OneLine(2:end));
Data = zeros(Dimensions(1),Dimensions(1),Dimensions(2),Dimensions(2));
Cost=zeros(1,151);
j=1;
while ischar(OneLine)
    OneLine = fgets(FileID);
 if OneLine(1)=='c'
     Num = str2num(OneLine(2:end));
     D1=Num(1)+1;
     D2=Num(2)+1;
     D3=Num(3)+1;
   for i=4:length(Num)
       Data(D1,D2,D3,Num(i)+1)=1;
       Data(D2,D1,Num(i)+1,D3)=1;
   end
 end
 if OneLine(1)=='m'
    Costfull = str2num(OneLine(2:end));
    Cost(j)=Costfull(2);
    j=j+1;
 end
end
fclose(FileID);
clear D1 D2 D3 ;
end