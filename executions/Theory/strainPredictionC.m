% theoretical lattice constants in angstrom
aCr = 4.96;
cCr = 13.59;
aAl = 4.76;
cAl = 13.00;
% aAl = aCr*(1-0.3*0.01);
% cAl = cCr*(1-0.3*0.01);

q = ...
    @(hkl,a,c) ...
    sqrt(...
    4/3*(hkl(1)^2+hkl(2)^2+hkl(1)*hkl(2))/a^2 + ...
    hkl(3)^2/c^2);

d001 = 1/q([0 0 1],aCr,cCr);
d012 = 1/q([0 1 2],aCr,cCr);
d100 = 1/q([1 0 0],aCr,cCr);
d110 = 1/q([1 1 0],aCr,cCr);

C11 = 3.74;
C12 = 1.48;
C13 = 1.75;
C33 = 3.62;
C44 = 1.59;
C14 = -0.19;

aSub = linspace(aAl,aCr,20);

eyyC = (aSub/aCr)-1;

ezzC = -2*C13*eyyC/C33;

