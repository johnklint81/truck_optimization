function [wIH, wHO] = InitWeights(nIn, nHidden, nOut, populationSize)


wIH = 2*rand(nHidden, (nIn + 1), populationSize) - 1;
wHO = 2*rand(nOut, (nHidden + 1), populationSize) - 1;

end