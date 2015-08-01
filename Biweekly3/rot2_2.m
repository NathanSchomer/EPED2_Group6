function rotM = rot2_2( ang_deg )
%ROT(D) Rotates a matrix array by a set of coordinates given by (d) in
%degrees
%   Only accepts inputs in degrees, no radians

rotM = [cosd(ang_deg) -sind(ang_deg); sind(ang_deg) cosd(ang_deg)];

end

