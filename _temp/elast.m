% c-orientation
e3_ = @(C13,C33,aS,aF) -2*C13/C33*(aS/aF - 1);

C13 = 1.75;
C33 = 3.62;

aS = 4.76;
aF = 4.96;

e3 = e3_(C13,C33,aS,aF);

% m-orientation

% e3_ = @(C,aS,cS,aF,cF) ...
%     (aS*cF*(C(4)^2+C(2)*C(5)) - (aF*(cF*C(4)^2+(cF*C(2)+cF*C(3)-cS*C(3))*C(5))*C(3)) ...
%     )/...
%     (aF*cF*(C(4)^2-C(1)*C(5)) ...
%     );
% grundmann paper 2018
e3_ = @(C,aS,cS,aF,cF) ...
    -1*(C(3)*C(5)*(cS/cF-1)+(C(2)*C(5)+C(4)^2)*(aS/aF-1))/...
    (C(1)*C(5)-C(4)^2);

%%
% C = (C11,C12,C13,C14,C44)
C = [3.74,1.48,1.75,-0.19,1.59];

aS = 4.935;
cS = 13.55;
aF = 4.96;
cF = 13.59;

%% lattice tilt

aS = 4.935;
cS = 13.55;
aF = 4.96;
cF = 13.59;

C11=3.74;
C12=1.48;
C13=1.75;
C14=-0.19;
C44=1.59;

e1_ = cS/cF-1;
e2_ = aS/aF-1;
e5_ = C14*(C44*e1_+(C12*C44+C14^2)*e2_)/(C11*C44-C14^2);


atan(e5_)*180/pi*60



