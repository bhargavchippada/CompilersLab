void remake()
{
	pushi(ebp); // Setting dynamic link
	move(esp,ebp); // Setting dynamic link

	// blockstmt

	//   New statement
	// assignment
	// arrayref
	loadf(ind(ebp, -8), eax);
	move(eax, ecx); // ecx = eax
	// leftpart
	storef(ecx, ind(ebp, 8));

	//   New statement
	// assignment
	//     leftpart
	storei(2, ind(ebp, 4));

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
	storei(1, ind(ebp, -4));

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
	loadi(ind(ebp, -8), eax);
	move(eax, ecx); // ecx = eax
	// leftpart
	storei(ecx, ind(ebp, -4));

	//   New statement
	// assignment
	//     leftpart
	// INTCONST
	move(2, eax);
	muli(-5, eax);
	move(eax, ebx);
	// INTCONST
	move(3, eax);
	muli(-1, eax);
	addi(eax, ebx);
	addi(-12,ebx);
	storei(5, ind(ebp, ebx));

	//   New statement
	// assignment
	// funcallAST

	// parameter loading :: remake
	pushi(0); //To make space in stack for return val
	pushi(3); // argument to fact
	// cast
	move(4, eax);
	intTofloat(eax);   //casting to float 
	pushf(eax); // argument to fact
	remake();
	popi(1);
	popf(1);
	loadi(ind(esp), eax); // receives the return value
	popi(1); // Clean up return value

	move(eax, ecx); // ecx = eax
	// leftpart
	// INTCONST
	move(3, eax);
	muli(-5, eax);
	move(eax, ebx);
	// INTCONST
	move(3, eax);
	muli(-1, eax);
	addi(eax, ebx);
	addi(-12,ebx);
	storei(ecx, ind(ebp, ebx));
	return; //return
}

