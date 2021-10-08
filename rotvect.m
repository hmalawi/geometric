function R = rotvect(a, b)
% R = rotvect(a, b)
%
% This function returns a rotation matrix that rotates [x,y,z] from
% (a) to (b).
%
% INPUT:
%
% a           Rotate-from vector
% b           Rotate-to vector
%
% OUTPUT:
%
% R           3x3 rotation matrix
%
% SEE ALSO:
%
% https://en.wikipedia.org/wiki/Rodrigues%27_rotation_formula
%
% In this code, I will mostly use the same notations as the ones on the 
% quoted web page to make it easier to link the code implementation to the 
% mathematical explanation. 
%
% EXAMPLE (rotation from z-axis to x-axis)
% plot3([-1 1],[0 0],[0 0],'k')
% hold on
% plot3([0 0], [-1 1], [0 0], 'k')
% plot3([0 0], [0 0], [-1 1], 'k')
% R = rotvect([0 0 1], [1 0 0]);
% th = 60*pi/180;
% phi = 0:2*pi/100:2*pi;
% r = ones(1, length(phi))/6;
% [x,y,z] = sph2cart(phi, th, r);
% plot3(x, y, z, '.')
% v=[x;y;z];
% vrot=R*v;
% plot3(vrot(1,:), vrot(2,:), vrot(3,:), '.')
%
% Written by Huda Al Alawi (halawi@princeton.edu) - October 7th, 2021.
% Last modified by Huda Al Alawi - October 8th, 2021
% Originally implemented by Lucas Sawade (lsawade@princeton.edu) using Python
%

% Need to normalize the vectors to make this algorithm works
anorm = a./norm(a,2);
bnorm = b./norm(b,2);

% The main algorithm "Rodrigues' rotation" describes how the original 
% vector (a) rotates about a unit vector (k) to a new position (b) that's 
% at an angle theta from (a). Here, we don't have the rotation axis BUT we 
% will need it to find the skew-symmetric cross-product matrix (K) in order
% to find the rotation matrix. So, we will define a unit rotation axis as 
% a vector that is orthogonal to both (a) and (b). Which can be obtained by 
% finding the cross product of the normalized (a) & (b).
k = cross(anorm, bnorm);

% Now define the cross-product matrix (K)
%  0  -kz  ky
%  kz  0  -kx
% -ky  kx  0
K = [0 -k(3) k(2); k(3) 0 -k(1); -k(2) k(1) 0];

% Now, find the rotation matrix
% R = I + sin(theta)*K + (1-cos(theta))*K^2
% The unit vector k that is ultimately used to find K is descibed as
% k = (a x b) / |a||b|sin(theta)
% It has been found earlier as the cross product of normalized (a) & (b),
% and hence, the terms that has K in the rotation matrix formula should be
% divided by sin(theta)...
% R = I + K + ((1-cos(theta))*K^2 / sin^2(theta)
% sin^2(theta) = 1-cos^2(thata) = (1-cos(theta)) * (1+cos(theta))
% So...
% R = I + K + K^2/(1+cos(theta))
% Where K^2 = K.K (dot product) and 
% cos(theta) = anorm.bnorm
costh = dot(anorm, bnorm);
% This is a dot product for matrices
% dot function isn't smart enough to do it!
K2 = K*K;
R = eye(3) + K + (K2 * 1/(1+costh));

end