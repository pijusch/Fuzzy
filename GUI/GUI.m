function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 24-Nov-2016 00:44:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

w = warning('off','all');
%digits(4); % precision
if(exist('logo.jpg','file'))
    axes(handles.axes1);
    imshow('logo.jpg');
end
set(handles.axes1,'visible','off');
set(handles.calculate,'Enable','inactive');
% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of file as text
%        str2double(get(hObject,'String')) returns contents of file as a double


% --- Executes during object creation, after setting all properties.
function file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of browse as text
%        str2double(get(hObject,'String')) returns contents of browse as a double

try
    [filename , path] = uigetfile({'*.xlsx'},'Select file');

    if(~isempty(filename))
        set(handles.file,'string',strcat(path,filename));
        set(handles.calculate,'Enable','on');
    end
catch
end
handles.ifile = filename;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function browse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
digits(4);
fullpath = get(handles.file,'string');
if(isempty(fullpath))
    msgbox('Invalid file path');
    error('Invalid file path');
end

ip_choice_val =  get(handles.formatpanel,'SelectedObject');
ip_choice = get(ip_choice_val,'string');
payoff_val = 0;

if(strcmp(ip_choice,'CRISP DATA'))
    input1  = xlsread(fullpath,'Sheet1');
    input2 = input1;
    input3 = input1;
    input1d = input1;
    input3d = input1;
    payoff_val = 1;
elseif(strcmp(ip_choice,'TFN'))
    input1  = xlsread(fullpath,'Sheet1');
    input2  = xlsread(fullpath,'Sheet2');
    input3  = xlsread(fullpath,'Sheet3');
    input1d = input1;
    input3d = input3;
    payoff_val = 2;
elseif(strcmp(ip_choice,'ITFN'))
    input1  = xlsread(fullpath,'Sheet1');
    input2  = xlsread(fullpath,'Sheet2');
    input3  = xlsread(fullpath,'Sheet3');
    input1d = xlsread(fullpath,'Sheet4');
    input3d = xlsread(fullpath,'Sheet5');
    payoff_val = 3;
else
    msgbox('Input selection wrong');
    error('Input selection wrong');
end

if(~isequal(size(input1),size(input2),size(input3),size(input1d),size(input3d)))
    msgbox('Input data size from file mismatch !!');
    error('Input data size from file mismatch !!');
end
% Parameters extraction
n = size(input1,1);     % Num of DMUs
inp = get(handles.numip,'string');
op = get(handles.numop,'string');

try
    if(isempty(inp) | isempty(op))
        msgbox('Input/Output field empty');
        error('Input/Output field empty');
    end

num_ip = str2num(inp);  % Num of Inputs
num_op = str2num(op);  % Num of Outputs

    if(num_ip+num_op ~= size(input1,2))
        msgbox('Invalid number of inputs/ouputs');
        error('invalid number of inputs/outputs');
    end

if(get(handles.numip,'string')==0 | get(handles.numop,'string')==0)
    fprintf('Hello');
    msgbox('Invalid input/output');
end

% Function calling
choice_array = get(handles.popup,'string');
method_choice = choice_array{get(handles.popup,'Value')};

output= [1:n]';     % DMU numbers
rank = [];
col_header={};
switch(method_choice)
    case 'Super-Efficiency (Optimistic)'
        SEO = SOIFDEA(input1 ,input2 ,input3 ,input1d ,input3d,n,num_ip,num_op);
        SEO = SEO';
        OE = min(1.0000,SEO);
        output = [output,OE,SEO];
        rank = findRanks(SEO,'descend');
        col_header  = {'DMU','Eff Optimistic','SE Optimistic','Rank'};
        
    case 'Super-Efficiency (Pessimistic)'
        SEP = SPIFDEA(input1 ,input2 ,input3 ,input1d ,input3d,n,num_ip,num_op);
        SEP = SEP';
        PE = max(1.0000,SEP);
        output = [output,PE,SEP];
        rank = findRanks(SEP,'descend');
        col_header  = {'DMU','Eff Pessimistic','SE Pessimistic','Rank'};
        
    case 'Deviation from max (Method 1)'
        OE = OIFDEA(input1 ,input2 ,input3 ,input1d ,input3d,n,num_ip,num_op);
        OE = OE';
        PE = PIFDEA(input1 ,input2 ,input3 ,input1d ,input3d,n,num_ip,num_op);
        PE = PE';
        mx_op  = max(OE);
        mx_pes = max(PE);
        DO  = mx_op - OE;
        DP = mx_pes - PE;
        Dev = DO+DP;
        output = [output,OE,PE,DO,DP,Dev];
        rank = findRanks(Dev,'ascend');
        col_header  = {'DMU','Optimistic Eff.(OE)','Pessimistic Eff.(PE)','Deviation from opt_max(DO)','Deviation from pess_max(DP)','Dev=(DO+DP)','Rank'};
        
    case 'Deviation from min (Method 2)'
        OE = OIFDEA(input1 ,input2 ,input3 ,input1d ,input3d,n,num_ip,num_op);
        OE = OE';
        PE = PIFDEA(input1 ,input2 ,input3 ,input1d ,input3d,n,num_ip,num_op);
        PE = PE';
        min_op  = min(OE);
        min_pes = min(PE);
        DO =  OE - min_op;
        DP =  PE - min_pes;
        Dev = DO+DP;
        output = [output,OE,PE,DO,DP,Dev];
        rank = findRanks(Dev,'descend');
        col_header  = {'DMU','Optimistic Eff.(OE)','Pessimistic Eff.(PE)','Deviation from opt_min(DO)','Deviation from pess_min(DP)','Dev=(DO+DP)','Rank'};
        
    case 'Geometric Avg. Efficiency Method'
        OE = OIFDEA(input1 ,input2 ,input3 ,input1d ,input3d,n,num_ip,num_op);
        OE = OE';
        PE = PIFDEA(input1 ,input2 ,input3 ,input1d ,input3d,n,num_ip,num_op);
        PE = PE';
        E_geo = sqrt(OE.*PE);
        output = [output,OE,PE,E_geo];
        rank = findRanks(E_geo,'descend');
        col_header = {'DMU','Optimistic Eff.(OE)','Pessimistic Eff.(PE)','Geo. Eff. = sqrt(OE*PE)','Rank'};
