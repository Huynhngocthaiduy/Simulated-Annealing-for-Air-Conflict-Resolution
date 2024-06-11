function varargout = Presentation(varargin)
% PRESENTATION MATLAB code for Presentation.fig
%      PRESENTATION, by itself, creates a new PRESENTATION or raises the existing
%      singleton*.
%
%      H = PRESENTATION returns the handle to a new PRESENTATION or the handle to
%      the existing singleton*.
%
%      PRESENTATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRESENTATION.M with the given input arguments.
%
%      PRESENTATION('Property','Value',...) creates a new PRESENTATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Presentation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Presentation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Presentation

% Last Modified by GUIDE v2.5 10-Feb-2017 03:31:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Presentation_OpeningFcn, ...
                   'gui_OutputFcn',  @Presentation_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Presentation is made visible.
function Presentation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Presentation (see VARARGIN)

% Choose default command line output for Presentation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Presentation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Presentation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in openfile.
function openfile_Callback(hObject, eventdata, handles)% OPEN---------------------------------------------------------
clc;
cd('Donnee');
[FileName,PathName] = uigetfile('*.txt','Select the MATLAB code file');
[Data,Cost]=Text2Matrix(FileName);
[Side1,Side2,Side3,Side4]=size(Data);
set(handles.text1,'String',Side3);
set(handles.text3,'String',Side1);
set(handles.FileName,'String',FileName);
cd ../;
handles.Data=Data;
guidata(hObject, handles);
handles.SumCost=Cost;
guidata(hObject, handles);



% --- Executes on button press in
% Descent1.---------------------------------------------------------------------------------------------------------
function Descent1_Callback(hObject, eventdata, handles)
tic
Data = handles.Data;
Cost = handles.SumCost;
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
      Gout=7000;Iout=800000;
   case 10 
      Gout=90000;Iout=800000;
   case 15
      Gout=140000; Iout=1000000;
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
    G=[i,Conflict, SumCost];
    Graph = [Graph;G];
    g=0;
    pause(0.00000001);
      Text1= num2str(S);
      set(handles.Solution,'String', Text1);
      set(handles.NumberofConflict,'String', Conflict);
      set(handles.Scost, 'String',SumCost);
      set(handles.Time, 'String',toc); 
else     
  g=g+1;
 end
i=i+1;
end % end while;
hold off
plot(Graph(:,2));
hold on;
plot(Graph(:,3)/10);
title('Number of conflict and the total cost in Descent method (First acceptance Condition)');
xlabel('Time') % x-axis label
ylabel('Number of Conflict (blue)-Total Cost (orange)') % y-axis label

S


% --- Executes on button press in pushbutton3.
% Descent 2----------------------------------------------------------------
function pushbutton3_Callback(hObject, eventdata, handles)
tic
Data = handles.Data;
Cost = handles.SumCost;
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
      Gout=7000;Iout=800000;
   case 10 
      Gout=90000;Iout=800000;
   case 15
      Gout=140000; Iout=1000000;
   case 20
      Gout=200000; Iout=1500000;
   end
 Graph=[];  
while (g < Gout)&&(i < Iout)
    [SNew, DeltaConf, DeltaSumCost] = FindNeighborDeltaCost(S,Data,Cost);
    %((DeltaConf <= 0)&&(Conflict > 0))||((DeltaSumCost <= 0)&&(DeltaConf == 0))
    %(DeltaConf<0) || (DeltaCost<=0 && DeltaConf==0)
if ((DeltaConf <= 0)&&(Conflict > 0))||((DeltaSumCost <= 0)&&(DeltaConf == 0))
    G=[G,g];
    S=SNew;
    Conflict = Conflict + DeltaConf;
    SumCost = SumCost + DeltaSumCost;
    G=[i,Conflict, SumCost];
    Graph = [Graph;G];
    g=0;
    pause(0.00000001);
      Text1= num2str(S);
      set(handles.Solution,'String', Text1);
      set(handles.NumberofConflict,'String', Conflict);
      set(handles.Scost, 'String',SumCost);
      set(handles.Time, 'String',toc); 
else     
  g=g+1;
 end
i=i+1;
end % end while;
hold off
plot(Graph(:,2));
hold on;
plot(Graph(:,3)/10);
title('Number of conflict and the total cost in Descent method (Second acceptance Condition)');
xlabel('Time') % x-axis label
ylabel('Number of Conflict (blue)-Total Cost (orange)') % y-axis label

