%Isabelle Lai 919259175


%100,000 trials
%display results in 9x9 table
%   index slots, row = where chip was dropped, column is probability it
%   falls in that column 



cols = 9;
rows = 7; %constant value
board = zeros(cols, cols); % 9x9 solution board

total_trials = 100000;


%array for money per final slot; index from 1-9 represents slot that that
%money is assigned to
money = [100, 500, 1000, 0, 10000, 0, 1000, 500, 100];
money_per_start = zeros(1, cols);

%not near a wall, example i=4
%at the next t level where every t has 9 spaces for the chip
% i can be i=3, 4, 5
% 3 = LL; 4 = LR, RL; 5 = RR
%P(net left) = 1/4, P(straight down) = 1/2, P(net right) = 1/4

%near a wall, example i=1
%at next level i can be i=1, 2
%1 = RL; 2= RR (first drop needs to be R; L would be wall)
%P(straight down) = 1/2, P(right) = 1/2



for start = 1:cols 

    for trials = 1:total_trials %100000 trials
        %curr = where the chip currently is at (column space in a given row)
        curr = start;
    
        %the next row of the array represents the next full level down
        %-1 from the rows since the last row doesn't fall again or 
        %hit any more pegs before the final spot it lands in
        for level = 1:rows-1 %for every row of the array (every level); 
       
            next = randi([0,1], 1); %randomly chooses 0 or 1
        
            if curr == 9 || curr == 1 %if at a wall
                if next == 0 %move if 0, dont move if 1
                    if curr == 9
                        curr = curr-1; % move left if curr is at right wall
                    else
                        curr = curr+1; % move right if curr is at left wall
                    end
                end
          
            else %not at a wall
                next2 = randi([0,1], 1);
                if next == next2 %LL or RR = not straight down
                    if next == 0 
                        curr = curr-1;
                    else
                        curr = curr+1;
                    end
                end %otherwise straight down = no change to curr
            end

        end
        
        board(start, curr) = (board(start, curr)+1);
        
    end

    %expected $ for given starting slot = sum of (money*probability)for each
    %slot
    expected_win = 0; 
    
    for p = 1:cols
        board(start, p) = (board(start, p) / total_trials);
        expected_win = expected_win + (board(start, p) * money(p));
    end
    
    
    money_per_start(start) = expected_win;



end

fprintf("Probability array: \n")
disp(board)

fprintf("Total money arr: \n")
disp(money_per_start)

win_slot = 1;
for win = 1:cols
    if money_per_start(win) > money_per_start(win_slot)
        win_slot = win;
    end
end

fprintf("The slot most likely to get the most money is slot ")
disp(win_slot)


    
       