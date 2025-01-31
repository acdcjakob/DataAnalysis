a = 5.046;
b = 8.702;
c = 9.283;

d = @(hkl) 1/sqrt(hkl(1)^2/a^2+hkl(2)^2/b^2+hkl(3)^2/c^2);

lambda = 1.5406;

theta2 = @(d,factor,n) 2 * asin(lambda/2/(d));

theta2(d([0 0 4]))*180/pi