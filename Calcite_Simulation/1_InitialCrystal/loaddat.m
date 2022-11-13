function [atoms, velocities, bonds, angles, impropers, xlo, xhi, ylo, yhi, zlo, zhi, num_atoms, num_velocities, num_bonds, num_angles, num_impropers] = loaddat(file)
all = fileread(file);
section = strsplit(all,'\n\n');

sbox = split(splitlines(section{3}));
atoms = str2double(split(splitlines(section{7})));
%velocities = str2double(split(splitlines(section{9})));
velocities = [];
bonds = str2double(split(splitlines(section{9})));
angles = (splitlines(section{11}));
angles = str2double(split(angles(~cellfun('isempty',angles))));
impropers = (splitlines(section{13}));
impropers = str2double(split(impropers(~cellfun('isempty',impropers))));
%impropers = [];

xlo = str2double(char(sbox(1,1)));
xhi = str2double(char(sbox(1,2)));
zlo = str2double(char(sbox(2,1)));
zhi = str2double(char(sbox(2,2)));
ylo = str2double(char(sbox(3,1)));
yhi = str2double(char(sbox(3,2)));

num_atoms = size(atoms,1);
num_velocities = size(velocities,1);
num_bonds = size(bonds,1);
num_angles = size(angles,1);
num_impropers = size(impropers,1);

end


