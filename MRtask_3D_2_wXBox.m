function MRtask_3D_2_wXBox(run,neuralRecording)
%% User Inputs
%EMUnum = EMU;
%subjectID = subj;
taskID = 'MentalRotation';
runNum = run;
if nargin==1
    neuralRecording = 1;
end

% Experiment Parameters
nTrials = 100;
practiceTrials = 10;

%% Setup
% Avoids sync tests because of synchronization failure
Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference','VisualDebugLevel', 0);
Screen('Preference','SuppressAllWarnings', 1);
kill = false; %Changed on 2/22/2024

try
    [EMUnum,subjectID] = getNextLogEntry();
catch
    EMUnum = 1;
    subjectID = 'ggg';
end
filepath = fullfile(userpath,'PatientData',subjectID,taskID);
if ~exist(filepath,'dir')
    mkdir(filepath);
end
filename = ['EMU-',sprintf('%04d',EMUnum),'_subj-',subjectID,'_task-',taskID,'_run-',int2str(runNum)];
if neuralRecording==1
    try
        onlineNSP = TaskComment('start',filename); %Changed on 2/22/2024
    catch
    end
    %writeNextLogEntry();
    
%     [onlineNSP,neuralRecording] = StartBlackrockAquisition(filename);
end


% Get keyboard indices
[keyboardIDs] = GetKeyboardIndices;

% Creates initial window
screenNum=max(Screen('Screens'));
[w, windowRect] = Screen('OpenWindow',screenNum,0,[]);

% Setup Input
KbName('UnifyKeyNames');

