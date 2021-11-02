function [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax)


chromosomeIH = chromosome(1:(nHidden * (nIn+1))) * wMax;
chromosomeHO = chromosome((nHidden * (nIn+1)+1):end) * wMax;

wIH = reshape(chromosomeIH, [(nIn+1), nHidden])';
wHO = reshape(chromosomeHO, [(nHidden+1), nOut])';

end