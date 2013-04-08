function [C,idx] = findnearestneighbour_distance(A,b,X0)
%FINDNEARESTNEIGHBOUR finds the 2 nearest neighbours
%
%   Usage: [C,idx] = findnearestneighbour_distance(A,b,X0);
%
%   Input parameters:
%       A                     - matrix
%       b                     - colum to search for in A
%       conf.X0               - listener position 
%                              (in cartesian coordinates and as row vector)
%
%   output parameters:
%       C                     - found neighbour columns
%       idx                   - indices of found columns in matrix
%
%   FINDNEARESTNEIGHBOUR_DISTANCE(A,b,number_of_neighbours) returns 2
%   column vectors with the nearest neighbour points from the matrix A to the
%   point b. In addition to the values, the indices are also returned.
%
%   See also: find, findrows

%*****************************************************************************
% Copyright (c) 2010-2012 Quality & Usability Lab                            *
%                         Deutsche Telekom Laboratories, TU Berlin           *
%                         Ernst-Reuter-Platz 7, 10587 Berlin, Germany        *
%                                                                            *
% This file is part of the Sound Field Synthesis-Toolbox (SFS).              *
%                                                                            *
% The SFS is free software:  you can redistribute it and/or modify it  under *
% the terms of the  GNU  General  Public  License  as published by the  Free *
% Software Foundation, either version 3 of the License,  or (at your option) *
% any later version.                                                         *
%                                                                            *
% The SFS is distributed in the hope that it will be useful, but WITHOUT ANY *
% WARRANTY;  without even the implied warranty of MERCHANTABILITY or FITNESS *
% FOR A PARTICULAR PURPOSE.                                                  *
% See the GNU General Public License for more details.                       *
%                                                                            *
% You should  have received a copy  of the GNU General Public License  along *
% with this program.  If not, see <http://www.gnu.org/licenses/>.            *
%                                                                            *
% The SFS is a toolbox for Matlab/Octave to  simulate and  investigate sound *
% field  synthesis  methods  like  wave  field  synthesis  or  higher  order *
% ambisonics.                                                                *
%                                                                            *
% http://dev.qu.tu-berlin.de/projects/sfs-toolbox       sfstoolbox@gmail.com *
%*****************************************************************************


%% ===== Checking of input parameters ====================================
nargmin = 3;
nargmax = 3;
narginchk(nargmin,nargmax);
b = column_vector(b);

%% ===== Computation =====================================================
% loop through the points and calculate distances
distance = zeros(1,size(A,2));
for ii=1:size(A,2)
    distance(ii) = norm(A(:,ii)-b);
end
% sort the distances in order to find the 2 lowest once
[~,idx] = sort(distance);
idx2 = idx(1:2);
D = A(:,idx2);
% calculate the distance from the desired point to the listener position
origin_distance = norm(b-X0');
% set counter variables
ii=0;
counter = 1;
% search for the nearest neighbours with repsect to the ITD
while ii<1
    % calculate the distance from the 2 actual nearest neighbours
    distance1 = norm(D(:,1)-X0');
    distance2 = norm(D(:,2)-X0');
    % if there is no nearest neighbour left and right from your desired 
    % point keep one point and search for the next nearest neighbour. Do so 
    % as long as both points are not smaller oder higher then the 
    % disered one
    if (distance1 < origin_distance && distance2 < origin_distance) || (distance1 > origin_distance && distance2 > origin_distance)
        % set the new nearest neighbour
        idx2 = [idx(1) idx(2+counter)];
        D = A(:,idx2);
        counter = counter+1;
   
    else
        
        C = D;
        ii=1;
        idx = idx2;
        
    end
    
end