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

% Last Modified by GUIDE v2.5 17-Nov-2018 11:30:14

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
files = dir(pwd);
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);
set(handles.lb,'string',{subFolders.name});
%set(handles.lb,'string',line);
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

% --- Executes on selection change in DATALOAD.
function DATALOAD_Callback(hObject, eventdata, handles)
% hObject    handle to DATALOAD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns DATALOAD contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DATALOAD
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
function DATALOAD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DATALOAD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Predict_Callback(hObject, eventdata, handles)
% hObject    handle to Predict (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Predict as text
%        str2double(get(hObject,'String')) returns contents of Predict as a double


% --- Executes during object creation, after setting all properties.
function Predict_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Predict (see GCBO)
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
all = get(handles.lb,'String');
idx = get(handles.lb,'value');
set(handles.img_name,'String',' ');
set(handles.age,'String',' ');
set(handles.Predict,'String',' ');
set(handles.Sex,'String',' ');
axes(handles.axes1); cla;
if idx > 3
    path = all{idx};
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
        data = readtable(full,'Delimiter',',','ReadVariableNames',false);
        rows = data.Var1==str2double(id{1});
        match = data(rows,:);
        line = zeros(1,length(match.Properties.VariableNames),'uint32');
        count = 1;
        for i=1:length(match.Properties.VariableNames)
            if i == 1
                set(handles.img_name,'String',match.Var1);
                line(1,count) = match.Var1;
                count=count+1;
            elseif i == 2 && length(match.Properties.VariableNames) == 3
               set(handles.age,'String',match.Var2);
               line(1,count) = match.Var2;
               count=count+1;
            elseif i == 2 && length(match.Properties.VariableNames) == 2
               set(handles.Sex,'String',match.Var2);
               if strcmp(match.Var2,'F')
                line(1,count) = false;
               else
                   line(1,count) = true;
               end
               count=count+1;
            elseif i == 3
               if strcmp(match.Var3{1},'False')
                    set(handles.Sex,'String','F');
                    line(1,count) = false;
                    count=count+1;
                else
                    set(handles.Sex,'String','M');
                    line(1,count) = true;
                    count=count+1;
                end
            end
        end
    end
end

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
disp(choice);
set(handles.img_name,'String',' ');
set(handles.age,'String',' ');
set(handles.Predict,'String',' ');
set(handles.Sex,'String',' ');
axes(handles.axes1); cla;
files = dir(pwd);
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);
num = length(subFolders);
fileN = strcat('dataset',num2str(num));
if choice > 0
    mkdir(fileN);
end
if choice == 1
    cd(fileN);
    [filename, pathname] = uigetfile('*.png', 'file select');
    path = strcat(pathname, filename);
    pic = imread(path);
    axes(handles.axes1);
    pic = histeq(pic);
        % convert to bw
        img = im2bw(pic, 0.6);
        % mask
        se = strel('disk',10);
        mask = imopen(img,se);
        mask = imresize(mask, 0.25);
        pic = imresize(pic, 0.25);
        [row,column,~] = size(mask);

        for i = 1:row
            for j = 1: column
                if mask(i,j) == 0
                    pic(i,j) = 0;
                end
            end
        end
    imshow(pic);
    imwrite(pic, filename);
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
    line = zeros(1,length(match.Properties.VariableNames),'uint32');
    count = 1;
    for i=1:length(match.Properties.VariableNames)
        if i == 1
            set(handles.img_name,'String',match.Var1);
            line(1,count) = match.Var1;
            count=count+1;
        elseif i == 2 && length(match.Properties.VariableNames) == 3
           set(handles.age,'String',match.Var2);
           line(1,count) = match.Var2;
           count=count+1;
        elseif i == 2 && length(match.Properties.VariableNames) == 2
           set(handles.Sex,'String',match.Var2);
           if strcmp(match.Var2,'F')
               line(1,count) = false;
           else
               line(1,count) = true;
           end
           count=count+1;
        elseif i == 3
            if strcmp(match.Var3{1},'False')
                set(handles.Sex,'String','F');
                line(1,count) = false;
                count=count+1;
            else
                set(handles.Sex,'String','M');
                line(1,count) = true;
                count=count+1;
            end
        end
    end
    dlmwrite('dataset.csv',line,'-append','delimiter',',','roffset',0)
    cd ..;
elseif choice == 2
    cd(fileN);
    path = uigetdir();
    pattern = fullfile(path, '*.png');
    files = dir(pattern);
    for i = 1: length(files)
        base = files(i).name;
        full = fullfile(path, base);
        pic = imread(full);
        axes(handles.axes1);
        pic = histeq(pic);
        % convert to bw
        img = im2bw(pic, 0.6);
        % mask
        se = strel('disk',10);
        mask = imopen(img,se);
        mask = imresize(mask, 0.25);
        pic = imresize(pic, 0.25);
        [row,column,~] = size(mask);

        for i = 1:row
            for j = 1: column
                if mask(i,j) == 0
                    pic(i,j) = 0;
                end
            end
        end
        imwrite(pic, base);
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
        line = zeros(1,length(match.Properties.VariableNames),'uint32');
        count = 1;
        for i=1:length(match.Properties.VariableNames)
            if i == 1
                set(handles.img_name,'String',match.Var1);
                line(1,count) = match.Var1;
                count=count+1;
            elseif i == 2 && length(match.Properties.VariableNames) == 3
               set(handles.age,'String',match.Var2);
               line(1,count) = match.Var2;
               count=count+1;
            elseif i == 2 && length(match.Properties.VariableNames) == 2
               set(handles.Sex,'String',match.Var2);
               if strcmp(match.Var2,'F')
                line(1,count) = false;
               else
                   line(1,count) = true;
               end
               count=count+1;
            elseif i == 3
               if strcmp(match.Var3{1},'False')
                    set(handles.Sex,'String','F');
                    line(1,count) = false;
                    count=count+1;
                else
                    set(handles.Sex,'String','M');
                    line(1,count) = true;
                    count=count+1;
                end
            end
        end
        dlmwrite('dataset.csv',line,'-append','delimiter',',','roffset',0)
    end
    cd ..;
end
files = dir(pwd);
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);
set(handles.lb,'string',{subFolders.name});



% --- Executes on button press in clean.
function clean_Callback(hObject, eventdata, handles)
% hObject    handle to clean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in DATA.
function DATA_Callback(hObject, eventdata, handles)
% hObject    handle to DATA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns DATA contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DATA
a='you';b='are';c='crazy';
s={a,b,c};
set(handles.DATA,'string',s)
contents = cellstr(get(hObject, 'String'));
pop_choice = contents{get(hObject, 'Value')};
disp(pop_choice);

% --- Executes during object creation, after setting all properties.
function DATA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DATA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lb.
function lb_Callback(hObject, eventdata, handles)
% hObject    handle to lb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lb contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb


% --- Executes during object creation, after setting all properties.
function lb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
