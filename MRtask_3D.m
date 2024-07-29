function MRtask_3D(run,neuralRecording)
% hello world
%% User Inputs
% EMUnum = EMU;
% subjectID = subj;
taskID = 'MentalRotation';
runNum = run;
if nargin==1
    neuralRecording = 1;
end

% Experiment Parameters
nTrials = 100;
practiceTrials = 10;


%% Setup
% Avoids sync tests because of synchronization failure, comment out if
% synchronization failure fixed
Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference','VisualDebugLevel', 0);
Screen('Preference','SuppressAllWarnings', 1);
kill = false; %Changed on 2/22/2024


[EMUnum,subjectID] = getNextLogEntry();
% EMUnum = 1;
% subjectID = 'YEX';
filepath = fullfile(userpath,'PatientData',subjectID,taskID);
if ~exist(filepath,'dir')
    mkdir(filepath);
end
filename = ['EMU-',sprintf('%04d',EMUnum),'_subj-',subjectID,'_task-',taskID,'_run-',int2str(runNum)];
if neuralRecording==1
    onlineNSP = TaskComment('start',filename); %Changed on 2/22/2024
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

% Photodiode Square
flickerSquarePos = flickerSquareLoc(windowRect,24,2,'BottomLeft');

code = zeros(3,384);
object = 1:48;
object_repeated = repelem(object,1,8);
angle_PairType = [1, 1, 1, 1, 2, 2, 2, 2; 1, 2, 3, 4, 1, 2, 3, 4];
angle_PairType_repeated = repmat(angle_PairType,1,48);
code(1:2,:) = angle_PairType_repeated;
code(3,:)=object_repeated;

randomized = randperm(384);
randomizedPractice = randomized(1,1:practiceTrials);
randomizedTrials = randomized(1,practiceTrials+1:384);

% preset values before trials
behav = struct();
behav.RTs=zeros(nTrials,1);
behav.correctAnswers=zeros(1,nTrials);
behav.objectForTrial=zeros(1,nTrials);
behav.degreeForTrial=zeros(1,nTrials);
behav.pairTypeForTrial=zeros(1,nTrials);
behav.inputForTrial=cell(1,nTrials);
behav.randomized = randomized;

%% Start Presentation

Screen('TextFont', w, 'Helvetica');
Screen('TextSize', w, 20);
Instruction1 = WrapString(['You will be presented with two objects. Your task is to determine if the object on the right is the ' ...
    'same as the object on the left or if they are mirror images. The objects may be rotated, so you may need to mentally rotate the ' ...
    'right object in order to bring it into alignment with the left object. There is no time-limit, but please try to answer as quickly as ' ...
    'possible without sacrificing accuracy.\n Press any key to continue.']);
Instruction2 = WrapString(['There is a practice phase of 5 trials from which will you get feedback, but there will be no feedback during the ' ...
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
        DrawFormattedText(w,['Press the left button if the objects are the same.\n ' ...
            'Press the right button if the objects are different.\n Press any key to continue.'],'center','center',WhiteIndex(screenNum),[],[],[],1.5);
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

    response = keyboardResponse();

    switch response
        case 'w'
            switch code(1,j)
                case 1
                    disp('Correct')
                    DrawFormattedText(w,'Correct','center','center',WhiteIndex(screenNum));
                    Screen('Flip',w);
                    WaitSecs(1.5);
                case 2
                    disp('Incorrect')
                    DrawFormattedText(w,'Incorrect','center','center',WhiteIndex(screenNum));
                    Screen('Flip',w);
                    WaitSecs(1.5);
            end
        case 'o'
            switch code(1,j)
                case 1
                    disp('Incorrect')
                    DrawFormattedText(w,'Incorrect','center','center',WhiteIndex(screenNum));
                    Screen('Flip',w);
                    WaitSecs(1.5);
                case 2
                    disp('Correct')
                    DrawFormattedText(w,'Correct','center','center',WhiteIndex(screenNum));
                    Screen('Flip',w);
                    WaitSecs(1.5);
            end
        case 'ESCAPE'
            kill = true; %Changed on 2/22/2024
            EndTask() 
            return
    end

    Screen('TextSize', w, 50);
    DrawFormattedText(w,'+','center','center',WhiteIndex(screenNum));
    Screen('Flip',w);
    randSecs = rand(1)/2 + 0.5;
    WaitSecs(randSecs);
end

Screen('TextSize', w, 40);
DrawFormattedText(w,'Beginning trial phase.\n Press any key to continue.','center','center',WhiteIndex(screenNum));
Screen('Flip',w);
KbWait;

for i=1:nTrials
    j=randomizedTrials(i);
    behav.objectForTrial(i)=code(3,j);
    behav.degreeForTrial(i)=(code(2,j)-1)*50;
    behav.pairTypeForTrial(i)=code(1,j);
    img = imread(fullfile('Stimuli',imgSet(behav.pairTypeForTrial(i),(code(2,j)),behav.objectForTrial(i))));
    tex = Screen('MakeTexture',w,img);
    Screen('DrawTexture',w,tex);
    if neuralRecording
        Screen('FillRect',w,WhiteIndex(screenNum),flickerSquarePos);
    end
    stimulusStartTime = Screen('Flip',w);

    if neuralRecording
        comment = sprintf('%s %0*d  %s %d %s','Trial',3,i,'Degree',behav.degreeForTrial(i));
        sendBlackrockComments(comment,onlineNSP)
    end

    [response,responseTime] = keyboardResponse();
    behav.inputForTrial(i)=cellstr(response);
    
    behav.RTs(i) = responseTime - stimulusStartTime;
    switch response
        case 'w'
            switch code(1,j)
                case 1
                    disp('Correct')
                    behav.correctAnswers(i)=1;
                case 2
                    disp('Incorrect')
                    behav.correctAnswers(i)=0;
            end
        case 'o'
            switch code(1,j)
                case 1
                    disp('Incorrect')
                    behav.correctAnswers(i)=0;
                case 2
                    disp('Correct')
                    behav.correctAnswers(i)=1;
            end
        case 'ESCAPE'
            kill = true; %Changed on 2/22/2024
            EndTask() 
            return %this ends ends the task, but not the neural recording, was here
    end

    Screen('TextSize', w, 50);
    DrawFormattedText(w,'+','center','center',WhiteIndex(screenNum));
    Screen('Flip',w);
    randSecs = rand/2 + 0.5;
    WaitSecs(randSecs);

    TrialCounts = [25 50 100 75 100];
    if ismember(i, TrialCounts)
        Counter = ['Trial Number: ' num2str(i)];
        disp(Counter)
        Accuracy = (sum(behav.correctAnswers(i-24:i))/25)*100;
        DrawFormattedText(w,['Accuracy: ' num2str(Accuracy) '%\n Continuing to next block.'],'center','center',WhiteIndex(screenNum));
        Screen('Flip',w);
        WaitSecs(2);
    end
end

DrawFormattedText(w,'Experiment Complete!\nThank you for your participation.','center','center',WhiteIndex(screenNum));
Screen('Flip',w);
WaitSecs(3);

EndTask()

%% Helper Functions
    function EndTask()
        if neuralRecording
            %             StopBlackrockAquisition(filename,onlineNSP)
            if kill
                TaskComment('kill',filename);
            else
                TaskComment('stop',filename);
            end %Changed on 2/22/2024
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

end