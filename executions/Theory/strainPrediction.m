% theoretical lattice constants in angstrom
aCr = 4.96;
cCr = 13.59;
aAl = 4.76;
cAl = 13.00;

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

exxA = (cAl/cCr)-1;
eyyA = (aAl/aCr)-1;
exxM = exxA;
eyyM = eyyA;
eyyC = eyyA;


ezzA = -1*(C13*exxA+C12*eyyA)/C11;
ezzM = -1*(C13*C44*exxM+(C12*C44+C14^2)*eyyM)/(C11*C44-C14^2);
ezzC = -2*C13*eyyC/C33;
ezzR = getezzR([0 1 2]);

d110_ = d110*(1+ezzA);
d100_ = d100*(1+ezzM);
d001_ = d001*(1+ezzC);
d012_ = d012*(1+ezzR);


% n*lambda = 2dsin(theta)
% 2theta = 2*arcsin(n*lambda/(2*d))

lambda = 1.54;

theta2_006 = 2*180/pi * asin(6*lambda/(2*d001)); % in degrees
theta2_024 = 2*180/pi * asin(2*lambda/(2*d012));
theta2_300 = 2*180/pi * asin(3*lambda/(2*d100));
theta2_110 = 2*180/pi * asin(1*lambda/(2*d110));

theta2_006_ = 2*180/pi * asin(6*lambda/(2*d001_));
theta2_024_ = 2*180/pi * asin(2*lambda/(2*d012_));
theta2_300_ = 2*180/pi * asin(3*lambda/(2*d100_));
theta2_110_ = 2*180/pi * asin(1*lambda/(2*d110_));





function ezzR = getezzR(hkl)
C11 = 3.74;
C12 = 1.48;
C13 = 1.75;
C33 = 3.62;
C44 = 1.59;
C14 = -0.19;

aCr = 4.96;
cCr = 13.59;
aAl = 4.76;
cAl = 13.00;

a = aCr;
aF = aCr;
c = cCr;
cF = cCr;

aS = aAl;
cS = cAl;

h = hkl(1);
k = hkl(2);
l = hkl(3);
theta = acos( ...
    l/sqrt(4/3*c^2/a^2*(h^2+h*k+k^2)+l^2) ...
    );


xi0 = C13^2-C11*C13;
xi1 = C13^2-C11*C33;
xi2 = (C11+2*C13+C33)*C44;
xi3 = C12*(C13-C33);
xi4 = 2*(C12+C13)*C44;
xi8 = C11+C12-C33;

eta = xi1+(2*C13-3*(C33+C11))*C44-4*(C33-C11)*C44*cos(2*theta)-(xi1+xi2)*cos(4*theta);
mu = eta + C14*(4*(C33-C13+(C33+C13)*cos(2*theta))*sin(2*theta))+8*C14^2*sin(theta)^4;

zeta3322 = -xi0-xi3+xi4+4*(C13-C12)*C44*cos(2*theta)+(xi0+xi3+xi4)*cos(4*theta);
zeta3311 = -xi1+(6*C13-C11-C33)*C44+(xi1+xi2)*cos(4*theta);

tau3322 = zeta3322 + C14*(2*(C11+C12-3*C13+C33)*sin(2*theta)-(xi8+3*C13)*sin(4*theta))-8*C14^2*cos(2*theta)*sin(theta)^2;
tau3311 = zeta3311 - 2*C14*(C33+C13)*sin(4*theta)+2*C14^2*sin(2*theta)^2;


e11 = aS/aF*cos(theta)^2+cS/cF*sin(theta)^2-1;
e22 = aS/aF-1;

ezzR = (tau3311*e11+tau3322*e22)/mu;


end