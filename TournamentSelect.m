function selectedIndividualIndex = TournamentSelect(fitnessList, tournamentProbability, tournamentSize)

lengthFitnessList = length(fitnessList);
selectedCandidatesIndex = randi(lengthFitnessList, tournamentSize, 1);
selectedCandidatesFitnessValue = fitnessList(selectedCandidatesIndex);
lengthSelectedCandidates = tournamentSize;
randomNumber = 42;

while (randomNumber >= tournamentProbability) && (lengthSelectedCandidates > 1)
    
    randomNumber = rand();
    [~, maxSelectedCandidatesFitnessIndex] ...
        = max(selectedCandidatesFitnessValue);
    
    if (randomNumber < tournamentProbability)
        selectedIndividualIndex = selectedCandidatesIndex(maxSelectedCandidatesFitnessIndex);
    else
        selectedCandidatesIndex(maxSelectedCandidatesFitnessIndex) = [];
        selectedCandidatesFitnessValue(maxSelectedCandidatesFitnessIndex) = [];
    end
    
    lengthSelectedCandidates = length(selectedCandidatesIndex);
end

% If randomNumber rejects all but the last candidate.
if lengthSelectedCandidates == 1
    selectedIndividualIndex = selectedCandidatesIndex(1);
end
end