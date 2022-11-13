%How many unit cell repetitions?
x = 2; %Change as needed
y = 23; %Change as needed
z = 9; %Change as needed

[crystal, crystal_bonds, crystal_angles, crystal_impropers, xlo, xhi, ylo, yhi, zlo, zhi, num_atoms, num_bonds, num_angles, num_impropers] = builder(x,y,z);
Xc = (xhi+xlo)/2;
Yc = (yhi+ylo)/2;
Zc = (zhi+zlo)/2;

%For "Full" format
%crystal = [crystal(:,1) crystal(:,7) crystal(:,2) crystal(:,6) crystal(:,3) crystal(:,4) crystal(:,5)];

%For Flipped Z and Y...
crystal = [crystal(:,1) crystal(:,7) crystal(:,2) crystal(:,6) crystal(:,3) crystal(:,5) crystal(:,4)];

%Print LAMMPS data file
fileID = fopen(sprintf('dat.%d_%d_%d',x,y,z),'w');
fprintf(fileID, '#Calcite unit cell\n\n%d atoms\n%d bonds\n%d angles\n%d impropers\n3 atom types\n1 bond types\n1 angle types\n1 improper types\n\n', num_atoms,num_bonds,num_angles,num_impropers);
%Flipped z and y
fprintf(fileID, '%f %f xlo xhi\n%f %f zlo zhi\n%f %f ylo yhi\n\n',xlo,xhi,ylo,yhi,zlo,zhi)
fprintf(fileID, 'Masses\n\n1 40.078\n2 12.017\n3 15.999\n\nAtoms\n\n');
fprintf(fileID, '%d %d %d %f %f %f %f\n', crystal.');
fprintf(fileID, '\nBonds\n\n');
fprintf(fileID, '%d %d %d %d\n', crystal_bonds.');
fprintf(fileID, '\nAngles\n\n');
fprintf(fileID, '%d %d %d %d %d\n', crystal_angles.');
fprintf(fileID, '\nImpropers\n\n');
fprintf(fileID, '%d %d %d %d %d %d\n', crystal_impropers.');
fclose(fileID);


