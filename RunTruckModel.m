function [xPosition, meanSpeed] = RunTruckModel(xPosition, xMax, iSlope, ...
    iDataSet, gear, speed, maxSpeed, minSpeed, alphaMax, brakeTemperature, ...
    maxBrakeTemperature, ambientTemperature, wIH, wHO, sigmoidConstant, mass, ...
    gravitationalAcceleration, Ch, Cb, timeStep, tau)

counter = 0;
meanSpeed = speed;
timeSinceGearChange = 2.0;

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
    meanSpeed = meanSpeed + speed;
    
    if speed > maxSpeed
        meanSpeed = meanSpeed / counter;
        return
    elseif speed < minSpeed
        meanSpeed = meanSpeed / counter;
        return
    elseif brakeTemperature > maxBrakeTemperature
        meanSpeed = meanSpeed / counter;
        return
        
    end
    
end

meanSpeed = meanSpeed / counter;

end