S 


% --- Executes on button press in
% SA1.---------------------------------------------------------------------
function SA1_Callback(hObject, eventdata, handles)
tic
Percent=0.5;alpha = 0.99;
Data = handles.Data;
Cost = handles.SumCost;
[Data1,Data2,Data3,Data4]=size(Data);
%Initial temperate of cost--------------
DeltaCostMax =max(Cost) ;
TCost_initial=-DeltaCostMax/log(Percent);
%---------------------------------------
S = randi([1 151],1,Data1);
%S=151*ones(1,Data1);
Conflict = CountConflicts(S,Data);
SumCost = sum(Cost(S)); 
T_initial = TCost_initial;
Graph=[];
Sbest=S;
 ConfBest=CountConflicts(Sbest,Data);CostBest=sum(Cost(Sbest)); 
while (T_initial > 0.005)
    rng('shuffle') ;
  for i=1:2000
   
     [SNew, DeltaConf, DeltaSumCost] = FindNeighborDeltaCost(S,Data,Cost);
     if ((CountConflicts(SNew,Data)< ConfBest)||(sum(Cost(SNew))< CostBest)&&((CountConflicts(SNew,Data)==0)))
         Sbest = SNew;
         ConfBest=CountConflicts(Sbest,Data);CostBest=sum(Cost(Sbest));
    end
     Prob = min([1,exp(-DeltaConf/(T_initial*0.5))])*min([1,exp(-DeltaSumCost/(T_initial*45))]);   
    if rand < Prob
      S=SNew;
      Conflict = Conflict + DeltaConf;
      SumCost = SumCost + DeltaSumCost;
    end
    
  end
T_initial=T_initial*alpha ;
 pause(0.00000001);
      Text1= num2str(S);
      set(handles.Solution,'String', Text1);
      set(handles.NumberofConflict,'String', Conflict);
      set(handles.Scost, 'String',SumCost);
      set(handles.Time, 'String',toc); 
      set(handles.Temperature, 'String',T_initial); 
      Text4= num2str([CountConflicts(Sbest,Data),sum(Cost(Sbest))]);
      set(handles.BestStored, 'String',Text4); 
G=[T_initial,Conflict,SumCost];
Graph = [Graph;G];
end % end while;
[CountConflicts(S,Data),sum(Cost(S))]
   if (CountConflicts(Sbest,Data)<=CountConflicts(S,Data))&&(sum(Cost(Sbest))<=sum(Cost(S)))
    S=Sbest;
   end
      Text1= num2str(S);
      set(handles.Solution,'String', Text1);
      Text2=num2str(CountConflicts(S,Data));
      set(handles.NumberofConflict,'String', Text2);
       Text3=num2str(sum(Cost(S)));
      set(handles.Scost, 'String',Text3);

hold off
plot(Graph(:,2));
hold on;
plot(Graph(:,3)/10);
title('Number of conflict and the total cost in Simulated Annealing (First acceptance Condition)');
xlabel('Time') % x-axis label
ylabel('Number of Conflict (blue)-Total Cost (orange)') % y-axis label

S
   


% --- Executes on button press in SA2.-------------------------------------
function SA2_Callback(hObject, eventdata, handles)
Percent=0.5;alpha=0.99;
Data = handles.Data;
Cost = handles.SumCost;
[Data1,Data2,Data3,Data4]=size(Data);
%Initial temperature conflicts---------
Mcost=max(Cost);
DeltaConfMax= Mcost ;
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
    if ((CountConflicts(SNew,Data)< ConfBest)||(sum(Cost(SNew))< CostBest)&&((CountConflicts(SNew,Data)==0)))
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

 T_initial=T_initial*alpha ;
pause(0.00000001);
      Text1= num2str(S);
      set(handles.Solution,'String', Text1);
      set(handles.NumberofConflict,'String', Conflict);
      set(handles.Scost, 'String',SumCost);
      set(handles.Time, 'String',toc); 
      set(handles.Temperature, 'String',T_initial); 
      Text4= num2str([CountConflicts(Sbest,Data),sum(Cost(Sbest))]);
      set(handles.BestStored, 'String',Text4); 
