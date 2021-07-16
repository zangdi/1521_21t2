change:
    li		$t0, 0              # int row = 0;
                                # store row in $t0

loop1:
    bge		$t0, $a0, end1      # if (row >= nrows) goto end1;

    li		$t1, 0              # int col = 0;
                                # store col in $t1

loop2:
    bge		$t1, $a1, end2      # if (col >= ncols) goto end2;

    # M[row][col] = M[row * ncols + col]
    mul     $t2, $t0, $a1       # store (row * ncols) in $t2
    add		$t2, $t2, $t1       # store (row * ncols + col) in $t2
    mul     $t2, $t2, 4         # calculate size of offset to access M[row][col]
    add		$t2, $t2, $a2       # calculate &M[row][col]

    lw		$t3, ($t2)          # store M[row][col] in $t3
    mul     $t3, $t3, $a3       # store (M[row][col] * factor) in $t3
    sw		$t3, ($t2)          # save (M[row][col] * factor) into &M[row][col]
    
    addi	$t1, $t1, 1         # col++;
    b		loop2               # goto loop2;

end2:
    addi	$t0, $t0, 1         # row++
    b       loop1               # goto loop1;

end1:
    jr		$ra
    