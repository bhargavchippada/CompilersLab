void fact()
{
	pushi(ebp); // Setting dynamic link
	move(esp,ebp); // Setting dynamic link
	// If Statement:
	loadi(ind(ebp,4), eax);
	cmpi(0,eax);
	je(l2);
	move(0,eax);
	j(e2);
	l2:
	move(1,eax);
	e2:
	cmpi(0, eax);
	je(l1); // Jump if not equal
	storei(1, ind(ebp,  8)); // Save the return value in stack

	j(e); // Unconditional jump

	j(e1);
	l1:
	loadi(ind(ebp,4), eax);
	pushi(eax);

	 // paramater loading :: fact
	pushi(0); //To make space in stack for return val
	loadi(ind(ebp,4), eax);
	addi(-1,eax);
	pushi(eax); // argument to fact
	fact();
	popi(1);
	loadi(ind(esp),ebx); // receives the return value
	popi(1); // Clean up return value

	loadi(ind(esp),eax);
	popi(1);
	muli(ebx,eax);
	storei(eax, ind(ebp,8)); // Save the return value in stack

	j(e); // Unconditional jump

	e1:

e:  
	loadi(ind(ebp), ebp); // restoring dynamic link
	popi(1); //pop stack
	return; //return
}

void f()
{
	pushi(ebp); // Setting dynamic link
	move(esp,ebp); // Setting dynamic link
	addi(-12,esp); // making space for locals
	print_string("Value of a in f is :: ");
	loadi(ind(ebp,4), eax);
	print_int(eax);
	print_char('\n');

	print_string("Value of b in f is :: ");
	loadi(ind(ebp,8), eax);
	print_int(eax);
	print_char('\n');

	print_string("Value of c in f is :: ");
	loadf(ind(ebp,12), eax);
	print_float(eax);
	print_char('\n');

	storei(5, ind(ebp, -8));

	loadi(ind(ebp,4), eax);
	loadi(ind(ebp,8), ebx);
	muli(ebx,eax);
	loadi(ind(ebp,8), ebx);
	muli(ebx,eax);
	storei(eax, ind(ebp, -4));

	print_string("Value of x in f is :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_char('\n');

	loadi(ind(ebp,-4), eax);
	loadi(ind(ebp,-8), ebx);
	cmpi(ebx,eax);
	jl(l3);
	move(0,eax);
	j(e3);
	l3:
	move(1,eax);
	e3:
	storei(eax, ind(ebp, -12));

	print_string("Value of z in f is :: ");
	loadi(ind(ebp,-12), eax);
	print_int(eax);
	print_char('\n');

	loadi(ind(ebp,-4), eax);
	loadi(ind(ebp,-8), ebx);
	cmpi(ebx,eax);
	jg(l4);
	move(0,eax);
	j(e4);
	l4:
	move(1,eax);
	e4:
	storei(eax, ind(ebp,16)); // Save the return value in stack

	j(e); // Unconditional jump


e:  
	addi(12,esp); // removing space for locals
	loadi(ind(ebp), ebp); // restoring dynamic link
	popi(1); //pop stack
	return; //return
}

void main()
{
	addi(-304,esp); // making space for locals
	move(1.500000,eax);
	floatToint(eax);
	move(1,ebx);
	muli(-20,ebx);
	pushi(ebx);
	move(1,ebx);
	muli(-4,ebx);
	pushi(ebx);
	move(-20,ebx);
	loadi(ind(esp),ecx);
	addi(ecx,ebx);
	popi(1);
	loadi(ind(esp),ecx);
	addi(ecx,ebx);
	popi(1);
	storei(eax, ind(ebp, ebx));

	move(1.600000,eax);
	floatToint(eax);
	move(3,ebx);
	muli(-20,ebx);
	pushi(ebx);
	move(3,ebx);
	muli(-4,ebx);
	pushi(ebx);
	move(-20,ebx);
	loadi(ind(esp),ecx);
	addi(ecx,ebx);
	popi(1);
	loadi(ind(esp),ecx);
	addi(ecx,ebx);
	popi(1);
	storei(eax, ind(ebp, ebx));

	storei(4, ind(ebp, -4));

	print_string("heree");
	print_char('\n');


	 // paramater loading :: fact
	pushi(0); //To make space in stack for return val
	pushi(4); // argument to fact
	fact();
	popi(1);
	loadi(ind(esp),eax); // receives the return value
	popi(1); // Clean up return value

	move(12,ebx);
	muli(-20,ebx);
	pushi(ebx);
	pushi(eax);

	 // paramater loading :: fact
	pushi(0); //To make space in stack for return val
	pushi(2); // argument to fact
	fact();
	popi(1);
	loadi(ind(esp),ebx); // receives the return value
	popi(1); // Clean up return value

	loadi(ind(esp),eax);
	popi(1);
	muli(-4,ebx);
	pushi(ebx);
	move(-20,ebx);
	loadi(ind(esp),ecx);
	addi(ecx,ebx);
	popi(1);
	loadi(ind(esp),ecx);
	addi(ecx,ebx);
	popi(1);
	storei(eax, ind(ebp, ebx));

	print_string(" shoukd be 2:: ");
	move(12,eax);
	muli(-20,eax);
	pushi(eax);
	move(2,eax);
	muli(-4,eax);
	pushi(eax);
	move(-20,eax);
	loadi(ind(esp),ebx);
	addi(ebx,eax);
	popi(1);
	loadi(ind(esp),ebx);
	addi(ebx,eax);
	popi(1);
	loadi(ind(ebp,eax),eax);
	print_int(eax);
	print_char('\n');

	print_string("fact(8) :: ");

	 // paramater loading :: fact
	pushi(0); //To make space in stack for return val

	 // paramater loading :: fact
	pushi(0); //To make space in stack for return val
	pushi(3); // argument to fact
	fact();
	popi(1);
	loadi(ind(esp),eax); // receives the return value
	popi(1); // Clean up return value

	pushi(eax);

	 // paramater loading :: fact
	pushi(0); //To make space in stack for return val
	pushi(2); // argument to fact
	fact();
	popi(1);
	loadi(ind(esp),ebx); // receives the return value
	popi(1); // Clean up return value

	loadi(ind(esp),eax);
	popi(1);
	addi(ebx,eax);
	pushi(eax); // argument to fact
	fact();
	popi(1);
	loadi(ind(esp),eax); // receives the return value
	popi(1); // Clean up return value

	print_int(eax);
	print_char('\n');

	// If Statement:
	move(3,ebx);
	muli(-20,ebx);
	pushi(ebx);
	move(3,ebx);
	muli(-4,ebx);
	pushi(ebx);
	move(-20,ebx);
	loadi(ind(esp),eax);
	addi(eax,ebx);
	popi(1);
	loadi(ind(esp),eax);
	addi(eax,ebx);
	popi(1);
	loadi(ind(ebp,ebx),ebx);
	move(1,eax);
	cmpi(0,eax);
	jne(l6);
	move(1,eax);
	j(e6);
	move(0,eax);
	j(e6);
l6:
	move(1,eax);
e6:
	cmpi(0,eax);
	jne(l7);
	cmpi(0,ebx);
	jne(l7);
	move(0,eax);
	j(e7);
l7:
	move(1,eax);
e7:
	cmpi(0,eax);
	je(l8);
	move(0,eax);
	j(e8);
	move(1,eax);
	j(e8);
l8:
	move(0,eax);
e8:
	cmpi(0,eax);
	je(l9);
	move(1,eax);
	j(e9);
	move(1,eax);
	j(e9);
l9:
	move(0,eax);
e9:
	cmpi(0, eax);
	je(l5); // Jump if not equal
	print_string("fljgnfljg");
	print_char('\n');
	j(e5);
	l5:
	     //Empty Statement
	e5:

	// For Statement:
	storei(0, ind(ebp, -4));

l10:
	loadi(ind(ebp,-4), eax);
	cmpi(20,eax);
	jg(l11);
	move(0,eax);
	j(e11);
	l11:
	move(1,eax);
	e11:
	cmpi(0, eax);
	je(e10); // Jump if not equal
	// If Statement:
	loadi(ind(ebp,-4), eax);
	cmpi(10,eax);
	jg(l13);
	move(0,eax);
	j(e13);
	l13:
	move(1,eax);
	e13:
	cmpi(0, eax);
	je(l12); // Jump if not equal
	loadi(ind(ebp,-4), eax);
	loadi(ind(ebp,-4), ebx);
	muli(-4,ebx);
	pushi(ebx);
	move(-220,ebx);
	loadi(ind(esp),ecx);
	addi(ecx,ebx);
	popi(1);
	storei(eax, ind(ebp, ebx));
	j(e12);
	l12:
	move(20,eax);
	loadi(ind(ebp,-4), ebx);
	muli(-1,ebx);
	addi(ebx,eax);
	loadi(ind(ebp,-4), ebx);
	muli(-4,ebx);
	pushi(ebx);
	move(-220,ebx);
	loadi(ind(esp),ecx);
	addi(ecx,ebx);
	popi(1);
	storei(eax, ind(ebp, ebx));
	e12:

	print_string("array[x] :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_string(" : ");
	loadi(ind(ebp,-4), eax);
	muli(-4,eax);
	pushi(eax);
	move(-220,eax);
	loadi(ind(esp),ebx);
	addi(ebx,eax);
	popi(1);
	loadi(ind(ebp,eax),eax);
	print_int(eax);
	print_char('\n');

	loadi(ind(ebp,-4), eax);
	addi(1,eax);
	storei(eax,ind(ebp,-4));
	j(l10); // Jump if not equal
	e10:

	storei(0, ind(ebp, -304));

	// For Statement:
	storei(0, ind(ebp, -4));

l14:
	loadi(ind(ebp,-4), eax);
	cmpi(20,eax);
	jg(l15);
	move(0,eax);
	j(e15);
	l15:
	move(1,eax);
	e15:
	cmpi(0, eax);
	je(e14); // Jump if not equal
	// For Statement:
	storei(0, ind(ebp, -8));

l16:
	loadi(ind(ebp,-8), eax);
	loadi(ind(ebp,-4), ebx);
	cmpi(ebx,eax);
	jg(l17);
	move(0,eax);
	j(e17);
	l17:
	move(1,eax);
	e17:
	cmpi(0, eax);
	je(e16); // Jump if not equal
	// If Statement:
	loadi(ind(ebp,-8), eax);
	muli(-4,eax);
	pushi(eax);
	move(-220,eax);
	loadi(ind(esp),ebx);
	addi(ebx,eax);
	popi(1);
	loadi(ind(ebp,eax),eax);
	loadi(ind(ebp,-4), ebx);
	muli(-4,ebx);
	pushi(ebx);
	move(-220,ebx);
	loadi(ind(esp),ecx);
	addi(ecx,ebx);
	popi(1);
	loadi(ind(ebp,ebx),ebx);
	cmpi(ebx,eax);
	jl(l19);
	move(0,eax);
	j(e19);
	l19:
	move(1,eax);
	e19:
	cmpi(0, eax);
	je(l18); // Jump if not equal
	loadi(ind(ebp,-304), eax);
	addi(1,eax);
	storei(eax, ind(ebp, -304));

	j(e18);
	l18:
	     //Empty Statement
	e18:

	loadi(ind(ebp,-8), eax);
	addi(1,eax);
	storei(eax,ind(ebp,-8));
	j(l16); // Jump if not equal
	e16:

	loadi(ind(ebp,-4), eax);
	addi(1,eax);
	storei(eax,ind(ebp,-4));
	j(l14); // Jump if not equal
	e14:

	print_string("invcounts :: ");
	loadi(ind(ebp,-304), eax);
	print_int(eax);
	print_char('\n');

	storei(1, ind(ebp, -4));

	storei(2, ind(ebp, -8));

	storei(5, ind(ebp, -12));

	move(8,eax);
	intTofloat(eax);
	storef(eax, ind(ebp, -300));

	loadi(ind(ebp,-8), eax);
	pushi(eax);

	 // paramater loading :: f
	pushi(0); //To make space in stack for return val
	move(1,eax);
	intTofloat(eax);
	pushf(eax); // argument to fact
	pushi(1); // argument to fact
	pushi(1); // argument to fact
	f();
	popi(2);
	popf(1);
	loadi(ind(esp),ebx); // receives the return value
	popi(1); // Clean up return value

	loadi(ind(esp),eax);
	popi(1);
	muli(ebx,eax);
	loadi(ind(ebp,-12), ebx);
	muli(ebx,eax);
	storei(eax, ind(ebp, -4));

	print_string("Value of x is :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_char('\n');

	loadi(ind(ebp,-4), eax);
	addi(1,eax);
	storei(eax,ind(ebp,-4));
	storei(eax, ind(ebp, -4));

	print_string("Value of x++ is :: ");
	loadi(ind(ebp,-4), eax);
	addi(1,eax);
	storei(eax,ind(ebp,-4));
	loadi(ind(ebp,-4), ebx);
	addi(1,ebx);
	storei(ebx,ind(ebp,-4));
	addi(ebx,eax);
	print_int(eax);
	print_char('\n');

	print_string("Value of p33 is :: ");
	move(3,ebx);
	muli(-20,ebx);
	pushi(ebx);
	move(3,ebx);
	muli(-4,ebx);
	pushi(ebx);
	move(-20,ebx);
	loadi(ind(esp),eax);
	addi(eax,ebx);
	popi(1);
	loadi(ind(esp),eax);
	addi(eax,ebx);
	popi(1);
	loadi(ind(ebp,ebx), eax);
	addi(1,eax);
	storei(eax,ind(ebp,ebx));
	move(3,ecx);
	muli(-20,ecx);
	pushi(ecx);
	move(3,ecx);
	muli(-4,ecx);
	pushi(ecx);
	move(-20,ecx);
	loadi(ind(esp),ebx);
	addi(ebx,ecx);
	popi(1);
	loadi(ind(esp),ebx);
	addi(ebx,ecx);
	popi(1);
	loadi(ind(ebp,ecx), ebx);
	addi(1,ebx);
	storei(ebx,ind(ebp,ecx));
	addi(ebx,eax);
	print_int(eax);
	print_char('\n');

	// If Statement:
	loadi(ind(ebp,-4), eax);
	cmpi(0,eax);
	jne(l21);
	move(0,eax);
	j(e21);
	move(0,eax);
	j(e21);
l21:
	move(1,eax);
e21:
	cmpi(0, eax);
	je(l20); // Jump if not equal
	storei(3, ind(ebp, -12));
	j(e20);
	l20:
	storei(4, ind(ebp, -12));
	e20:

	// While Statement:

l22:
	loadi(ind(ebp,-12), eax);
	cmpi(0,eax);
	jl(l23);
	move(0,eax);
	j(e23);
	l23:
	move(1,eax);
	e23:
	cmpi(0, eax);
	je(e22); // Jump if not equal
	loadi(ind(ebp,-12), eax);
	addi(-1,eax);
	storei(eax, ind(ebp, -12));

	print_string("Value of z in loop is :: ");
	loadi(ind(ebp,-12), eax);
	print_int(eax);
	print_char('\n');

	j(l22); // Jump if not equal
	e22:

	storei(0, ind(ebp, -12));

	// For Statement:

l24:
	loadi(ind(ebp,-12), eax);
	cmpi(5,eax);
	jg(l25);
	move(0,eax);
	j(e25);
	l25:
	move(1,eax);
	e25:
	cmpi(0, eax);
	je(e24); // Jump if not equal
	loadi(ind(ebp,-12), eax);
	addi(1,eax);
	storei(eax, ind(ebp, -12));

	storei(0, ind(ebp, -8));

	// While Statement:

l26:
	loadi(ind(ebp,-8), eax);
	loadi(ind(ebp,-12), ebx);
	cmpi(ebx,eax);
	jg(l27);
	move(0,eax);
	j(e27);
	l27:
	move(1,eax);
	e27:
	cmpi(0, eax);
	je(e26); // Jump if not equal
	loadi(ind(ebp,-8), eax);
	addi(1,eax);
	storei(eax, ind(ebp, -8));

	print_string("Value of y in while for loop is :: ");
	loadi(ind(ebp,-8), eax);
	print_int(eax);
	print_char('\n');

	j(l26); // Jump if not equal
	e26:

	print_string("Value of z in loop is :: ");
	loadi(ind(ebp,-12), eax);
	print_int(eax);
	print_char('\n');

	j(l24); // Jump if not equal
	e24:

	print_string("Value of x is :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_char('\n');

	print_string("Value of y is :: ");
	loadi(ind(ebp,-8), eax);
	print_int(eax);
	print_char('\n');

	print_string("Value of p2,3 is :: ");
	move(2,eax);
	muli(-20,eax);
	pushi(eax);
	move(3,eax);
	muli(-4,eax);
	pushi(eax);
	move(-20,eax);
	loadi(ind(esp),ebx);
	addi(ebx,eax);
	popi(1);
	loadi(ind(esp),ebx);
	addi(ebx,eax);
	popi(1);
	loadi(ind(ebp,eax),eax);
	print_int(eax);
	print_char('\n');

	print_string("Value of p0,3 is :: ");
	move(0,eax);
	muli(-20,eax);
	pushi(eax);
	move(3,eax);
	muli(-4,eax);
	pushi(eax);
	move(-20,eax);
	loadi(ind(esp),ebx);
	addi(ebx,eax);
	popi(1);
	loadi(ind(esp),ebx);
	addi(ebx,eax);
	popi(1);
	loadi(ind(ebp,eax),eax);
	print_int(eax);
	print_char('\n');

	print_string("Value of p4,3 is :: ");
	move(4,eax);
	muli(-20,eax);
	pushi(eax);
	move(3,eax);
	muli(-4,eax);
	pushi(eax);
	move(-20,eax);
	loadi(ind(esp),ebx);
	addi(ebx,eax);
	popi(1);
	loadi(ind(esp),ebx);
	addi(ebx,eax);
	popi(1);
	loadi(ind(ebp,eax),eax);
	print_int(eax);
	print_char('\n');

	print_string("Value of z is :: ");
	loadi(ind(ebp,-12), eax);
	print_int(eax);
	print_char('\n');

	addi(304,esp); // removing space for locals
	return; //return
}

