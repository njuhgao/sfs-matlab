function [P,x0,win] = wfs_3d(x,y,z,xs,src,f,L,conf)
%WFS_3D returns the sound pressure for 3D WFS at x,y,z
%
%   Usage: [P,x0,win] = wfs_3d(x,y,z,xs,src,f,L,[conf])
%
%   Input parameters:
%       x           - x position(s) / m
%       y           - y position(s) / m
%       z           - z position(s) / m
%       xs          - position of point source / m
%       src         - source type of the virtual source
%                         'pw' - plane wave (xs is the direction of the
%                                plane wave in this case)
%                         'ps' - point source
%                         'fs' - focused source
%       f           - monochromatic frequency / Hz
%       L           - array length / m
%       conf        - optional configuration struct (see SFS_config)
%
%   Output parameters:
%       P           - Simulated wave field
%       win         - tapering window (activity of loudspeaker)
%       x0          - secondary sources / m
% 
%   WFS_3D(x,y,z,xs,L,f,src,conf) returns the sound pressure at
%   the point(s) (x,y,z) for the given source type (src) using a WFS 3
%   dimensional driving function in the temporal domain. This means by
%   calculating the integral for P with a summation.
%
%   References:
%       Spors2009 - Physical and Perceptual Properties of Focused Sources in
%           Wave Field Synthesis (AES127)
%       Williams1999 - Fourier Acoustics (Academic Press)
%
%   see also: wave_field_mono_wfs

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


%% ===== Checking of input  parameters ==================================
nargmin = 7;
nargmax = 8;
error(nargchk(nargmin,nargmax,nargin));
isargmatrix(x,y);
isargxs(xs);
isargpositivescalar(L,f);
isargchar(src);
if nargin<nargmax
    conf = SFS_config;
else
    isargstruct(conf);
end



%% ===== Computation ====================================================
% Calculate the wave field in time-frequency domain
%% ==
xref = conf.xref;


%% ===== Computation ====================================================
% Calculate the wave field in time-frequency domain
%
% Get the position of the loudspeakers and its activity
x0 = secondary_source_positions(L,conf);
x0 = secondary_source_selection(x0,xs,src);
% Generate tapering window
win = tapering_window(x0,conf);
% Driving function
D = driving_function_mono_wfs_3d(x0,xs,src,f,conf) .* win;
% Wave field
[x,y,z,P] = wave_field_mono([x x],[y y],[z z],x0,'ps',D,f,conf);

    