% Establishing matrix of all the different stimuli images
imgSet(:,:,1) = ["1_0.jpg","1_50.jpg","1_100.jpg","1_150.jpg";"1_0_R.jpg","1_50_R.jpg","1_100_R.jpg","1_150_R.jpg"];
imgSet(:,:,2) = ["2_0.jpg","2_50.jpg","2_100.jpg","2_150.jpg";"2_0_R.jpg","2_50_R.jpg","2_100_R.jpg","2_150_R.jpg"];
imgSet(:,:,3) = ["3_0.jpg","3_50.jpg","3_100.jpg","3_150.jpg";"3_0_R.jpg","3_50_R.jpg","3_100_R.jpg","3_150_R.jpg"];
imgSet(:,:,4) = ["4_0.jpg","4_50.jpg","4_100.jpg","4_150.jpg";"4_0_R.jpg","4_50_R.jpg","4_100_R.jpg","4_150_R.jpg"];
imgSet(:,:,5) = ["5_0.jpg","5_50.jpg","5_100.jpg","5_150.jpg";"5_0_R.jpg","5_50_R.jpg","5_100_R.jpg","5_150_R.jpg"];
imgSet(:,:,6) = ["6_0.jpg","6_50.jpg","6_100.jpg","6_150.jpg";"6_0_R.jpg","6_50_R.jpg","6_100_R.jpg","6_150_R.jpg"];
imgSet(:,:,7) = ["7_0.jpg","7_50.jpg","7_100.jpg","7_150.jpg";"7_0_R.jpg","7_50_R.jpg","7_100_R.jpg","7_150_R.jpg"];
imgSet(:,:,8) = ["8_0.jpg","8_50.jpg","8_100.jpg","8_150.jpg";"8_0_R.jpg","8_50_R.jpg","8_100_R.jpg","8_150_R.jpg"];
imgSet(:,:,9) = ["9_0.jpg","9_50.jpg","9_100.jpg","9_150.jpg";"9_0_R.jpg","9_50_R.jpg","9_100_R.jpg","9_150_R.jpg"];
imgSet(:,:,10) = ["10_0.jpg","10_50.jpg","10_100.jpg","10_150.jpg";"10_0_R.jpg","10_50_R.jpg","10_100_R.jpg","10_150_R.jpg"];
imgSet(:,:,11) = ["11_0.jpg","11_50.jpg","11_100.jpg","11_150.jpg";"11_0_R.jpg","11_50_R.jpg","11_100_R.jpg","11_150_R.jpg"];
imgSet(:,:,12) = ["12_0.jpg","12_50.jpg","12_100.jpg","12_150.jpg";"12_0_R.jpg","12_50_R.jpg","12_100_R.jpg","12_150_R.jpg"];
imgSet(:,:,13) = ["13_0.jpg","13_50.jpg","13_100.jpg","13_150.jpg";"13_0_R.jpg","13_50_R.jpg","13_100_R.jpg","13_150_R.jpg"];
imgSet(:,:,14) = ["14_0.jpg","14_50.jpg","14_100.jpg","14_150.jpg";"14_0_R.jpg","14_50_R.jpg","14_100_R.jpg","14_150_R.jpg"];
imgSet(:,:,15) = ["15_0.jpg","15_50.jpg","15_100.jpg","15_150.jpg";"15_0_R.jpg","15_50_R.jpg","15_100_R.jpg","15_150_R.jpg"];
imgSet(:,:,16) = ["16_0.jpg","16_50.jpg","16_100.jpg","16_150.jpg";"16_0_R.jpg","16_50_R.jpg","16_100_R.jpg","16_150_R.jpg"];
imgSet(:,:,17) = ["17_0.jpg","17_50.jpg","17_100.jpg","17_150.jpg";"17_0_R.jpg","17_50_R.jpg","17_100_R.jpg","17_150_R.jpg"];
imgSet(:,:,18) = ["18_0.jpg","18_50.jpg","18_100.jpg","18_150.jpg";"18_0_R.jpg","18_50_R.jpg","18_100_R.jpg","18_150_R.jpg"];
imgSet(:,:,19) = ["19_0.jpg","19_50.jpg","19_100.jpg","19_150.jpg";"19_0_R.jpg","19_50_R.jpg","19_100_R.jpg","19_150_R.jpg"];
imgSet(:,:,20) = ["20_0.jpg","20_50.jpg","20_100.jpg","20_150.jpg";"20_0_R.jpg","20_50_R.jpg","20_100_R.jpg","20_150_R.jpg"];
imgSet(:,:,21) = ["21_0.jpg","21_50.jpg","21_100.jpg","21_150.jpg";"21_0_R.jpg","21_50_R.jpg","21_100_R.jpg","21_150_R.jpg"];
imgSet(:,:,22) = ["22_0.jpg","22_50.jpg","22_100.jpg","22_150.jpg";"22_0_R.jpg","22_50_R.jpg","22_100_R.jpg","22_150_R.jpg"];
imgSet(:,:,23) = ["23_0.jpg","23_50.jpg","23_100.jpg","23_150.jpg";"23_0_R.jpg","23_50_R.jpg","23_100_R.jpg","23_150_R.jpg"];
imgSet(:,:,24) = ["24_0.jpg","24_50.jpg","24_100.jpg","24_150.jpg";"24_0_R.jpg","24_50_R.jpg","24_100_R.jpg","24_150_R.jpg"];
imgSet(:,:,25) = ["25_0.jpg","25_50.jpg","25_100.jpg","25_150.jpg";"25_0_R.jpg","25_50_R.jpg","25_100_R.jpg","25_150_R.jpg"];
imgSet(:,:,26) = ["26_0.jpg","26_50.jpg","26_100.jpg","26_150.jpg";"26_0_R.jpg","26_50_R.jpg","26_100_R.jpg","26_150_R.jpg"];
imgSet(:,:,27) = ["27_0.jpg","27_50.jpg","27_100.jpg","27_150.jpg";"27_0_R.jpg","27_50_R.jpg","27_100_R.jpg","27_150_R.jpg"];
imgSet(:,:,28) = ["28_0.jpg","28_50.jpg","28_100.jpg","28_150.jpg";"28_0_R.jpg","28_50_R.jpg","28_100_R.jpg","28_150_R.jpg"];
imgSet(:,:,29) = ["29_0.jpg","29_50.jpg","29_100.jpg","29_150.jpg";"29_0_R.jpg","29_50_R.jpg","29_100_R.jpg","29_150_R.jpg"];
imgSet(:,:,30) = ["30_0.jpg","30_50.jpg","30_100.jpg","30_150.jpg";"30_0_R.jpg","30_50_R.jpg","30_100_R.jpg","30_150_R.jpg"];
imgSet(:,:,31) = ["31_0.jpg","31_50.jpg","31_100.jpg","31_150.jpg";"31_0_R.jpg","31_50_R.jpg","31_100_R.jpg","31_150_R.jpg"];
imgSet(:,:,32) = ["32_0.jpg","32_50.jpg","32_100.jpg","32_150.jpg";"32_0_R.jpg","32_50_R.jpg","32_100_R.jpg","32_150_R.jpg"];
imgSet(:,:,33) = ["33_0.jpg","33_50.jpg","33_100.jpg","33_150.jpg";"33_0_R.jpg","33_50_R.jpg","33_100_R.jpg","33_150_R.jpg"];
imgSet(:,:,34) = ["34_0.jpg","34_50.jpg","34_100.jpg","34_150.jpg";"34_0_R.jpg","34_50_R.jpg","34_100_R.jpg","34_150_R.jpg"];
imgSet(:,:,35) = ["35_0.jpg","35_50.jpg","35_100.jpg","35_150.jpg";"35_0_R.jpg","35_50_R.jpg","35_100_R.jpg","35_150_R.jpg"];
imgSet(:,:,36) = ["36_0.jpg","36_50.jpg","36_100.jpg","36_150.jpg";"36_0_R.jpg","36_50_R.jpg","36_100_R.jpg","36_150_R.jpg"];
imgSet(:,:,37) = ["37_0.jpg","37_50.jpg","37_100.jpg","37_150.jpg";"37_0_R.jpg","37_50_R.jpg","37_100_R.jpg","37_150_R.jpg"];
imgSet(:,:,38) = ["38_0.jpg","38_50.jpg","38_100.jpg","38_150.jpg";"38_0_R.jpg","38_50_R.jpg","38_100_R.jpg","38_150_R.jpg"];
imgSet(:,:,39) = ["39_0.jpg","39_50.jpg","39_100.jpg","39_150.jpg";"39_0_R.jpg","39_50_R.jpg","39_100_R.jpg","39_150_R.jpg"];
imgSet(:,:,40) = ["40_0.jpg","40_50.jpg","40_100.jpg","40_150.jpg";"40_0_R.jpg","40_50_R.jpg","40_100_R.jpg","40_150_R.jpg"];
imgSet(:,:,41) = ["41_0.jpg","41_50.jpg","41_100.jpg","41_150.jpg";"41_0_R.jpg","41_50_R.jpg","41_100_R.jpg","41_150_R.jpg"];
imgSet(:,:,42) = ["42_0.jpg","42_50.jpg","42_100.jpg","42_150.jpg";"42_0_R.jpg","42_50_R.jpg","42_100_R.jpg","42_150_R.jpg"];
imgSet(:,:,43) = ["43_0.jpg","43_50.jpg","43_100.jpg","43_150.jpg";"43_0_R.jpg","43_50_R.jpg","43_100_R.jpg","43_150_R.jpg"];
imgSet(:,:,44) = ["44_0.jpg","44_50.jpg","44_100.jpg","44_150.jpg";"44_0_R.jpg","44_50_R.jpg","44_100_R.jpg","44_150_R.jpg"];
imgSet(:,:,45) = ["45_0.jpg","45_50.jpg","45_100.jpg","45_150.jpg";"45_0_R.jpg","45_50_R.jpg","45_100_R.jpg","45_150_R.jpg"];
imgSet(:,:,46) = ["46_0.jpg","46_50.jpg","46_100.jpg","46_150.jpg";"46_0_R.jpg","46_50_R.jpg","46_100_R.jpg","46_150_R.jpg"];
imgSet(:,:,47) = ["47_0.jpg","47_50.jpg","47_100.jpg","47_150.jpg";"47_0_R.jpg","47_50_R.jpg","47_100_R.jpg","47_150_R.jpg"];
imgSet(:,:,48) = ["48_0.jpg","48_50.jpg","48_100.jpg","48_150.jpg";"48_0_R.jpg","48_50_R.jpg","48_100_R.jpg","48_150_R.jpg"];

