figure()
iDataSet = 3;
iSlope = 4;
x = linspace(0, 1000, 1000);

alpha = GetSlopeAngle(x, iSlope, iDataSet);

plot(x, alpha)
xlabel("Position")
ylabel("Angle")

