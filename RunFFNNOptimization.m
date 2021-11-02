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
tournamentSize = 4;
tournamentProbability = 0.75;
crossoverProbability = 0.7;
mutationProbability = 1 / numberOfGenes;
creepRate = 0.1;
creepProbability = 0.8;

nTracks = 10;
nValidationTracks = 5;
training = true;
fitnessArray = zeros(populationSize, nTracks);
fitnessValidationList = zeros(nValidationTracks, 1);
xPositionValidationList = zeros(nValidationTracks, 1);
generationCounter = 0;

[wIHPopulation, wHOPopulation] = InitWeights(nIn, nHidden, nOut, populationSize);

while training
    iDataSet = 1;
    for i = 1:populationSize
        wIH = wIHPopulation(:, :, i);
        wHO = wHOPopulation(:, :, i);
        for iSlope = 1:nTracks
            speed = startSpeed;
            xPosition = startXPosition;
            brakeTemperature = startBrakeTemperature;
            gear = startGear;
            [xPosition, meanSpeed] = RunTruckModel(xPosition, xMax, iSlope, ...
                iDataSet, gear, speed, maxSpeed, minSpeed, alphaMax, brakeTemperature, ...
                maxBrakeTemperature, ambientTemperature, wIH, wHO, sigmoidConstant, mass, ...
                gravitationalAcceleration, Ch, Cb, timeStep, tau);
            fitnessArray(i, iSlope) = ComputeFitness(xPosition, meanSpeed);
        end
    end
    generationCounter = generationCounter + 1;
    meanFitnessList = mean(fitnessArray, 2);
    [wIHPopulation, wHOPopulation] = GeneticAlgorithm(wIHPopulation, ...
    wHOPopulation, meanFitnessList, tournamentProbability, ...
    tournamentSize, crossoverProbability, mutationProbability, creepRate, ...
    creepProbability, nIn, nOut, nHidden, wMax);
    
    % Validation
    iDataSet = 2;
    [bestIndividualFitness, bestIndividualIndex] = max(meanFitnessList);
    generationFitnessHistory(generationCounter) = bestIndividualFitness;
    wIH = wIHPopulation(:, :, bestIndividualIndex);
    wHO = wHOPopulation(:, :, bestIndividualIndex);
    for iSlope = 1:nValidationTracks
        speed = startSpeed;
        xPosition = startXPosition;
        brakeTemperature = startBrakeTemperature;
        gear = startGear;
        [xPosition, meanSpeed] = RunTruckModel(xPosition, xMax, iSlope, ...
            iDataSet, gear, speed, maxSpeed, minSpeed, alphaMax, brakeTemperature, ...
            maxBrakeTemperature, ambientTemperature, wIH, wHO, sigmoidConstant, mass, ...
            gravitationalAcceleration, Ch, Cb, timeStep, tau);
        xPositionValidationList(iSlope) = xPosition;
        fitnessValidationList(iSlope) = ComputeFitness(xPosition, meanSpeed);
    end
    
    generationValidationFitnessHistory(generationCounter) = mean(fitnessValidationList);
    if all(xPositionValidationList > xMax) && all(fitnessValidationList > 15000)
        training = false;
        bestChromosome = EncodeNetwork(wIH, wHO, wMax);
        matlab.io.saveVariablesToScript('BestChromosome.m', 'bestChromosome');
    end
    fprintf('\nValidation run: %d\n', generationCounter);
    fprintf('-------------------');
    fprintf('\nPosition, Validation score: \n');
    fprintf('---------------------------\n');
    for iSlope = 1:nValidationTracks
        fprintf('%.3f, ', xPositionValidationList(iSlope));
        fprintf('%.3f\n', fitnessValidationList(iSlope));
    end
end

figure()
hold on
xlim([-25, 1750])
generation = 1:generationCounter;
plot(generation, generationValidationFitnessHistory(1:generationCounter), 'r')
plot(generation, generationFitnessHistory(1:generationCounter), 'k', 'linewidth', 1.5)
xlabel('Generation')
ylabel('Fitness')
legend('Training', 'Validation', 'Location', 'southeast')
title('Fitness score vs generation.')

