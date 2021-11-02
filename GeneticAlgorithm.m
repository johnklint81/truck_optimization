function [wIHOptimized, wHOOptimized] = GeneticAlgorithm(wIHPopulation, ...
    wHOPopulation, fitnessList, tournamentProbability, ...
    tournamentSize, crossoverProbability, mutationProbability, creepRate, ...
    creepProbability, nIn, nOut, nHidden, wMax)

wIHOptimized = zeros(size(wIHPopulation));
wHOOptimized = zeros(size(wHOPopulation));
numberOfGenes = size(wIHPopulation, 1) * size(wIHPopulation, 2) ...
    + size(wHOPopulation, 1) * size(wHOPopulation, 2);

populationSize = size(wIHPopulation, 3);
population = zeros(numberOfGenes, populationSize);

for i = 1:populationSize
    population(:, i) = EncodeNetwork(wIHPopulation(:, :, i), wHOPopulation(:, :, i), wMax);
end

% Elitism
[~, maximumFitnessIndex] = max(fitnessList);
bestIndividual = population(:, maximumFitnessIndex);

temporaryPopulation = population;

% Tournament selection
for i = 1:2:populationSize
    i1 = TournamentSelect(fitnessList, tournamentProbability, ...
        tournamentSize);
    i2 = TournamentSelect(fitnessList, tournamentProbability, ...
        tournamentSize);
    % Crossover
    r = rand();
    if r < crossoverProbability
        individual1 = population(:, i1);
        individual2 = population(:, i2);
        [newIndividual1, newIndividual2] = Crossover(individual1, individual2);
        temporaryPopulation(:, i) = newIndividual1;
        temporaryPopulation(:, i + 1) = newIndividual2;
        
    else
        temporaryPopulation(:, i) = population(:, i1);
        temporaryPopulation(:, i + 1) = population(:, i2);
    end
end

temporaryPopulation(:, 1) = bestIndividual;

% Mutation
for i = 2:populationSize
    tempIndividual = Mutate(temporaryPopulation(:, i), ...
        mutationProbability, creepProbability, creepRate);
    temporaryPopulation(:, i) = tempIndividual;
end

population = temporaryPopulation;

% Decode
for i = 1:populationSize
    chromosome = population(:, i);
    [wIHOptimizedTemp, wHOOptimizedTemp] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax);
    wIHOptimized(:, :, i) = wIHOptimizedTemp;
    wHOOptimized(:, :, i) = wHOOptimizedTemp;
end

end