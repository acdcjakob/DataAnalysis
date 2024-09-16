theta_m = @(ceta,cS,cF) ...
    2/3*sqrt(3)/((20*ceta/(24+6*ceta^2))+ceta)*...
    (cS/cF-1);

c_Al2O3 = 13; % angstrom
c_Cr2O3 = 13.59;
a_Cr2O3 = 4.96;
ceta_Cr2O3 = c_Cr2O3/a_Cr2O3;

theta_m(ceta_Cr2O3,c_Al2O3,c_Cr2O3)*180/pi