% imgPartialBlank = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg","9.jpg","10.jpg","11.jpg","12.jpg","13.jpg","14.jpg","15.jpg",...
%     "16.jpg","17.jpg","18.jpg","19.jpg","20.jpg","21.jpg","22.jpg","23.jpg","24.jpg","25.jpg","26.jpg","27.jpg","28.jpg","29.jpg","30.jpg",...
%     "31.jpg","32.jpg","33.jpg","34.jpg","35.jpg","36.jpg","37.jpg","38.jpg","39.jpg","40.jpg","41.jpg","42.jpg","43.jpg","44.jpg","45.jpg",...
%     "46.jpg","47.jpg","48.jpg"];

%Get Movies
if ~exist("PhotodiodeMovies", "dir"); error("No movies found"); end

movies_dir = dir("./PhotodiodeMovies");
movies_dir = movies_dir(3:end);

% Photodiode Square
try
    flickerSquarePos = flickerSquareLoc(windowRect,24,2,'BottomLeft');
catch
end

code = zeros(3,384);
object = 1:48;
object_repeated = repelem(object,1,8);
angle_PairType = [1, 1, 1, 1, 2, 2, 2, 2; 1, 2, 3, 4, 1, 2, 3, 4];
angle_PairType_repeated = repmat(angle_PairType,1,48);
code(1:2,:) = angle_PairType_repeated;
code(3,:)=object_repeated;