end

% Ranking
output = str2num(num2str(output,'%0.4f'));
result = [output ,rank];

[sfile,spath] = uiputfile('*.xlsx','Save as',[method_choice,'__' ,handles.ifile]);
delete([spath,sfile]);
% WRITE Efficiency Results
xlswrite([spath,sfile],result,'Sheet1','A2');
xlswrite([spath,sfile],col_header,'Sheet1','A1');

% PAYOFF MATRIX
payoff = {};

for i=1:size(input1,1)
    for j=1:size(input1,2)
        if(payoff_val==1)   % CRISP
            payoff{i,j} = sprintf('%0.4d',input1(i,j));
        elseif(payoff_val==2) % TFN
            %payoff{i,j} = sprintf('%d,%d,%d',input1(i,j),input2(i,j),input3(i,j));
             payoff{i,j} = sprintf('%0.4f,%0.4f,%0.4f;%0.4f,%0.4f',input1(i,j),input2(i,j),input3(i,j),input1d(i,j),input3d(i,j));
        elseif(payoff_val==3) % ITFN
            payoff{i,j} = sprintf('%0.4f,%0.4f,%0.4f;%0.4f,%0.4f',input1(i,j),input2(i,j),input3(i,j),input1d(i,j),input3d(i,j));
        end
    end
end

pay_head = {};
for i=1:num_ip
    pay_head = {pay_head{:},sprintf('Input %d',i)};
end

for i=1:num_op
    pay_head = {pay_head{:},sprintf('Output %d',i)};
end

% WRITE PAYOFF MATRIX
xlswrite([spath,sfile],pay_head,'Sheet2','A1');
xlswrite([spath,sfile],payoff,'Sheet2','A2');

% MODIFY SHEET NAMES
e = actxserver('Excel.Application');            % # open Activex server
ewb = e.Workbooks.Open([spath,sfile]);          % # open file (enter full path!)
ewb.Worksheets.Item(1).Name = 'EFF. & RANK';    % # rename 1st sheet
ewb.Worksheets.Item(2).Name = 'PAYOFF_MATRIX';
%ewb.Worksheets.Item(1).Name = 'EFF. & RANK'; 
ewb.Save % # save to the same file
ewb.Close(false)
e.Quit

% delete(ms);
ms = msgbox('File written successfully');
ah = get(ms,'CurrentAxes');
ch = get(ah,'Children');
set(ch,'FontSize',10);
catch
end

% --- Executes during object deletion, before destroying properties.
function tagip_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to tagip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function numip_Callback(hObject, eventdata, handles)
% hObject    handle to numip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numip as text
%        str2double(get(hObject,'String')) returns contents of numip as a double


% --- Executes during object creation, after setting all properties.
function numip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function numop_Callback(hObject, eventdata, handles)
% hObject    handle to numop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numop as text
%        str2double(get(hObject,'String')) returns contents of numop as a double


% --- Executes during object creation, after setting all properties.
function numop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on file and none of its controls.
function file_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popup.
function popup_Callback(hObject, eventdata, handles)
% hObject    handle to popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup


% --- Executes during object creation, after setting all properties.
function popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in help.
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
winopen('helpfile.pdf');
