function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
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
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 26-Mar-2021 08:07:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% variable declarations
global orginalTrack;
global orginalTrackLoaded;
global orginalTrackPaused;
global orginalTrackData;
global orginalTrackSound;

global addedTrack;
global addedTrackLoaded;
global addedTrackPaused;
global addedTrackData;
global addedTrackSound;

global sampleRate;
global speedTrack;

% assiging values to declared variable
orginalTrack = false;
orginalTrackLoaded = false;
orginalTrackPaused = false;
orginalTrackData = 0;
addedTrack = false;
addedTrackLoaded = false;
addedTrackPaused = false;
addedTrackData = 0;

sampleRate = 48000;
speedTrack = false;

% function to import the track
function importTrack(handles, track)
global sampleRate;
global speedTrack;

%opens the file explorer to brower the track
[trackName, trackPath] = uigetfile( ...
{'*.wav;*.mp3',...
'Audio Files (*.wav,*.mp3)'; ...
'*wav', 'WAV Files(*.wav)';...
'*mp3', 'MP3 Files(*.mp3)';},...
'Select an audio file');

if trackName
    [snd, FS] = audioread(fullfile(trackPath, trackName));
    
    if track == 1
        global orginalTrackData;
        global orginalTrackSound;
        global orginalTrack;
        global orginalTrackPaused;
        global orginalTrackLoaded;
        
        orginalTrackLoaded = true;
        orginalTrack = false;
        orginalTrackPaused = false;
        
        if FS ~= sampleRate
            [X, Y] = rat(sampleRate/FS);
            orginalTrackData = resample(snd, X, Y);
        else
            orginalTrackData = snd;
        end
        orginalTrackSound = audioplayer(orginalTrackData, sampleRate);
    end
end
        
        


% function to play a track
function playTrack(track)
global orginalTrack;
global orginalTrackLoaded;
global orginalTrackSound;
global orginalTrackPaused;

global addedTrack;
global addedTrackLoaded;
global addedTrackSound;
global addedTrackPaused;

if track == 1
    if ~orginalTrack && orginalTrackLoaded
        resume(orginalTrackSound);
        orginalTrack = true;
        orginalTrackPaused = false;
    end
elseif track == 2
    if ~addedTrack && addedTrackLoaded
        resume(addedTrackSound);
        addedTrack = true;
        addedTrackPaused = false;
    end
end

% function to puase the track
function pauseTrack(track)
if track ==1
    global orginalTrackSound;
    global orginalTrack;
    global orginalTrackPaused;
    
    orginalTrack = false;
    orginalTrackPaused = true;
    pause(orginalTrackSound);
else
    global addedTrackSound;
    global addedTrack;
    global addedTrackPaused;
    
    addedTrack = false;
    addedTrackPaused = true;
    pause(addedTrackSound);
end
    





% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function originalSlider_Callback(hObject, eventdata, handles)
% hObject    handle to originalSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
axesLabels(hObject);

% --- Executes during object creation, after setting all properties.
function originalSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to originalSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function addedSlider_Callback(hObject, eventdata, handles)
% hObject    handle to addedSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function addedSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to addedSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in uploadOrginal.
function uploadOrginal_Callback(hObject, eventdata, handles)
% hObject    handle to uploadOrginal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
importTrack(handles, 1);


% --- Executes on button press in uploadAdded.
function uploadAdded_Callback(hObject, eventdata, handles)
% hObject    handle to uploadAdded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
importTrack(handles, 2);


% --- Executes on button press in playOriginal.
function playOriginal_Callback(hObject, eventdata, handles)
% hObject    handle to playOriginal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
playTrack(1);

% --- Executes on button press in stopOriginal.
function stopOriginal_Callback(hObject, eventdata, handles)
% hObject    handle to stopOriginal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pauseOriginal.
function pauseOriginal_Callback(hObject, eventdata, handles)
% hObject    handle to pauseOriginal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pauseTrack(1);

% --- Executes on button press in saveTrack.
function saveTrack_Callback(hObject, eventdata, handles)
% hObject    handle to saveTrack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in resetSpeed.
function resetSpeed_Callback(hObject, eventdata, handles)
% hObject    handle to resetSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in playAdded.
function playAdded_Callback(hObject, eventdata, handles)
% hObject    handle to playAdded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
playTrack(2);

% --- Executes on button press in stopAdded.
function stopAdded_Callback(hObject, eventdata, handles)
% hObject    handle to stopAdded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pauseAdded.
function pauseAdded_Callback(hObject, eventdata, handles)
% hObject    handle to pauseAdded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pauseTrack(2)

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, ~, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in insertTrack.
function insertTrack_Callback(hObject, eventdata, handles)
% hObject    handle to insertTrack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



    


