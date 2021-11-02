function [xPosition, speed, brakeTemperature] = TruckModel(xPosition, ...
speed, gear, ambientTemperature, brakeTemperature, maxBrakeTemperature, ...
mass, gravitationalAcceleration, pedalPressure, Ch, Cb, alpha, timeStep, tau)

    gravitationalForce = mass * gravitationalAcceleration * sind(alpha);
    
    if brakeTemperature < maxBrakeTemperature - 100
        brakeForce = mass * gravitationalAcceleration / 20 * pedalPressure;
    else
        exponentialPart = exp(-(brakeTemperature - (maxBrakeTemperature - 100)) / 100);
        brakeForce = mass * gravitationalAcceleration / 20 * pedalPressure * ...
            exponentialPart;
    end
    
    deltaBrakeTemperature = brakeTemperature - ambientTemperature;
    
    if pedalPressure < 0.01
        dDeltaBrakeTemperature = - deltaBrakeTemperature / tau * timeStep;
        
    else
        dDeltaBrakeTemperature = Ch * pedalPressure * timeStep;
    end
    
    deltaBrakeTemperature = deltaBrakeTemperature + dDeltaBrakeTemperature;
   
    brakeTemperature = ambientTemperature + deltaBrakeTemperature;
    
    if brakeTemperature < ambientTemperature
        brakeTemperature = ambientTemperature;
    end      
    
    engineBrakeForce = [7.0, 5.0, 4.0, 3.0, 2.5, 2.0, 1.6, 1.4, 1.2, 1] * Cb;
    
    acceleration = (gravitationalForce - brakeForce - engineBrakeForce(gear)) / mass;
    speed = speed + acceleration * timeStep;
    xVelocity = speed * cosd(alpha);
    xPosition = xPosition + xVelocity * timeStep;
    
end