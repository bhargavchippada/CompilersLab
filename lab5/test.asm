void remake()
{
	pushi(ebp); // Setting dynamic link
	move(esp,ebp); // Setting dynamic link


	//   New statement
	loadf(ind(ebp, -4), eax); // load to eax
	move(eax, ecx); // ecx = eax
	// leftpart
	loadf(ind(ebp, 12), eax); // load to eax
	addi(ebp, eax); // eax = eax + ebp the address of l_exp
	storef(ecx, ind(eax));

	//   New statement
	//     leftpart
	loadi(ind(ebp, 8), eax); // load to eax
	addi(ebp, eax); // eax = eax + ebp the address of l_exp
	storei(2, ind(eax));

	//   New statement
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


	//   New statement
	//     leftpart
	loadi(ind(ebp, 4), eax); // load to eax
	addi(ebp, eax); // eax = eax + ebp the address of l_exp
	storei(1, ind(eax));

	//   New statement
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

	//   New statement
	move(5.000000, eax);
	floatToint(eax);   //casting to int
	print_int(eax);
	print_char('\n');

	move(eax, ecx); // ecx = eax

	print_int(ecx);
	print_char('\n');
	
	// leftpart
	loadi(ind(ebp, -4), eax); // load to eax

	cout << "eax\n";
	print_int(eax);
	print_char('\n');

	addi(ebp, eax); // eax = eax + ebp the address of l_exp
	
	cout << "eax\n";
	print_int(eax);
	print_char('\n');

	storei(ecx, ind(eax));

	cout << "fsgfgf\n";

	//   New statement
	loadi(ind(ebp, -4), eax); // load to eax
	intTofloat(eax);   //casting to float 
	move(eax, ecx); // ecx = eax
	// leftpart
	loadf(ind(ebp, -8), eax); // load to eax
	addi(ebp, eax); // eax = eax + ebp the address of l_exp
	storef(ecx, ind(eax));
	return; //return
}

