function [Cr2O3_peaks,Al2O3_peaks] = getPeakReference()
% c m r(01.2) a r(02.4)
Cr2O3_peaks = [39.78 ; 65.11 ; 24.48 ; 36.19 ; 50.20];
% Cr2O3_peaks_own = [nan; 65.2 ; 24.6 ; 36.3 ];


Al2O3_peaks = [41.68 ; 68.27 ; 25.59 ; 37.81 ; 52.58];
return
% alternate calculation
% a_Cr = 4.96;
% c_Cr = 13.59;
% d = @(h,k,l,a,c) 1/sqrt(4/3*(h^2+k^2+h*k)/a^2+l^2/c^2);
% theta2 = @(d,n) asin(n*1.5406/2/d)*2;
% Cr2O3_peaks = [
%     theta2(d(0,0,6,a_Cr,c_Cr),1);
%     theta2(d(3,0,0,a_Cr,c_Cr),1);
%     theta2(d(0,1,2,a_Cr,c_Cr),1);
%     theta2(d(1,1,0,a_Cr,c_Cr),1);
%     ]

end