behav.randomized = randperm(384);
randomizedPractice = behav.randomized(1,1:practiceTrials);
randomizedTrials = behav.randomized(1,practiceTrials+1:384);

% preset values before trials
behav = struct();
behav.stimulusStartTime=NaN(nTrials + practiceTrials,1);
behav.responseTime=NaN(nTrials + practiceTrials,1);
behav.fixationCrossTime=NaN(nTrials + practiceTrials,1);
behav.jitterTime=NaN((nTrials + practiceTrials),1);
behav.correctAnswers=NaN(1,(nTrials + practiceTrials));
behav.objectForTrial=NaN(1,(nTrials + practiceTrials));
behav.degreeForTrial=NaN(1,(nTrials + practiceTrials));
behav.pairTypeForTrial=NaN(1,(nTrials + practiceTrials));
behav.inputForTrial=cell(1,(nTrials + practiceTrials));
behav.accuracyScreenTime=NaN(1,(nTrials/25));
behav.continuingScreenTime=NaN(1,(nTrials/25));
behav.directions=cell(2,(nTrials + practiceTrials));
behav.continuousInputTimeS = NaN(1,nTrials + practiceTrials);

%% Start Presentation

Screen('TextFont', w, 'Helvetica');
Screen('TextSize', w, 20);
Instruction1 = WrapString(['You will be presented with two objects. Your task is to determine if the object on the right is the ' ...
    'same as the object on the left or if they are mirror images. The objects may be rotated, so you may need to mentally rotate the ' ...
    'right object in order to bring it into alignment with the left object. There is no time-limit, but please try to answer as quickly as ' ...
    'possible without sacrificing accuracy.\n Press any key to continue.']);
Instruction2 = WrapString(['There is a practice phase of 10 trials from which will you get feedback, but there will be no feedback during the ' ...
    'trial phase. The trial phase consists of ',int2str(nTrials),' trials which are broken into 25-trial blocks. You will receive feedback about your performance ' ...
    'in each block after you have completed it and before you move onto the next block.\n Press any key to continue.']);

% Intro instructions
if run == 1
    DrawFormattedText(w, Instruction1,'center','center',WhiteIndex(screenNum),[],[],[],1.5);
    Screen('Flip',w);
    KbWait([], 2);
    DrawFormattedText(w, Instruction2,'center','center',WhiteIndex(screenNum),[],[],[],1.5);
    Screen('Flip',w);
    KbWait([], 2);
end

KeyAssignment = 1;
switch KeyAssignment
    case 1
        DrawFormattedText(w,['Press the "w" key if the objects are the same.\n ' ...
            'Press the "o" button if the objects are different.\n Press any key to continue.'],'center','center',WhiteIndex(screenNum),[],[],[],1.5);
    case 2
        DrawFormattedText(w,['Press the right button if the objects are the same.\n ' ...
            'Press the left button if the objects are different.\n Press any key to continue.'],'center','center',WhiteIndex(screenNum),[],[],[],1.5);
end
Screen('Flip',w);
KbWait([], 2);


