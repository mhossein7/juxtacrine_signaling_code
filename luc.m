function photon = luc(t,E)

K = 30071 * 60; %per mole per second
% E in nM
photon = K * E * 1e-9*t;


