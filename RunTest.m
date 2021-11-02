% Initialize variables, constants, etc
clear all

wMax = 10;
sigmoidConstant = 2; % constant for sigmoid
alphaMax = 10;
maxSpeed = 25;
minSpeed = 1;
maxBrakeTemperature = 750;
xMax = 1000;
mass = 20000;
gravitationalAcceleration = 9.81;
tau = 30;
timeStep = 0.1;
Ch = 40;
Cb = 3000;
ambientTemperature = 283;
vMax = 25;
vMin = 1;
alphaMax = 10;
startXPosition = 0;
startSpeed = 20;
startGear = 7;
startBrakeTemperature = 500;
nIn = 3;
nOut = 2;
nHidden = 10;
numberOfGenes = (nIn + 1) * nHidden + nOut * (nHidden + 1);
populationSize = 100;

nTracks = 10;
nValidationTracks = 5;
nTestTracks = 5;
iDataSet = 3;

BestChromosome;
[wIH, wHO] = DecodeChromosome(bestChromosome, nIn, nHidden, nOut, wMax);


for iSlope = 1:nTestTracks
    speed = startSpeed;
    xPosition = startXPosition;
    brakeTemperature = startBrakeTemperature;
    gear = startGear;
    [xPosition, meanSpeed, angleHistory, pedalPressureHistory, gearHistory, ...
        speedHistory, brakeTemperatureHistory, xPositionHistory] = RunBestTruckModel(xPosition, xMax, iSlope, ...
        iDataSet, gear, speed, maxSpeed, minSpeed, alphaMax, brakeTemperature, ...
        maxBrakeTemperature, ambientTemperature, wIH, wHO, sigmoidConstant, mass, ...
        gravitationalAcceleration, Ch, Cb, timeStep, tau);
    figure(iSlope)
    subplot(5, 1, 1)
    
    plot(xPositionHistory, angleHistory, 'k')
    xlim([0, 1000])
    title('Slope angle')
    ylabel('{\it \alpha} [°]')
    subplot(5, 1, 2)
    plot(xPositionHistory, pedalPressureHistory, 'k')
    xlim([0, 1000])
    title('Pedal pressure')
    ylabel('{\it P} [Pa]')
    subplot(5, 1, 3)
    plot(xPositionHistory, gearHistory, 'k')
    xlim([0, 1000])
    title('Gear history')
    ylabel('Gear')
    subplot(5, 1, 4)
    plot(xPositionHistory, speedHistory, 'k')
    xlim([0, 1000])
    title('Speed')
    ylabel('{\it v_x} [m/s]')
    subplot(5, 1, 5)
    plot(xPositionHistory, brakeTemperatureHistory, 'k')
    xlim([0, 1000])
    title('Brake temperature')
    ylabel('{\it T} [K]')
    xlabel('{\it x} [m]')
    fprintf('%.4f\n',xPosition)
end