DrawFormattedText(w,'Beginning practice phase','center','center',WhiteIndex(screenNum));
Screen('Flip',w);
WaitSecs(2);

for i=1:practiceTrials
    Screen('TextSize', w, 20);
    j=randomizedPractice(i);
    img = imread(fullfile('Stimuli',imgSet(code(1,j),code(2,j),code(3,j))));
    tex = Screen('MakeTexture',w,img);
    Screen('DrawTexture',w,tex);
    Screen('Flip',w);
    
    % [response,behav.responseTime(i)] = keyboardResponse();
    timeStart = GetSecs();
    xBoxInput = GetXBox();
    [~, ~, key_code] = KbCheck();
    break_loop = xBoxInput.A || xBoxInput.B || xBoxInput.Start || ...
                 key_code(KbName('w')) || key_code(KbName('o')) || key_code(KbName('escape'));
    tr_dirs = [];
    tr_dir_ts = [];
    while ~break_loop
        xBoxInput = GetXBox();
        [~, ~, key_code] = KbCheck();
        break_loop = xBoxInput.A || xBoxInput.B || xBoxInput.Start || ...
                     key_code(KbName('w')) || key_code(KbName('o')) || key_code(KbName('escape'));
        left_rot =  xBoxInput.JoystickLX < -0.5 || xBoxInput.JoystickRX < -0.5 || xBoxInput.DPadLeft || xBoxInput.LB || ...
                    xBoxInput.LT;
        right_rot = xBoxInput.JoystickLX > 0.5 || xBoxInput.JoystickRX > 0.5 || xBoxInput.DPadRight || xBoxInput.RB || ...
                    xBoxInput.RT;
        if left_rot
            tr_dirs = [tr_dirs, 'l']; 
            tr_dir_ts = [tr_dir_ts, GetSecs() - behav.stimulusStartTime(i)];
        elseif right_rot
            tr_dirs = [tr_dirs, 'r'];
            tr_dir_ts = [tr_dir_ts, GetSecs() - behav.stimulusStartTime(i)];
        end
        WaitSecs(0.2);
    end
    behav.directions{1, i} = tr_dirs; 
    behav.directions{2, i} = tr_dir_ts;
    behav.responseTime(i) = GetSecs() - behav.stimulusStartTime(i);
    
    same_cond = xBoxInput.A || key_code(KbName('w'));
    opp_cond = xBoxInput.B || key_code(KbName('o'));
    escape_cond = xBoxInput.Start || key_code(KbName('escape'));
    % behav.inputForTrial(i)=cellstr(response);
    disp([same_cond, opp_cond, escape_cond]);


    if same_cond
        switch code(1,j)
            case 1
                disp('Correct')
                DrawFormattedText(w,'Correct','center','center',WhiteIndex(screenNum));
                Screen('Flip',w);
                behav.correctAnswers(i)=1;
                WaitSecs(1.5);
            case 2
                disp('Incorrect')
                DrawFormattedText(w,'Incorrect','center','center',WhiteIndex(screenNum));
                Screen('Flip',w);
                behav.correctAnswers(i)=0;
                WaitSecs(1.5);
        end
        behav.inputForTrial{i} = 's';
    elseif opp_cond
        switch code(1,j)
            case 1
                disp('Incorrect')
                DrawFormattedText(w,'Incorrect','center','center',WhiteIndex(screenNum));
                Screen('Flip',w);
                behav.correctAnswers(i)=0;
                WaitSecs(1.5);
            case 2
                disp('Correct')
                DrawFormattedText(w,'Correct','center','center',WhiteIndex(screenNum));
                Screen('Flip',w);
                behav.correctAnswers(i)=1;
                WaitSecs(1.5);
        end
        behav.inputForTrial{i} = 'd';
    elseif escape_cond
        behav.inputForTrial{i} = 'e';
        kill = true; %Changed on 2/22/2024
        EndTask()
        return %this ends ends the task, but not the neural recording, was here
    end

    Screen('TextSize', w, 50);
    DrawFormattedText(w,'+','center','center',WhiteIndex(screenNum));
    behav.fixationCrossTime(i) = Screen('Flip',w);
    behav.jitterTime(i) = rand(1)/2 + 0.5;
    WaitSecs(rand(1)/2 + 0.5);
    
    selected_movie = randi(length(movies_dir));
    selected_movie = movies_dir(selected_movie);
    moviename = fullfile(selected_movie.folder, selected_movie.name);

    % [movie, movieduration, fps, imgw, imgh, ~, ~, hdrStaticMetaData] = Screen('OpenMovie', w, moviename);
    moviePtr = Screen('OpenMovie', w, moviename);

    % Start playback of the movie
    Screen('PlayMovie', moviePtr, 1);

    % Display the video until the end of the movie or the spacebar is pressed
    space = KbName('space');
    keyCode = zeros(1, 256); % Initialize keyCode

    % Initialize frame retrieval and playback variables
    while 1
        % Check for space key press to exit
        [~,~,keyCode] = KbCheck();
        if keyCode(space)
            break;
        end

        % Get the next frame of the movie
        tex = Screen('GetMovieImage', w, moviePtr);

        % If tex is -1, the end of the movie is reached
        if tex <= 0
            break;
        end

        % Draw the texture (frame) to the screen
        Screen('DrawTexture', w, tex);

        % Show the frame on the screen
        Screen('Flip', w);

        % Release the texture
        Screen('Close', tex);
    end

    % Stop playback
    Screen('PlayMovie', moviePtr, 0);

    % Close the movie
    Screen('CloseMovie', moviePtr);

    behav.continuousInputTimeS(i) = 0;
    cis_start = GetSecs();
    while GetXBox().AnyInput; behav.continuousInputTimeS(i) = GetSecs() - cis_start; end
