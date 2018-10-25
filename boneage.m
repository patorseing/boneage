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

% Last Modified by GUIDE v2.5 25-Oct-2018 19:37:32

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


% --- Executes on button press in GET_SINGLE.
function GET_SINGLE_Callback(hObject, eventdata, handles)
% hObject    handle to GET_SINGLE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in GET_MULTIPLE.
function GET_MULTIPLE_Callback(hObject, eventdata, handles)
% hObject    handle to GET_MULTIPLE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
