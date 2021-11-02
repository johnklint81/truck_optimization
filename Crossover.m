function [newIndividual1, newIndividual2] = Crossover(individual1, individual2)

numberOfGenes = length(individual1);

crossoverPoint = randi(numberOfGenes);
newIndividual1 = zeros(numberOfGenes, 1);
newIndividual2 = zeros(numberOfGenes, 1);

for i = 1:numberOfGenes
    if (i <= crossoverPoint)
        newIndividual1(i) = individual1(i);
        newIndividual2(i) = individual2(i);
    else
        newIndividual1(i) = individual2(i);
        newIndividual2(i) = individual1(i);
    end
end


end