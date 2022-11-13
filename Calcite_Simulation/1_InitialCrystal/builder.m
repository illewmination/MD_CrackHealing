function [crystal, crystal_bonds, crystal_angles, crystal_impropers, xlo, xhi, ylo, yhi, zlo, zhi, num_atoms, num_bonds, num_angles, num_impropers] = builder(x,y,z)
%Orthogonal unit cell dimensions in x, y, and z for Calcite
lx = 4.9896; 
ly = 2*4.321120355;
lz = 17.061;

%Import data from single orthogonal unitcell
Atoms = readmatrix('oc_atoms.xlsx');
Bonds = readmatrix('oc_bonds.xlsx');
Angles = readmatrix('oc_angles.xlsx');
Impropers = readmatrix('oc_impropers.xlsx');

num_atoms = size(Atoms,1);
num_bonds = size(Bonds,1);
num_angles = size(Angles,1);
num_impropers = size(Impropers,1);

crystal = Atoms;
crystal_bonds = Bonds;
crystal_angles = Angles;
crystal_impropers = Impropers;

%Replicating unit cell in x direction
for i = 1:x-1
    AtomsNew = [Atoms(:,1)+num_atoms*i Atoms(:,2) Atoms(:,3)+lx*i Atoms(:,4) Atoms(:,5) Atoms(:,6) Atoms(:,7)+24*i];
    crystal = cat(1,crystal,AtomsNew);
    BondsNew = [Bonds(:,1)+num_bonds*i Bonds(:,2) Bonds(:,3)+num_atoms*i Bonds(:,4)+num_atoms*i];
    crystal_bonds = cat(1,crystal_bonds,BondsNew);
    AnglesNew = [Angles(:,1)+num_angles*i Angles(:,2) Angles(:,3)+num_atoms*i Angles(:,4)+num_atoms*i Angles(:,5)+num_atoms*i];
    crystal_angles = cat(1,crystal_angles,AnglesNew);
    ImpropersNew = [Impropers(:,1)+num_impropers*i Impropers(:,2) Impropers(:,3)+num_atoms*i Impropers(:,4)+num_atoms*i Impropers(:,5)+num_atoms*i Impropers(:,6)+num_atoms*i];
    crystal_impropers = cat(1,crystal_impropers,ImpropersNew);
end
AtomsX = crystal;
BondsX = crystal_bonds;
AnglesX = crystal_angles;
ImpropersX = crystal_impropers;
num_atoms = size(AtomsX,1);
num_bonds = size(BondsX,1);
num_angles = size(AnglesX,1);
num_impropers = size(ImpropersX,1);
%scatter(AtomsX(:,3),AtomsX(:,4));

%Replicating unit cell in y direction
for j = 1:y-1
    AtomsNew = [AtomsX(:,1)+num_atoms*j AtomsX(:,2) AtomsX(:,3) AtomsX(:,4)+ly*j AtomsX(:,5) AtomsX(:,6) AtomsX(:,7)+24*(i+1)*j];
    crystal = cat(1,crystal,AtomsNew);
    BondsNew = [BondsX(:,1)+num_bonds*j BondsX(:,2) BondsX(:,3)+num_atoms*j BondsX(:,4)+num_atoms*j];
    crystal_bonds = cat(1,crystal_bonds,BondsNew);
    AnglesNew = [AnglesX(:,1)+num_angles*j AnglesX(:,2) AnglesX(:,3)+num_atoms*j AnglesX(:,4)+num_atoms*j AnglesX(:,5)+num_atoms*j];
    crystal_angles = cat(1,crystal_angles,AnglesNew);
    ImpropersNew = [ImpropersX(:,1)+num_impropers*j ImpropersX(:,2) ImpropersX(:,3)+num_atoms*j ImpropersX(:,4)+num_atoms*j ImpropersX(:,5)+num_atoms*j ImpropersX(:,6)+num_atoms*j];
    crystal_impropers = cat(1,crystal_impropers,ImpropersNew);
end
AtomsY = crystal;
BondsY = crystal_bonds;
AnglesY = crystal_angles;
ImpropersY = crystal_impropers;
num_atoms = size(AtomsY,1);
num_bonds = size(BondsY,1);
num_angles = size(AnglesY,1);
num_impropers = size(ImpropersY,1);
%scatter(AtomsY(:,3),AtomsY(:,4));

%Replicating unit cell in z direction
for k = 1:z-1
    AtomsNew = [AtomsY(:,1)+num_atoms*k AtomsY(:,2) AtomsY(:,3) AtomsY(:,4) AtomsY(:,5)+lz*k AtomsY(:,6) AtomsY(:,7)+24*(i+1)*(j+1)*k];
    crystal = cat(1,crystal,AtomsNew);
    BondsNew = [BondsY(:,1)+num_bonds*k BondsY(:,2) BondsY(:,3)+num_atoms*k BondsY(:,4)+num_atoms*k];
    crystal_bonds = cat(1,crystal_bonds,BondsNew);
    AnglesNew = [AnglesY(:,1)+num_angles*k AnglesY(:,2) AnglesY(:,3)+num_atoms*k AnglesY(:,4)+num_atoms*k AnglesY(:,5)+num_atoms*k];
    crystal_angles = cat(1,crystal_angles,AnglesNew);
    ImpropersNew = [ImpropersY(:,1)+num_impropers*k ImpropersY(:,2) ImpropersY(:,3)+num_atoms*k ImpropersY(:,4)+num_atoms*k ImpropersY(:,5)+num_atoms*k ImpropersY(:,6)+num_atoms*k];
    crystal_impropers = cat(1,crystal_impropers,ImpropersNew);
end
num_atoms = size(crystal,1);
num_bonds = size(crystal_bonds,1);
num_angles = size(crystal_angles,1);
num_impropers = size(crystal_impropers,1);
scatter3(crystal(:,3),crystal(:,4),crystal(:,5));

xlo = min(crystal(:,3));
xhi = xlo+lx*x;
ylo = min(crystal(:,4));
yhi = ylo+ly*y;
zlo = min(crystal(:,5));
zhi = zlo+lz*z;
end
