%Commit number1 from iPad via JumpDesktop remote desktop client

%%Question 1
clc;
clear;
    
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
title('1000 Random Numbers')
xlabel('bins')
ylabel('frequency')

%calculate & display mean and standard deviation
fprintf('\nMean of numbers: \t\t%f', mean(v1));
fprintf('\nStandard deviation of numbers: \t%f', std(v1));

%display counters
fprintf('\nNumbers greater than 0.5: \t%d', greaterThanFive);
fprintf('\nNumbers between 0.3 and 0.7: \t%d', between3and7);