G=[T_initial,Conflict,SumCost];
Graph = [Graph;G];
end % end while;
[CountConflicts(S,Data),sum(Cost(S))]
   if (CountConflicts(Sbest,Data)<=CountConflicts(S,Data))&&(sum(Cost(Sbest))<=sum(Cost(S)))
    S=Sbest;
   end
      Text1= num2str(S);
      set(handles.Solution,'String', Text1);
      Text2=num2str(CountConflicts(S,Data));
      set(handles.NumberofConflict,'String', Text2);
       Text3=num2str(sum(Cost(S)));
      set(handles.Scost, 'String',Text3);

hold off
plot(Graph(:,2));
hold on;
plot(Graph(:,3)/10);
title('Number of conflict and the total cost in Simulated Annealing (Second acceptance Condition)');
xlabel('Time') % x-axis label
ylabel('Number of Conflict (blue)-Total Cost (orange)') % y-axis label


% --- Executes on button press in SA3.-------------------------------------
function SA3_Callback(hObject, eventdata, handles)
tic
Data = handles.Data;
Cost = handles.SumCost;
Percent=0.5;alpha = 0.99;
[Data1,Data2,Data3,Data4]=size(Data);
%Initial temperature conflicts---------
DeltaConfMax= 19;
TConf_initial=-DeltaConfMax/log(Percent);
%Initial temperate of cost--------------
DeltaCostMax =max(Cost) ;

TCost_initial=DeltaCostMax/log(Percent);
%---------------------------------------
S = randi([1 151],1,Data1);
Conflict = CountConflicts(S,Data);
SumCost = sum(Cost(S)); 
w=TCost_initial/TConf_initial;
T_initial = TConf_initial;
 Graph=[];
 Sbest=S;
 ConfBest=CountConflicts(Sbest,Data);CostBest=sum(Cost(Sbest));
 
while (T_initial > 0.01)
  for i=1:3000
    
    [SNew, DeltaConf, DeltaSumCost] = FindNeighborDeltaCost(S,Data,Cost);
    if ((CountConflicts(SNew,Data)< ConfBest)||(sum(Cost(SNew))< CostBest)&&((CountConflicts(SNew,Data)==0)))
         Sbest = SNew;
         ConfBest=CountConflicts(Sbest,Data);CostBest=sum(Cost(Sbest));
    end
    
     Bool = ((DeltaConf <= 0)&&(Conflict > 0))||((DeltaSumCost <= 0)&&(DeltaConf == 0));
     Prob = max([Bool,min([exp(-DeltaConf/(T_initial)),exp(-DeltaSumCost/(T_initial*50))])]);
    
    if rand < Prob
    S=SNew;
    Conflict = Conflict + DeltaConf;
    SumCost = SumCost + DeltaSumCost;
    end
    
  end
 T_initial=T_initial*alpha ;
pause(0.00000001);
      Text1= num2str(S);
      set(handles.Solution,'String', Text1);
      set(handles.NumberofConflict,'String', Conflict);
      set(handles.Scost, 'String',SumCost);
      set(handles.Time, 'String',toc); 
      set(handles.Temperature, 'String',T_initial); 
      Text4= num2str([CountConflicts(Sbest,Data),sum(Cost(Sbest))]);
      set(handles.BestStored, 'String',Text4); 
G=[T_initial,Conflict,SumCost];
Graph = [Graph;G];
end % end while;
[CountConflicts(S,Data),sum(Cost(S))]
   if (CountConflicts(Sbest,Data)<=CountConflicts(S,Data))&&(sum(Cost(Sbest))<=sum(Cost(S)))
    S=Sbest;
   end
      Text1= num2str(S);
      set(handles.Solution,'String', Text1);
      Text2=num2str(CountConflicts(S,Data));
      set(handles.NumberofConflict,'String', Text2);
       Text3=num2str(sum(Cost(S)));
      set(handles.Scost, 'String',Text3);

hold off
plot(Graph(:,2));
hold on;
plot(Graph(:,3)/10);
title('Number of conflict and the total cost in Simulated Annealing (Third acceptance Condition)');
xlabel('Time') % x-axis label
ylabel('Number of Conflict (blue)-Total Cost (orange)') % y-axis label
[CountConflicts(S,Data),sum(Cost(S))]
   if (CountConflicts(Sbest,Data)<=CountConflicts(S,Data))&&(sum(Cost(Sbest))<=sum(Cost(S)))
    S=Sbest;
   end
[CountConflicts(S,Data),sum(Cost(S))]
