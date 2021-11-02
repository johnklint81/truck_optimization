function [xPosition, meanSpeed, angleHistory, pedalPressureHistory, gearHistory, ...
    speedHistory, brakeTemperatureHistory, xPositionHistory] = RunBestTruckModel(xPosition, xMax, iSlope, ...
    iDataSet, gear, speed, maxSpeed, minSpeed, alphaMax, brakeTemperature, ...
    maxBrakeTemperature, ambientTemperature, wIH, wHO, sigmoidConstant, mass, ...
    gravitationalAcceleration, Ch, Cb, timeStep, tau)

angle = GetSlopeAngle(xPosition, iSlope, iDataSet);
counter = 0;
meanSpeed = speed;
timeSinceGearChange = 2.0;
angleHistory = [angle];
pedalPressureHistory = [0];
gearHistory = [gear];
speedHistory = [speed];
brakeTemperatureHistory = [brakeTemperature];
xPositionHistory = [xPosition];

while xPosition < xMax
    counter = counter + 1;
    alpha = GetSlopeAngle(xPosition, iSlope, iDataSet);
    normSpeed = speed / maxSpeed;
    normAlpha = alpha / alphaMax;
    normBrakeTemperature = brakeTemperature / maxBrakeTemperature;
    [pedalPressure, deltaGear] = FFNN(wIH, wHO, normSpeed, normAlpha, normBrakeTemperature, sigmoidConstant);
    
    if (timeSinceGearChange >= 2.0) && (deltaGear ~= 0)
        if gear > 1 && deltaGear < 0
            gear = gear + deltaGear;
            timeSinceGearChange = 0.0;           
        elseif gear < 10 && deltaGear > 0
            gear = gear + deltaGear;
            timeSinceGearChange = 0.0;
        end
    else
        timeSinceGearChange = timeSinceGearChange + timeStep;
    end
    
    [xPosition, speed, brakeTemperature] = TruckModel(xPosition, ...
        speed, gear, ambientTemperature, brakeTemperature, maxBrakeTemperature, ...
        mass, gravitationalAcceleration, pedalPressure, Ch, Cb, alpha, timeStep, tau);
    xPositionHistory(counter + 1) = xPosition;
    angleHistory(counter + 1) = alpha;
    pedalPressureHistory(counter + 1) = pedalPressure;
    gearHistory(counter + 1) = gear;
    speedHistory(counter + 1) = speed;
    brakeTemperatureHistory(counter + 1) = brakeTemperature;
    meanSpeed = meanSpeed + speed;
    if speed > maxSpeed
        meanSpeed = meanSpeed / counter;
        fprintf('Too fast!\n');
        return
    elseif speed < minSpeed
        meanSpeed = meanSpeed / counter;
        fprintf('Too slow!\n');
        return
    elseif brakeTemperature > maxBrakeTemperature
        fprintf('Too hot!\n');
        meanSpeed = meanSpeed / counter;
        return
        
    end
    
end

meanSpeed = meanSpeed / counter;

end