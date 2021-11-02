This program trains an artificial neural network to drive down a slope with a variable slope angle. The truck is not allowed to faster or slower than a certain threshold and is equipped with engine brakes and normal brakes (which are possible to overheat). 

The network is evaluated and optimized through a a genetic algorithm employing operations such as elitism, crossover and mutation. The network trains on a set of slope and uses hold-out validation to determine when training is complete. The resulting network is saved as a chromosome in BestChromosome.m. It is then allowed to run on a set of test courses.

Use RunFFNNOptimization.m to train, angleView.m to view the angles in GetSlopeAngle.m and finally RunTest.m to load and test the trained network.
