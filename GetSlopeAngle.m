%% This file provides the FORMAT you should use for the
%% slopes in HP2.3. x denotes the horizontal distance
%% travelled (by the truck) on a given slope, and
%% alpha measures the slope angle at distance x
%%
%% iSlope denotes the slope index (i.e. 1,2,..10 for the
%% training set etc.)
%% iDataSet determines whether the slope under consideration
%% belongs to the training set (iDataSet = 1), validation
%% set (iDataSet = 2) or the test set (iDataSet = 3).
%%
%% Note that the slopes given below are just EXAMPLES.
%% Please feel free to implement your own slopes below,
%% as long as they fulfil the criteria given in HP2.3.
%%
%% You may remove the comments above and below, as they
%% (or at least some of them) violate the coding standard
%%  a bit. :)
%% The comments have been added as a clarification of the
%% problem that should be solved!).


function alpha = GetSlopeAngle(x, iSlope, iDataSet)


if (iDataSet == 1)
    % Training
    if (iSlope == 1)
        alpha = 4 + sin(x/100) + cos(sqrt(2)*x/50) - (x/7000);
    elseif (iSlope== 2)
        alpha = 6 + sin(x/70) - cos(sqrt(2/3)*x/90);
    elseif (iSlope== 3)
        alpha = 4 - sin(x/185) + cos(sqrt(5)*x/160) - (x/1000);
    elseif (iSlope== 4)
        alpha = 5 + 3*sin(x/120) - 0.5*cos(sqrt(2)*x/120);
    elseif (iSlope== 5)
        alpha = 5 - sin(x/110) + cos(sqrt(5)*x/70);
    elseif (iSlope== 6)
        alpha = 4 - 2*sin(x/132) + cos(sqrt(2)*x/70) - (x/790);
    elseif (iSlope== 7)
        alpha = 5 + sin(x/130) + 2*cos(sqrt(23)*x/167) + (x/6000);
    elseif (iSlope== 8)
        alpha = 5 - 3*sin(x/88) - cos(sqrt(15)*x/93);
    elseif (iSlope== 9)
        alpha = 2 + sin(x/73) + cos(sqrt(2)*x/64);
    elseif (iSlope== 10)
        alpha = 3 + 2*sin(x/50) - cos(sqrt(2)*x/100);
    end
    
elseif (iDataSet == 2)
    % Validation
    if (iSlope == 1)
        alpha = 6 - sin(x/100) + cos(sqrt(3)*x/50);
    elseif (iSlope == 2)
        alpha = 2 + sin(x/89) + cos(sqrt(5)*x/80) + (x/1000);
    elseif (iSlope == 3)
        alpha = 5 - 2*sin(x/125) + cos(sqrt(7)*x/116);
    elseif (iSlope == 4)
        alpha = 3 + sin(x/75) - cos(sqrt(9)*x/100) - (x/900);
    elseif (iSlope == 5)
        alpha = 5 - 2*sin(x/55) + 3*cos(sqrt(2)*x/90) - (x/600);
    end
    
elseif (iDataSet == 3)
    % Test
    if (iSlope == 1)
        alpha = 6 - sin(x/100) + cos(sqrt(3)*x/50);
    elseif (iSlope == 2)
        alpha = 4 + (x/800) + sin(x/125) + cos(sqrt(9)*x/98);
    elseif (iSlope == 3)
        alpha = 3 + (x/700) - 2*sin(x/35) + cos(sqrt(3)*x/54);
    elseif (iSlope == 4)
        alpha = 5 - (x/1410) + sin(x/124) - cos(sqrt(9)*x/89);
    elseif (iSlope == 5)
        alpha = 4 + (x/1000) + sin(x/70) + cos(sqrt(7)*x/100);       
    end
    
end
