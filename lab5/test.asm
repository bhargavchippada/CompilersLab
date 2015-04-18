void remake()
{
	pushi(ebp); // Setting dynamic link
	move(esp,ebp); // Setting dynamic link

	// blockstmt

	//   New statement
	// assignment
	// arrayref
	loadf(ind(ebp, ebx), eax);
	move(eax, ecx); // ecx = eax
	// leftpart
	storef(ecx, ind(ebp, ebx));

	//   New statement
	// assignment
	//     leftpart
	storei(2, ind(ebp, 8));

	//   New statement
	// returnast
	storei(0, ind(ebp,  12 )); // Save the return value in stack
	j(e); // Unconditional jump

e:  loadi(ind(ebp), ebp); // restoring dynamic link
	popi(1); //pop stack
	return; //return
}

void swap()
{
	pushi(ebp); // Setting dynamic link
	move(esp,ebp); // Setting dynamic link

	// blockstmt

	//   New statement
	// assignment
	//     leftpart
	storei(1, ind(ebp, 4));

	//   New statement
	// returnast
	// cast
	move(1, eax);
	intTofloat(eax);   //casting to float 
	storef(eax, ind(ebp, 12)); // Save the return value in stack
	j(e); // Unconditional jump

e:  loadi(ind(ebp), ebp); // restoring dynamic link
	popi(1); //pop stack
	return; //return
}

void main()
{
	// blockstmt

	//   New statement
	// assignment
	//     leftpart
	storei(5, ind(ebp, -8));

	//   New statement
	// assignment
	// arrayref
	loadi(ind(ebp, ebx), eax);
	move(eax, ecx); // ecx = eax
	// leftpart
	storei(ecx, ind(ebp, 4));
	return; //return
}

