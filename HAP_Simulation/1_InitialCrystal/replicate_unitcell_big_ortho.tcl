# Read the unit cell of a pdb and replicate n1 by n2 by n3 times.
# Use with: vmd -dispdev text -e replicate_unitcell_big_ortho.tcl
# jcomer2@uiuc.edu
# 20120428: Modification of residue ID #, incrementing residue ID for each new unit cell based on initial residue ID + quit

# Input:
set unitCellPdb unit-ortho_gs.pdb
#set unitCellPdb unit-hex_gs.pdb
# Output:
set outputFileName HAP_1930
set outputFileExt .pdb
# Parameters:
# Choose n1 and n2 even if you wish to use cutHexagon.tcl. 
# n1, n2, n3 number of units cell replicated along a, b, c.
set n1 1
set n2 9
set n3 30
# l1, l2, l3 gap, in unit cell, between each cell duplicated in a, b, c direction.
set l1 1
set l2 1
set l3 1
# Vector director a, b, c. #y2 ortho = 16.218
set basisVector1 [list 9.424 0.0 0.0]
set basisVector2 [list 0.0 16.322 0.0] 
set basisVector3 [list 0.0 0.0 6.879]

# Return a list with atom positions.
proc extractPdbCoords {pdbFile} {
	set r {}
	
	# Get the coordinates from the pdb file.
	set in [open $pdbFile r]
	foreach line [split [read $in] \n] {
		if {[string equal [string range $line 0 3] "ATOM"]} {
			set x [string trim [string range $line 30 37]]
			set y [string trim [string range $line 38 45]]
			set z [string trim [string range $line 46 53]]
			
			lappend r [list $x $y $z]
		}
	}
	close $in
	return $r
}

# Extract all atom records from a pdb file.
proc extractPdbRecords {pdbFile} {
	set in [open $pdbFile r]
	
	set pdbLine {}
	foreach line [split [read $in] \n] {
		if {[string equal [string range $line 0 3] "ATOM"]} {
			lappend pdbLine $line
		}
	}
	close $in	
	
	return $pdbLine
}

# Extract the number of residue from a pdb file.
proc extractPdbResNb {pdbFile} {
	set in [open $pdbFile r]
	
	set pdbLine {}
	foreach line [split [read $in] \n] {
		if {[string equal [string range $line 0 3] "ATOM"]} {
			set resNb [string range $line 21 25]
		}
	}
	close $in	
	
	return $resNb
}

# Shift a list of vectors by a lattice vector.
proc displaceCell {rUnitName i1 i2 i3 a1 a2 a3} {
	upvar $rUnitName rUnit
	# Compute the new lattice vector.
	set rShift [vecadd [vecscale $i1 $a1] [vecscale $i2 $a2]]
	set rShift [vecadd $rShift [vecscale $i3 $a3]]
	
	set rRep {}
	foreach r $rUnit {
		lappend rRep [vecadd $r $rShift]
	}
	return $rRep
}

# Construct a pdb line from a template line, index, resId, and coordinates.
proc makePdbLine {template index resId r} {
	foreach {x y z} $r {break}
	set record "ATOM  "
	set si [string range [format "     %5i " $index] end-5 end]
	set temp0 [string range $template 12 20]
	set temp3 [string range $template 21 25]
	set temp4 [ expr $resId+$temp3]
	set temp2 [string range [format "   %4i" $temp4] end-4 end]
	set temp1 [string range $template  26 29]
	set sx [string range [format "       %8.3f" $x] end-7 end]
	set sy [string range [format "       %8.3f" $y] end-7 end]
	set sz [string range [format "       %8.3f" $z] end-7 end]
	set tempEnd [string range $template 54 end]

	# Construct the pdb line.
	return "${record}${si}${temp0}${temp2}${temp1}${sx}${sy}${sz}${tempEnd}"
}

# Build the crystal.
proc main {} {
	global unitCellPdb outputFileName outputFileExt
	global n1 n2 n3 l1 l2 l3 basisVector1 basisVector2 basisVector3

	set atom 1
	set resId 0
	set resNbTmp 0
	set rUnit [extractPdbCoords $unitCellPdb]
	set pdbLine [extractPdbRecords $unitCellPdb]
	set resNb [extractPdbResNb $unitCellPdb]
	
	set i0 0
	set j0 0
	set k0 0
	set outputFileNb 1
	set newFile 1

	set a1 [vecscale $l1 $basisVector1]
	set a2 [vecscale $l2 $basisVector2]
	set a3 [vecscale $l3 $basisVector3]
	set b1 [veclength $basisVector1]
	set b2 [veclength $basisVector2]
	set b3 [veclength $basisVector3]
	set c1 [expr $n1*$l1*$b1]
	set c2 [expr $n2*$l2*$b2]
	set c3 [expr $n3*$l3*$b3]
	set d1 [string range [format "       %8.3f" $c1] end-7 end]
	set d2 [string range [format "       %8.3f" $c2] end-7 end]
	set d3 [string range [format "       %8.3f" $c3] end-7 end]

	
	puts "\nReplicating unit $unitCellPdb cell $n1 by $n2 by $n3..."
	puts "\nIndices $i0 $j0 $k0"
		
	# Replicate the unit cell.



	for {set k 0} {$k < $n3} {incr k} {
    		for {set j 0} {$j < $n2} {incr j} {
			for {set i 0} {$i < $n1} {incr i} {
				set rRep [displaceCell rUnit $i $j $k $a1 $a2 $a3]
				
				if {$newFile} {
				      
				      set outPdb $outputFileName$outputFileNb$outputFileExt
				      puts "\n$outPdb"
				      set out [open $outPdb w]
				      puts $out "REMARK Unit cell dimensions:"
				      puts $out "REMARK a1 $l1" 
				      puts $out "REMARK a2 $l2" 
				      puts $out "REMARK a3 $l3" 
				      puts $out "REMARK Basis vectors:"
				      puts $out "REMARK basisVector1 $basisVector1" 
				      puts $out "REMARK basisVector2 $basisVector2" 
				      puts $out "REMARK basisVector3 $basisVector3" 
				      puts $out "REMARK replicationCount $n1 $n2 $n3" 
				      puts $out "CRYST1 $d1 $d2 $d3  90.00  90.00 90.00 P1"
				      
				      set newFile 0
				}

				#incr resId
				set resId [expr (($n2*$n1*$k)+($n1*$j)+($i))*$resNb-$resNbTmp]

				# Write each atom.
				foreach r $rRep l $pdbLine {
					puts $out [makePdbLine $l $atom $resId $r]
					incr atom
				}
				# puts "\nIndices $i $j $k"

				if {$resId > 9999 - 2*$resNb} {
					puts "Warning! Residue overflow $i $j $k $resId"
					set resNbTmp [expr $resId+$resNbTmp+$resNb]
					set resId 1
					incr outputFileNb
					puts "Output file number $outputFileNb $resId"
					puts $out "END"
					close $out
					puts "The file $outPdb was written successfully."
					set newFile 1
				}
			}
		}
	}
    quit
}

main
