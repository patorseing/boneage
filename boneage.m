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

% Last Modified by GUIDE v2.5 28-Nov-2018 02:51:16

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
set(handles.lb2,'string',{subFolders.name});
set(handles.lb4,'string',{subFolders.name});
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



function predict_Callback(hObject, eventdata, handles)
% hObject    handle to predict (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of predict as text
%        str2double(get(hObject,'String')) returns contents of predict as a double


% --- Executes during object creation, after setting all properties.
function predict_CreateFcn(hObject, eventdata, handles)
% hObject    handle to predict (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in test.
function test_Callback(hObject, eventdata, handles)
% hObject    handle to test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
train = get(handles.lb2,'String');
idx2 = get(handles.lb2,'value');
test = get(handles.lb,'String');
idx = get(handles.lb,'value');
set(handles.img_name,'String',' ');
set(handles.age,'String',' ');
set(handles.predict,'String',' ');
set(handles.accuracy,'String',' ');
axes(handles.axes1); cla;
total = 0;
if idx > 3 & idx2 > 3 & idx ~= idx2 
    set(handles.img_name,'String',' ');
    set(handles.age,'String',' ');
    set(handles.predict,'String',' ');
    set(handles.accuracy,'String',' ');
    trainpath = train{idx};
    testpath = test{idx2};
    pattern = fullfile(trainpath, '*.png');
    trainfiles = dir(pattern);
    pattern = fullfile(testpath, '*.png');
    testfiles = dir(pattern);
    for i = 1: length(testfiles)
        line = [];
        xt = 0;
        xmea = 0;
        base = testfiles(i).name;
        full = fullfile(testpath, base);
        pic = imread(full);
        axes(handles.axes1);
        imshow(pic);
        originalImg = [];
        compareMat = [];
        featuresI = extractLBPFeatures(pic,'Upright',false);
        id = split(base, '.');
        pattern = fullfile(testpath, '*.csv');
        file = dir(pattern);
        base = file.name;
        full = fullfile(testpath, base);
        data = readtable(full,'Delimiter',',','ReadVariableNames',false);
        rows = data.Var1==str2double(id{1});
        match = data(rows,:);
        set(handles.img_name,'String',match.Var1);
        line = [line uint64(match.Var1)];
        if length(match.Properties.VariableNames) == 2
            xt = ceil(match.Var2/12);
            set(handles.age,'String',xt);
            line = [line xt];
        end
        tic
        for j = 1: length(trainfiles)
            base = trainfiles(j).name;
            full = fullfile(trainpath, base);
            pic = imread(full);
            originalImg = [originalImg {full}];
            featuresK = extractLBPFeatures(pic,'Upright',false);
            compare = (featuresI-featuresK).^2;
            [row,column] = size(featuresI);
            d1 = 0;
            for k=1:column
                d1 = d1 + ((featuresI(k) - featuresK(k))^2);
            end
            d1 = sqrt(d1);
            compareMat = [compareMat d1];
            axes(handles.axes3);
            imshow(pic);
        end
        toc
        if min(compareMat) == 0
            out = min(setdiff(compareMat,min(compareMat)));
            [row,col] = find(compareMat==out);
        else
            [out, col] = min(compareMat); 
        end
        pic = imread(char(originalImg(col)));
        axes(handles.axes3);
        imshow(pic);
        disp(char(originalImg(col)));
        disp(out);
        if contains(char(originalImg(col)),'\')
            base = split(char(originalImg(col)), '\');
        else
            base = split(char(originalImg(col)), '/');
        end
        id = split(base(2), '.')
        pattern = fullfile(trainpath, '*.csv');
        file = dir(pattern);
        base = file.name;
        full = fullfile(trainpath, base);
        data = readtable(full,'Delimiter',',','ReadVariableNames',false);
        rows = data.Var1==str2double(id{1});
        line = [line uint64(str2num(id{1}))];
        match = data(rows,:);
        if length(match.Properties.VariableNames) == 2
            xmea = ceil(match.Var2/12);
            set(handles.predict,'String',xmea);
            line = [line xmea];
            % load gong;
            % sound(y,Fs);
            accuracy = 100 - (abs(xmea - xt) / max(xt,xmea) * 100);
            set(handles.accuracy,'String',accuracy);
            line = [line accuracy];
            total = total + accuracy;
        end
        disp(line);
        dlmwrite('resultEU.csv',line,'-append','delimiter',',','roffset',0)
    end
    total = total / length(testfiles);
    dlmwrite('resultEU.csv',total,'-append','delimiter',',','roffset',0)
end


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
set(handles.predict,'String',' ');
set(handles.accuracy,'String',' ');
axes(handles.axes1); cla;
axes(handles.axes3); cla;
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
    pic = imresize(pic, .5);
    pic = imadjust(pic);
    axes(handles.axes1);
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
    line = [];
    for i=1:length(match.Properties.VariableNames)
        if i == 1
            set(handles.img_name,'String',match.Var1);
            line = [line match.Var1];
        elseif i == 2 && length(match.Properties.VariableNames) == 3
           set(handles.age,'String',match.Var2);
           line = [line match.Var2];
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
        pic = imresize(pic, .5);
        pic = imadjust(pic);
        axes(handles.axes1);
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
        line = [];
        for i=1:length(match.Properties.VariableNames)
            if i == 1
                set(handles.img_name,'String',match.Var1);
                line = [line match.Var1];
            elseif i == 2 && length(match.Properties.VariableNames) == 3
               set(handles.age,'String',match.Var2);
               line = [line match.Var2];
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
set(handles.lb2,'string',{subFolders.name});
set(handles.lb4,'string',{subFolders.name});



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


% --- Executes on selection change in lb2.
function lb2_Callback(hObject, eventdata, handles)
% hObject    handle to lb2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lb2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb2


% --- Executes during object creation, after setting all properties.
function lb2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lb4.
function lb4_Callback(hObject, eventdata, handles)
% hObject    handle to lb4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lb4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb4


% --- Executes during object creation, after setting all properties.
function lb4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in NN.
function NN_Callback(hObject, eventdata, handles)
% hObject    handle to NN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load model;
test = get(handles.lb4,'String');
idx = get(handles.lb4,'value');
set(handles.img_name,'String',' ');
set(handles.age,'String',' ');
set(handles.predict,'String',' ');
set(handles.accuracy,'String',' ');
axes(handles.axes1); cla;
axes(handles.axes3); cla;
if idx > 3
    set(handles.img_name,'String',' ');
    set(handles.age,'String',' ');
    set(handles.predict,'String',' ');
    set(handles.accuracy,'String',' ');
    testpath = test{idx};
    pattern = fullfile(testpath, '*.png');
    testfiles = dir(pattern);
    tic
    total = 0;
    for i = 1: length(testfiles)
        line = [];
        xt = 0;
        xmea = 0;
        base = testfiles(i).name;
        full = fullfile(testpath, base);
        pic = imread(full);
        axes(handles.axes1);
        imshow(pic);
        featuresI = extractLBPFeatures(pic,'Upright',false);
        pAge = sim(net1,featuresI');
        [M, I] = max(pAge);
        set(handles.predict,'String',I);
        id = split(base, '.');
        pattern = fullfile(testpath, '*.csv');
        file = dir(pattern);
        base = file.name;
        full = fullfile(testpath, base);
        data = readtable(full,'Delimiter',',','ReadVariableNames',false);
        rows = data.Var1==str2double(id{1});
        match = data(rows,:);
        set(handles.img_name,'String',match.Var1);
        line = [line int64(match.Var1)];
        if length(match.Properties.VariableNames) == 2
            xt = ceil(match.Var2/12); % xt = true value
            set(handles.age,'String',xt);
            line = [line xt];
            xmea = I;
            line = [line xmea];
            % load gong;
            % sound(y,Fs);
            accuracy = 100 - (abs(xmea - xt) / max(xt,xmea) * 100);
            set(handles.accuracy,'String',accuracy);
            line = [line accuracy];
            total = total + accuracy;
        end
        disp(line);
        dlmwrite('resultNN.csv',line,'-append','delimiter',',','roffset',0)
    end
    toc
    total = total / length(testfiles);
    dlmwrite('resultNN.csv',total,'-append','delimiter',',','roffset',0)
end
