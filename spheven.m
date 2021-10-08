function points = spheven(num, choice)
% points = spheven(num, choice)
%
% Generates a set of equidistant points on a unit sphere using Fibonacci 
% sphere algorithm.
%
% INPUT:
%
% num         Desired number of points [defaulted]
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
defval('num', 2000)
defval('choice', 1)

% Define the golden angle
ang = (3 - sqrt(5)) * pi;

% Multiples of golden angle for the number of desired points
th = ang * (0:num-1);

% For a unit sphere, z will be from -1 to 1
% So, define some z values from -1 to 1 for all points
z = linspace(1/num-1, 1-1/num, num);

% We need r to get x and y using shperical to Cartesian transformation
r = sqrt(1 - z.*z);

% We have multiples og golden angle, we can use them with the defined radii
% to find x and y coordinates of the points
x = r.*cos(th);
y = r.*sin(th);

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
points = [x', y', z'];

end