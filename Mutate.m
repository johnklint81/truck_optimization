function mutatedChromosome = Mutate(chromosome, mutationProbability, creepProbability, creepRate)

lengthOfChromosome = length(chromosome);
mutatedChromosome = chromosome;

for i = 1:lengthOfChromosome
    r = rand();
    if r < mutationProbability
        s = rand();
        if s < creepProbability
            q = rand();
            mutatedChromosome(i) = mutatedChromosome(i) - creepRate / 2 + ...
                q * creepRate;
            if mutatedChromosome(i) > 1
                mutatedChromosome(i) = 1;
            elseif mutatedChromosome(i) < -1
                mutatedChromosome(i) = -1;
            end
        else
            q = rand();
            mutatedChromosome(i) = -1 + 2 * q;
        end       
    end
end

end