function varargout = boneage(varargin)
% BONEAGE MATLAB code for boneage.fig
%      BONEAGE, by itself, creates a new BONEAGE or raises the existing
%      singleton*.
%
%      H = BONEAGE returns the handle to a new BONEAGE or the handle to
%      the existing singleton*.
%
%      BONEAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BONEAGE.M with the given input arguments.
%
%      BONEAGE('Property','Value',...) creates a new BONEAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before boneage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to boneage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help boneage

% Last Modified by GUIDE v2.5 15-Nov-2018 11:47:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @boneage_OpeningFcn, ...
                   'gui_OutputFcn',  @boneage_OutputFcn, ...
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


% --- Executes just before boneage is made visible.
function boneage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to boneage (see VARARGIN)

% Choose default command line output for boneage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes boneage wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = boneage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
global choice;

contents = cellstr(get(hObject, 'String'));
pop_choice = contents{get(hObject, 'Value')};
if (strcmp(pop_choice, 'Single Image'))
    choice = 1;
elseif (strcmp(pop_choice, 'Multiple Images'))
    choice = 2;
else
    choice = 0;
end

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Sex_Callback(hObject, eventdata, handles)
% hObject    handle to Sex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sex as text
%        str2double(get(hObject,'String')) returns contents of Sex as a double


% --- Executes during object creation, after setting all properties.
function Sex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in train.
function train_Callback(hObject, eventdata, handles)
% hObject    handle to train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in test.
function test_Callback(hObject, eventdata, handles)
% hObject    handle to test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in get_img.
function get_img_Callback(hObject, eventdata, handles)
% hObject    handle to get_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% choice = 1 singal
% choice = 2 multi
global choice;
set(handles.img_name,'String',' ');
set(handles.predicted_age,'String',' ');
set(handles.Sex,'String',' ');
set(handles.accuracy,'String',' ');
if choice == 1
    [filename, pathname] = uigetfile('*.png', 'file select');
    path = strcat(pathname, filename);
    pic = imread(path);
    axes(handles.axes1);
    imshow(pic);
    id = split(filename, '.');
    pattern = fullfile(pathname, '*.csv');
    file = dir(pattern);
    base = file.name;
    full = fullfile(pathname, base);
    opts = detectImportOptions(full,'NumHeaderLines',1); % number of header lines which are to be ignored
    opts.VariableNamesLine = 1; % row number which has variable names
    opts.DataLine = 2; % row number from which the actual data starts
    data = readtable(full,opts);
    rows = data.Var1==str2double(id{1});
    match = data(rows,:);
    for i=1:length(match.Properties.VariableNames)
        if i == 1
            set(handles.img_name,'String',match.Var1);
        elseif i == 2 && length(match.Properties.VariableNames) == 3
           set(handles.predicted_age,'String',match.Var2);
        elseif i == 2 && length(match.Properties.VariableNames) == 2
           set(handles.Sex,'String',match.Var2);
        elseif i == 3
            if strcmp(match.Var3{1},'False')
                set(handles.Sex,'String','F');
            else
                set(handles.Sex,'String','M');
            end
        end
    end
elseif choice == 2
    path = uigetdir('/');
    pattern = fullfile(path, '*.png');
    files = dir(pattern);
    for i = 1: length(files)
        base = files(i).name;
        full = fullfile(path, base);
        pic = imread(full);
        axes(handles.axes1);
        imshow(pic);
        id = split(base, '.');
    pattern = fullfile(path, '*.csv');
    file = dir(pattern);
    base = file.name;
    full = fullfile(path, base);
    opts = detectImportOptions(full,'NumHeaderLines',1); % number of header lines which are to be ignored
    opts.VariableNamesLine = 1; % row number which has variable names
    opts.DataLine = 2; % row number from which the actual data starts
    data = readtable(full,opts);
    rows = data.Var1==str2double(id{1});
    match = data(rows,:);
    for i=1:length(match.Properties.VariableNames)
        if i == 1
            set(handles.img_name,'String',match.Var1);
        elseif i == 2 && length(match.Properties.VariableNames) == 3
           set(handles.predicted_age,'String',match.Var2);
        elseif i == 2 && length(match.Properties.VariableNames) == 2
           set(handles.Sex,'String',match.Var2);
        elseif i == 3
           if strcmp(match.Var3{1},'False')
                set(handles.Sex,'String','F');
            else
                set(handles.Sex,'String','M');
            end
        end
    end
    end
end


% --- Executes on button press in clean.
function clean_Callback(hObject, eventdata, handles)
% hObject    handle to clean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
