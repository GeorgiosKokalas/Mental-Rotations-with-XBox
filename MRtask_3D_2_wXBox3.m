function MRtask_3D_2_wXBox3(run,neuralRecording)
%% User Inputs
taskID = 'MentalRotation';
runNum = run;
if nargin==1
    neuralRecording = 1;
end

% Experiment Parameters
nTrials = 0;
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

% ESTABLISH THE STIMULI: EACH PAGE REPRESENTS A SHAPE, EACH COLUMN IS A ROTATION DEGREE, EACH ROW IS NORMAL VS REVERSED
% Establish variables needed for creation
uniqueShapes = 1:48;         % We can make the program auto-detect this, but it may make code harder to read
rotationDegrees = 0:50:150;  % Same here
imgSet = repmat("", 2, length(rotationDegrees), length(uniqueShapes));

% Create each page, by going shape through Shape
for shape = uniqueShapes
    shapeStr = num2str(shape);
    imgSetPage = repmat("", 2, length(rotationDegrees));
    % For each shape create the rotation Matrix
    for degreeIdx = 1:length(rotationDegrees)
        degreeStr = num2str(rotationDegrees(degreeIdx));
        normalShapeFile = append(shapeStr, "_", degreeStr, ".jpg");
        reversedShapeFile = append(shapeStr, "_", degreeStr, "_R.jpg");
        imgSetPage(:,degreeIdx) = [normalShapeFile; reversedShapeFile];
    end
    imgSet(:, :, shape) = imgSetPage;   % Insert the page in the matrix
    clear imgSetPage normalShapeFile reversedShapeFile degreeStr shapeStr
end

%Get Movies
if ~exist("./PhotodiodeMovies", "dir"); error("No movies found"); end

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
Instruction1 = WrapString(['You will be presented with two objects, which may or may not have different rotations. \nYou need to tell if they are the same shape or not. ',...
                           '\n\nPress A if they are the same. \nPress B if they are mirrored \n\nPress any key to continue']);
Instruction2 = WrapString(['The task has ', int2str(practiceTrials), ' practice trials, and ', int2str(nTrials), ' test trials.',...
                           '\nEvery 25 trials, you will be able to take a break and rest.']);

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

abortTask = false;
for i=1:practiceTrials
    abortTask = RunTrial(true); 
    if abortTask; break; end
end

if abortTask; return; end

Screen('TextSize', w, 40);
DrawFormattedText(w,'Beginning trial phase.\n Press any key to continue.','center','center',WhiteIndex(screenNum));
Screen('Flip',w);
KbWait;

for i = practiceTrials+1 : nTrials
    abortTask = RunTrial(false); 
    if abortTask; break; end
end

DrawFormattedText(w,'Experiment Complete!\nThank you for your participation.','center','center',WhiteIndex(screenNum));
Screen('Flip',w);
WaitSecs(3);

%% Helper Functions
    function abort = RunTrial(practice)
        abort = false
        if practice; j=randomizedPractice(i);
        else;        j=randomizedTrials(i);
        end

        Screen('TextSize', w, 20);
        behav.objectForTrial(i)=code(3,j);
        behav.degreeForTrial(i)=(code(2,j)-1)*50;
        behav.pairTypeForTrial(i)=code(1,j);
        img = imread(fullfile('Stimuli',imgSet(behav.pairTypeForTrial(i),(code(2,j)),behav.objectForTrial(i))));
        tex = Screen('MakeTexture',w,img);
        Screen('DrawTexture',w,tex);
        behav.stimulusStartTime(i) = Screen('Flip',w);

        if neuralRecording
            try   
                Screen('FillRect',w,WhiteIndex(screenNum),flickerSquarePos);
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
        
        answer = 'None';
        if same_cond
            switch code(1,j)
                case 1
                    answer = 'Correct';
                    behav.correctAnswers(i)=1;
                case 2
                   answer = 'Incorrect';
                    behav.correctAnswers(i)=0;
            end
            behav.inputForTrial{i} = 's';
        elseif opp_cond
            switch code(1,j)
                case 1
                    answer = 'Incorrect';
                    behav.correctAnswers(i)=0;
                case 2
                    answer = 'Correct';
                    behav.correctAnswers(i)=1;
            end
            behav.inputForTrial{i} = 'd';
        elseif escape_cond
            behav.inputForTrial{i} = 'e';
            kill = true; %Changed on 2/22/2024
            EndTask()
            abort = true;
            return %this ends ends the task, but not the neural recording, was here
        end
        
        disp(answer);
        
        if practice
            DrawFormattedText(w,answer,'center','center',WhiteIndex(screenNum));
            Screen('Flip',w);
            WaitSecs(1.5);
        end
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

        Screen('TextSize', w, 50);
        DrawFormattedText(w,'+','center','center',WhiteIndex(screenNum));
        behav.fixationCrossTime(i) = Screen('Flip',w);
        behav.jitterTime(i) = rand(1)/2 + 0.5;
        WaitSecs(rand(1)/2 + 0.5);

        behav.continuousInputTimeS(i) = 0;
        cis_start = GetSecs();
        while GetXBox().AnyInput; behav.continuousInputTimeS(i) = GetSecs() - cis_start; end
    end

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