end

Screen('TextSize', w, 40);
DrawFormattedText(w,'Beginning trial phase.\n Press any key to continue.','center','center',WhiteIndex(screenNum));
Screen('Flip',w);
KbWait;

for i = practiceTrials+1 : nTrials
    j=randomizedTrials(i);
    behav.objectForTrial(i)=code(3,j);
    behav.degreeForTrial(i)=(code(2,j)-1)*50;
    behav.pairTypeForTrial(i)=code(1,j);
    img = imread(fullfile('Stimuli',imgSet(behav.pairTypeForTrial(i),(code(2,j)),behav.objectForTrial(i))));
    tex = Screen('MakeTexture',w,img);
    Screen('DrawTexture',w,tex);
    if neuralRecording
        try 
            Screen('FillRect',w,WhiteIndex(screenNum),flickerSquarePos); 
        catch
        end
    end
    behav.stimulusStartTime(i) = Screen('Flip',w);

    if neuralRecording
        try
            comment = sprintf('%s %0*d  %s %d %s','Trial',3,i,'Degree',behav.degreeForTrial(i));
            sendBlackrockComments(comment,onlineNSP)
        catch
        end
    end

    % [response,behav.responseTime(i)] = keyboardResponse();
    timeStart = GetSecs();
    xBoxInput = GetXBox();
    [~, ~, key_code] = KbCheck();
    break_loop = xBoxInput.A || xBoxInput.B || xBoxInput.Start || ...
                 key_code(KbName('w')) || key_code(KbName('o')) || key_code(KbName('escape'));
    tr_dirs = [];
    tr_dir_ts = [];
    while ~break_loop
        xBoxInput = GetXBox();
        [~, ~, key_code] = KbCheck();
        break_loop = xBoxInput.A || xBoxInput.B || xBoxInput.Start || ...
                     key_code(KbName('w')) || key_code(KbName('o')) || key_code(KbName('escape'));
        left_rot =  xBoxInput.JoystickLX < -0.5 || xBoxInput.JoystickRX < -0.5 || xBoxInput.DPadLeft || xBoxInput.LB || ...
                    xBoxInput.LT;
        right_rot = xBoxInput.JoystickLX > 0.5 || xBoxInput.JoystickRX > 0.5 || xBoxInput.DPadRight || xBoxInput.RB || ...
                    xBoxInput.RT;
        if left_rot
            tr_dirs = [tr_dirs, 'l']; 
            tr_dir_ts = [tr_dir_ts, GetSecs() - behav.stimulusStartTime(i)];
        elseif right_rot
            tr_dirs = [tr_dirs, 'r'];
            tr_dir_ts = [tr_dir_ts, GetSecs() - behav.stimulusStartTime(i)];
        end
        WaitSecs(0.2);
    end
    behav.directions{1, i} = tr_dirs; 
    behav.directions{2, i} = tr_dir_ts;
    behav.responseTime(i) = GetSecs() - behav.stimulusStartTime(i);
    
    same_cond = xBoxInput.A || key_code(KbName('w'));
    opp_cond = xBoxInput.B || key_code(KbName('o'));
    escape_cond = xBoxInput.Start || key_code(KbName('escape'));
    % behav.inputForTrial(i)=cellstr(response);
    disp([same_cond, opp_cond, escape_cond]);

    if same_cond
        switch code(1,j)
            case 1
                disp('Correct')
                behav.correctAnswers(i)=1;
            case 2
                disp('Incorrect')
                behav.correctAnswers(i)=0;
        end
        behav.inputForTrial{i} = 's';
    elseif opp_cond
        switch code(1,j)
            case 1
                disp('Incorrect')
                behav.correctAnswers(i)=0;
            case 2
                disp('Correct')
                behav.correctAnswers(i)=1;
        end
        behav.inputForTrial{i} = 'd';
    elseif escape_cond
        behav.inputForTrial{i} = 'e';
        kill = true; %Changed on 2/22/2024
        EndTask()
        return %this ends ends the task, but not the neural recording, was here
    end

    Screen('TextSize', w, 50);
    DrawFormattedText(w,'+','center','center',WhiteIndex(screenNum));
    behav.fixationCrossTime(i) = Screen('Flip',w);
    behav.jitterTime(i) = rand/2 + 0.5;
    WaitSecs(rand(1)/2 + 0.5);

    TrialCounts = [25 50 75 100] + practiceTrials;
    if ismember(i, TrialCounts)
        Counter = ['Trial Number: ' num2str(i)];
        disp(Counter)
        Accuracy = (sum(behav.correctAnswers(i-24:i))/25)*100;
        DrawFormattedText(w,['Accuracy: ' num2str(Accuracy) '%'],'center','center',WhiteIndex(screenNum));
        behav.accuracyScreenTime((i - practiceTrials)/25)=Screen('Flip',w);
        WaitSecs(2);
        if i~=nTrials
            DrawFormattedText(w,'Continuing to next block','center','center',WhiteIndex(screenNum));
            behav.continuingScreenTime((i-practiceTrials)/25)=Screen('Flip',w);
            WaitSecs(2);
        end
    end 
    behav.continuousInputTimeS(i) = 0;
    cis_start = GetSecs();
    while GetXBox().AnyInput; behav.continuousInputTimeS(i) = GetSecs() - cis_start; end
