##### Foce field coeff. (metal units) #####

# bond coeff

bond_coeff	1    morse         7.0525     3.1749     0.9485  # HR   OR   Morse - Mostafa, 2007
bond_coeff	2    harmonic    19.51385               0.95720  # HW   OW   CHARMM
bond_coeff	3    morse           3.47     1.9000     1.6000  # P    OPC  Morse - Mkhonto, 2002 J Mater Chem

# Angle coeff

angle_coeff	1   2.385026    104.520000  # HW   OW   HW       CHARMM
angle_coeff	2   0.661313        109.47  # OP   P    OP       Harmonic. In Lammps, K = 1/2*k !!!

# pair coeff 
# /!\ ewald/n assume geometric mixing of the Cij term. Therefore, one must have Cij = sqrt(Cii * Cjj).
# For exemple: C(OP-OR)=113.41=sqrt(C(OP-OP)*C(OR-OR))=sqrt(80.02*160.73)
# Mix arithmatic for lj/charmm/coul/long

pair_coeff	*     *    coul/long

pair_coeff	1     2    buck/coul/long      396.3     0.2300       0.00 # HW   OP
pair_coeff	1     3    buck/coul/long      396.3     0.2170       0.00 # HW   OW Raiteri, 2010 J Am Chem Soc
pair_coeff	1     6    buck/coul/long      312.0     0.2500       0.00 # HW   OR

pair_coeff	2     2    buck/coul/long    16372.0     0.2130       3.47 # OP   OP
pair_coeff	2     3    buck/coul/long    12534.5     0.2020      12.09 # OP   OW  Raiteri, 2010 J Am Chem Soc
pair_coeff	2     5    buck/coul/long     1550.0     0.2970       0.00 # OP   CAL
pair_coeff	2     6    buck/coul/long    22764.0     0.1490       4.92 # OP   OR 
pair_coeff	2     7    buck/coul/long      312.0     0.2500       0.00 # OP   HR

pair_coeff	3     3    lj/charmm/coul/long          0.00674    3.16549 # OW   OW  Raiteri, 2010 J Am Chem Soc
pair_coeff	3     5    lj/charmm/coul/long          0.00095       3.35 # OW   CAL Raiteri, 2010 J Am Chem Soc
pair_coeff	3     7    buck/coul/long      396.3     0.2500       0.00 # OW   HR  de Leeuw 2006 Faraday discussions

pair_coeff	4     6    buck/coul/long     518.47     0.3510       0.00 # P    OR  Mostafa, 2007 J Phys Chem Sol

pair_coeff	5     6    buck/coul/long     1250.0     0.3440       0.00 # CAL  OR

pair_coeff	6     6    buck/coul/long    22764.0     0.1490       6.97 # OR   OR
pair_coeff	6     7    buck/coul/long      312.0     0.2500       0.00 # OR   HR
