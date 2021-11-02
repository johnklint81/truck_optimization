function chromosome = EncodeNetwork(wIH, wHO, wMax)

wIH = wIH';
wIH = wIH(:);
wHO = wHO';
wHO = wHO(:);

chromosome = [wIH; wHO] / wMax;

end