end

DrawFormattedText(w,'Experiment Complete!\nThank you for your participation.','center','center',WhiteIndex(screenNum));
Screen('Flip',w);
WaitSecs(3);

EndTask()

%% Helper Functions
    function EndTask()
        if neuralRecording
            %             StopBlackrockAquisition(filename,onlineNSP)
            try
                if kill
                    TaskComment('kill',filename);
                else
                    TaskComment('stop',filename);
                end %Changed on 2/22/2024
            catch
            end
        end
        sca
        save(fullfile(filepath,filename),'-struct','behav')
    end
    function [response,reactionTime] = keyboardResponse()
        for kID_length=1:length(keyboardIDs)
            KbQueueCreate(keyboardIDs(kID_length));
            KbQueueStart(keyboardIDs(kID_length));
        end
        response = NaN;
        while isnan(response)
            for k=1:length(keyboardIDs)
                [pressed, pressTime] = KbQueueCheck(keyboardIDs(k));
                if pressed
                    ind = pressTime==max(pressTime);
                    response = KbName(find(ind));
                    switch response
                        case {'w','o','ESCAPE'} 
                            reactionTime = pressTime(ind);
                        otherwise
                            response = NaN;
                    end
                end
            end
        end
        for kID_length=1:length(keyboardIDs)
            KbQueueStop(keyboardIDs(kID_length));
        end
    end
    WaitSecs(2);
    [a,b] = keyboardResponse;

end