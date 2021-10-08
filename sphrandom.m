function points = sphrandom(num, r, choice)
% points = sphrandom(num, r)
%
% Generates a set of randomly distributed points on a sphere.
%
% INPUT:
%
% num         Desired number of points [defaulted]
% r           Radius of sphere [defaulted, unit sphere]
% choice      0 no plot
%             1 plot
%
% OUTPUT:
%
% points      nx3 matrix with x,y,z coordinates of each point on the sphere
%
%
% Written by Huda Al Alawi (halawi@princeton.edu) - October 8th, 2021.
%

% Define default values
defval('num', 10000)
defval('r', 1)
defval('choice', 1)

% Create n random values appropriate to be used to find the angle theta
% (elevation)
vals = 2 * rand(num,1) - 1;
% Define the elevation and azimuth
ele = asin(vals);
azi = 2 * pi * rand(num,1);
% Convert to Cartesian
[x, y, z] = sph2cart(azi, ele, r);
% Plot if wanted
if choice ==1
    figure
    plot3(x, y, z, '.')
    xlabel('x')
    ylabel('y')
    zlabel('z')
    axis equal
end

% Return nx3 matrix [x, y, z]
points = [x, y, z];

end