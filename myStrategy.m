function nextPos=myStrategy(digitArrangement, diceValue)
%myStrategy: Strategy for playing the dice sum game
%	Usage: nextPos=myStrategy(gameState, diceValue)
%		gameState: A 4-by-2 matrix indicating the state of the game
%		diceValue: the dice value after tossing the dice
%		nextPos: Your move for placing the dice value.
%			It should be either 1 or 2:
%			1: Place the value at the ten's position
%			2: Place the value at the one's position
%
%	This function is called in diceSumGame.m.
global t
if (isempty(t) == 1)
    fprintf('Initializing...');
    setGlobal;
end

target = 150;	% This is fixed.
% ====== My strategy starts here...

tenPosCount = sum(digitArrangement(:,1)==0);
onePosCount = sum(digitArrangement(:,2)==0);

x = tenPosCount + 1;
y = onePosCount + 1;
temp = sum(digitArrangement); 
total = 10*temp(1)+temp(2) + 1;

if(x == 1)
    nextPos = 2;
elseif(y == 1)
    nextPos = 1;
else
    stateC = t(x-1,y,total+diceValue*10);
    stateD = t(x,y-1,total+diceValue);
    if (stateC >= stateD)
        nextPos = 1;
    else
        nextPos = 2;
    end
end
end

function setGlobal()
global t
t = zeros(5,5,265);
for i = 45:151
    t(1,1,i) = i;
end
for y = 2:5
    for total = 1:151
        t(1,y,total) = (t(1,y-1,total+1)+t(1,y-1,total+2)+t(1,y-1,total+3)+t(1,y-1,total+4)+t(1,y-1,total+5)+t(1,y-1,total+6))/6;
    end
end
for x = 2:5
    for total = 1:151
        t(x,1,total) = (t(x-1,1,total+10)+t(x-1,1,total+20)+t(x-1,1,total+30)+t(x-1,1,total+40)+t(x-1,1,total+50)+t(x-1,1,total+60))/6;
    end
end

for x = 2:5
    for y = 2:5
        for total = 1:151
            stateA=(t(x,y-1,total+1)+t(x,y-1,total+2)+t(x,y-1,total+3)+t(x,y-1,total+4)+t(x,y-1,total+5)+t(x,y-1,total+6))/6;
            stateB=(t(x-1,y,total+10)+t(x-1,y,total+20)+t(x-1,y,total+30)+t(x-1,y,total+40)+t(x-1,y,total+50)+t(x-1,y,total+60))/6;
            if(stateA>=stateB)
                t(x,y,total)=stateA;
            else
                t(x,y,total)=stateB;
            end
        end
    end
end
end