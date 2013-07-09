function m = moreland(n)
%MORELAND   Divergent red-white-blue color map
%   MORELAND(N) returns an N-by-3 matrix containing a divergent colormap.
%   MORELAND, by itself, is the same length as the current figure's
%   colormap. If no figure exists, MATLAB creates one.
%
%   For example, to reset the colormap of the current figure:
%
%             colormap(moreland)
%
%   Coded by Lewis Marshall

if nargin < 1
   n = size(get(gcf,'colormap'),1);
end


m_table=[ 59, 76, 192;...
    68, 90, 204;...
    77, 104, 215;...
    87, 117, 225;...
    98, 130, 234;...
    108, 142, 241;...
    119, 154, 247;...
    130, 165, 251;...
    141, 176, 254;...
    152, 185, 255;...
    163, 194, 255;...
    174, 201, 253;...
    184, 208, 249;...
    194, 213, 238;...
    204, 219, 230;...
    221, 221, 221;...
    229, 216, 209;...
    236, 211, 197;...
    241, 204, 185;...
    245, 196, 173;...
    247, 187, 160;...
    247, 177, 148;...
    247, 166, 135;...
    244, 154, 123;...
    241, 141, 111;...
    236, 127, 99;...
    229, 112, 88;...
    222, 96, 77;...
    213, 80, 66;...
    203, 62, 56;...
    192, 40, 47;...
    180, 4, 38;];

m = zeros(n,3);
for i=1:n
    for j=1:3
        m(i,j)=interp1(linspace(1,n,32),m_table(:,j),i);
    end
end
m=m/256;



