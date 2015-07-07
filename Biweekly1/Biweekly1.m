close all
clear
clc

%% 1. Basics

v1 = rand(1,1000); %vector of 1000 random numbers

greaterThanFive = 0;    %count numbers greater than 0.5
between3and7 = 0;       %count numbers between 0.3 and 0.7

for n = 1:length(v1) %loop through vector
    
    %increment counter if number is greater than 5
    if v1(n) > 0.5
        greaterThanFive = greaterThanFive + 1;
    end
    
    %increment counter if number is between 0.3 and 0.7
    if v1(n) > 0.3 && v1(n) < 0.7
        between3and7 = between3and7 + 1;
    end
end

%create histogram of random numbers with labels
histogram(v1,10);
grid on
title('1000 Random Numbers')
xlabel('bins')
ylabel('frequency')

%calculate & display mean and standard deviation
fprintf('\nMean of numbers: \t\t%f', mean(v1));
fprintf('\nStandard deviation of numbers: \t%f', std(v1));

%display counters
fprintf('\nNumbers greater than 0.5: \t%d', greaterThanFive);
fprintf('\nNumbers between 0.3 and 0.7: \t%d', between3and7);

%% Random Walks
clear
clc

% Question 2
% Initialize position of x, set up array for number of steps
xposition = 0;
xstep = zeros(1, 10);
xwalk = randi(2, 1, 10);

for i = 1:length(xwalk)
    if xwalk(i) == 1
        xposition = xposition - 1;
    else
        xposition = xposition + 1;
    end
    xstep(i) = xposition;   % Place positions into the array
end

distance = max(abs(xstep));
fprintf('The maximum distance x traveled from its initial position was %d.\n', distance)

figure
plot(xstep, 'o:')
xlabel 'Time'
ylabel 'Position'
title 'Question 2'
axis ([0 10 -10 10])
grid on

% Question 3

% Initialize positions and set up the arrays
newxpos = 0;
newypos = 0;
newxstep = zeros(1, 25);
newystep = zeros(1, 25);
bothwalk = randi(4, 1, 25);

for i = 1:length(bothwalk)
    if bothwalk(i) == 1
        newxpos = newxpos + 1;
    elseif bothwalk(i) == 2
        newxpos = newxpos - 1;
    elseif bothwalk(i) == 3
        newypos = newypos + 1;
    else
        newypos = newypos - 1;
    end
    % Place the steps into the arrays
    newxstep(i) = newxpos;
    newystep(i) = newypos;
end

% Place the arrays into a 2 x 26 matrix to be plotted
bothstep = [0 newxstep; 0 newystep];

figure
plot(bothstep(1,:), bothstep(2,:), 'o:')
xlabel 'Time'
ylabel 'Position'
title 'Question 3'
axis equal
hold on
grid on
plot(bothstep(1), bothstep(2), 'o', 'MarkerSize', 20, 'Color', 'g')
plot(bothstep(end-1), bothstep(end), 'o', 'MarkerSize', 20, 'Color', 'r')

%% Question 4a

% Set up the array
twoperson_iterations = zeros(1, 5000);

for i = 1:5000
    count = 0;
    % initialize position for each person, set x and y coordinates
    inip1pos = randi(100, 1, 2)';
    inip2pos = randi(100, 1, 2)';
    p1x = inip1pos(1);
    p1y = inip1pos(2);
    p2x = inip2pos(1);
    p2y = inip2pos(2);
    % finds the distance between the two characters
    distx = abs(p1x - p2x);
    disty = abs(p1y - p2y);
    unitdist2 = sqrt(distx^2 + disty^2);
    % As long as the two characters are more than five units away, continue
    % running the loop
    while unitdist2 > 5
        p1walk = randi(4, 1, 1);
        p2walk = randi(4, 1, 1);
        % Base direction of walking on value for random integer
        if p1walk == 1
            p1x = p1x + 1;
        elseif p1walk == 2
            p1x = p1x - 1;
        elseif p1walk == 3
            piy = p1y + 1;
        else
            p1y = p1y - 1;
        end
        % If the character goes out of bounds, make them turn around
        if p1x >= 100
            p1x = p1x - 1;
        end
        if p1y >= 100
            p1y = p1y - 1;
        end
        if p1x <= 0
            p1x = p1x + 1;
        end
        if p1y <= 0
            p1y = p1y + 1;
        end
        if p2walk == 1
            p2x = p2x + 1;
        elseif p2walk == 2
            p2x = p2x - 1;
        elseif p2walk == 3
            p2y = p2y + 1;
        else
            p2y = p2y -1;
        end
        if p2x >= 100
            p2x = p2x - 1;
        end
        if p2y >= 100
            p2y = p2y -1;
        end
        if p2x <= 0
            p2x = p2x + 1;
        end
        if p2y <= 0
            p2y = p2y + 1;
        end
        % Re-calculate the distance at the end of each iteration
        distx = abs(p1x - p2x);
        disty = abs(p1y - p2y);
        unitdist2 = sqrt(distx^2 + disty^2);
        count = count + 1;
    end
    twoperson_iterations(i) = count;
end

avg_twoiterations = mean(twoperson_iterations);
fprintf('The average number of time steps it takes for the characters to find each other is %.2f steps. \n', avg_twoiterations)
figure
hist(twoperson_iterations)
title('Number of Time Steps - Two People Moving')
xlabel('Bins')
ylabel('Frequency')

%% Question 4b

oneperson_iterations = zeros(1, 5000);

for i = 1:length(oneperson_iterations)
    count = 0;
    personA = randi(100, 1, 2)';
    personB = randi(100, 1, 2)';
    pAx = personA(1);
    pAy = personA(2);
    pBx = personB(1);
    pBy = personB(2);
    distx = abs(pAx - pBx);
    disty = abs(pAy - pBy);
    unitdist1 = sqrt(distx^2 + disty^2);
    while unitdist1 > 5
        pAwalk = randi(4, 1, 1);
        if pAwalk == 1
            pAx = pAx + 1;
        elseif pAwalk == 2
            pAx = pAx - 1;
        elseif pAwalk ==3
            pAy = pAy + 1;
        else pAy = pAy - 1;
        end
        if pAx >= 100
            pAx = pAx - 1;
        end
        if pAy >= 100
            pAy = pAy -1;
        end
        if pAx <= 0
            pAx = pAx + 1;
        end
        if pAy <= 0
            pAy = pAy + 1;
        end
        % Re-calculate the distance at the end of each iteration
        distx = abs(pAx - pBx);
        disty = abs(pAy - pBy);
        unitdist1 = sqrt(distx^2 + disty^2);
        count = count + 1;
    end
    oneperson_iterations(i) = count;
end

avg_oneiterations = mean(oneperson_iterations);
fprintf('The average number of time steps it takes for the characters to find each other is %.2f steps. \n', avg_oneiterations)
figure
hist(oneperson_iterations)
title('Number of Time Steps - Two People Moving')
xlabel('Bins')
ylabel('Frequency')
