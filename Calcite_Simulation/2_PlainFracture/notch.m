%load in data from equilibrated structure
file = 'dat.2_23_9';
[crystal, crystal_velocities, crystal_bonds, crystal_angles, crystal_impropers, xlo, xhi, ylo, yhi, zlo, zhi, num_atoms, num_velocities, num_bonds, num_angles, num_impropers] = loaddat(file);
    
%find notchline, dir = 'x';
h = 50; %choose at launch
w = 20; %choose at launch
m = (zhi+zlo)/2; 
g = min(crystal(:,6));
dist = abs(crystal(:,7)-m);
crystal = [crystal dist]; 

%Identify notch region and identify which ion in excess
flag_Ca = (crystal(:,6) < (2*h/w*(crystal(:,7)-m+w/2)+g) & crystal(:,6) < (-2*h/w*(crystal(:,7)-m-w/2)+g) & crystal(:,3) == 1); 
flag_C = (crystal(:,6) < (2*h/w*(crystal(:,7)-m+w/2)+g) & crystal(:,6) < (-2*h/w*(crystal(:,7)-m-w/2)+g) & crystal(:,3) == 2);
flagged_Ca = sortrows(sortrows(sortrows(crystal(flag_Ca,:),5,'descend'),6,'descend'),8,'descend'); 
flagged_C = sortrows(sortrows(sortrows(crystal(flag_C,:),5,'descend'),6,'descend'),8,'descend');

n_Ca = size(flagged_Ca,1);
n_C = size(flagged_C,1);
diff = n_Ca-n_C;

if diff > 0
flagged_Ca = flagged_Ca([diff+1:end],:);
else
    if diff < 0
    flagged_C = flagged_C([abs(diff)+1:end],:);
    else
    end
end

%Collect atom IDs to be deleted
flag_CO3 = ismember(crystal(:,2),flagged_C(:,2));
flagged_CO3 = crystal(flag_CO3,:);
flagged_atoms = [flagged_Ca ; flagged_CO3];
n_invalid_IDs = flagged_atoms(:,1); 

%Delete atom, bond, angle, improper with invalid atom numbers
invalid_atoms = ismember(crystal(:,1),n_invalid_IDs);
invalid_velocities = ismember(crystal(:,1),n_invalid_IDs);
invalid_bonds = ismember(crystal_bonds(:,3),n_invalid_IDs)|ismember(crystal_bonds(:,4),n_invalid_IDs);
invalid_angles = ismember(crystal_angles(:,3),n_invalid_IDs)|ismember(crystal_angles(:,4),n_invalid_IDs)|ismember(crystal_angles(:,5),n_invalid_IDs);
invalid_impropers = ismember(crystal_impropers(:,3),n_invalid_IDs)|ismember(crystal_impropers(:,4),n_invalid_IDs)|ismember(crystal_impropers(:,5),n_invalid_IDs)|ismember(crystal_impropers(:,6),n_invalid_IDs);

deleted_atoms = crystal(invalid_atoms,:);
deleted_velocities = [];% crystal_velocities(invalid_velocities,:);
deleted_bonds = crystal_bonds(invalid_bonds,:);
deleted_angles = crystal_angles(invalid_angles,:);
deleted_impropers = crystal_impropers(invalid_impropers,:);

crystal(invalid_atoms,:)=[];
crystal(:,8)=[];
%crystal_velocities(invalid_velocities,:)=[];
crystal_bonds(invalid_bonds,:)=[];
crystal_angles(invalid_angles,:)=[];
crystal_impropers(invalid_impropers,:)=[];

total_atoms = num_atoms-size(deleted_atoms,1);
%total_velocities = num_velocities-size(deleted_velocities,1);
total_bonds = num_bonds-size(deleted_bonds,1);
total_angles = num_angles-size(deleted_angles,1);
total_impropers = num_impropers-size(deleted_impropers,1);

offset = 25;

%xhi = max(crystal(:,5))+offset;
yhi = max(crystal(:,6))+offset;
%zhi = max(crystal(:,7))%+offset;
%xlo = min(crystal(:,5))-offset;
ylo = min(crystal(:,6))-offset;
%zlo = min(crystal(:,7))-offset;
scatter3(crystal(:,5),crystal(:,6),crystal(:,7));
%scatter3(deleted_atoms(:,3),deleted_atoms(:,4),deleted_atoms(:,5));

%Print LAMMPS data file
fileID = fopen(sprintf(strcat(file,'_nx%d%d'),h,w),'w');
fprintf(fileID, '#Calcite unit cell\n\n%d atoms\n%d bonds\n%d angles\n%d impropers\n\n3 atom types\n1 bond types\n1 angle types\n1 improper types\n\n',total_atoms,total_bonds,total_angles,total_impropers);
fprintf(fileID, '%f %f xlo xhi\n%f %f ylo yhi\n%f %f zlo zhi\n\n',xlo,xhi,ylo,yhi,zlo,zhi)
fprintf(fileID, 'Masses\n\n1 40.078\n2 12.017\n3 15.999\n');
fprintf(fileID, '\nAtoms\n\n');
fprintf(fileID, '%d %d %d %f %f %f %f\n', crystal.');
%fprintf(fileID, '\nVelocities\n\n');
%fprintf(fileID, '%d %d %d %d\n', crystal_velocities.');
fprintf(fileID, '\nBonds\n\n');
fprintf(fileID, '%d %d %d %d\n', crystal_bonds.');
fprintf(fileID, '\nAngles\n\n');
fprintf(fileID, '%d %d %d %d %d\n', crystal_angles.');
fprintf(fileID, '\nImpropers\n\n');
fprintf(fileID, '%d %d %d %d %d %d\n', crystal_impropers.');
fclose(fileID);