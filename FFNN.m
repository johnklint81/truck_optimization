function [pedalPressure, deltaGear] = FFNN(wIH, wHO, normSpeed, normAlpha, normBrakeTemperature, sigmoidConstant)

inputLayer = [normSpeed; normAlpha; normBrakeTemperature];
inputBias = wIH(:, end);
hiddenField = wIH(:, 1:end - 1) * inputLayer + inputBias;
hiddenLayer = 1 ./ (1 + exp(-sigmoidConstant * hiddenField));

outputBias = wHO(:, end);
outputField = wHO(:, 1:end - 1) * hiddenLayer + outputBias;
outputLayer = 1 ./ (1 + exp(-sigmoidConstant * outputField));

pedalPressure = outputLayer(1);
deltaGear = outputLayer(2);

if deltaGear > 2/3
    deltaGear = 1;
elseif deltaGear < 1/3
    deltaGear = -1;
else
    deltaGear = 0;
end

end