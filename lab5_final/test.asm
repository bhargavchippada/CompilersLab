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
	// returnast
	storei(1, ind(ebp,  8)); // Save the return value in stack

	j(e); // Unconditional jump

	j(e1);
	l1:
	// returnast
	loadi(ind(ebp,4), eax);
	pushi(eax);

	 // paramater loading :: fact
	pushi(0); //To make space in stack for return val
	loadi(ind(ebp,4), eax);
	addi(-1,eax);
	pushi(eax); // argument to fact
	fact();
	popi(1);
	loadi(ind(esp),eax);
	popi(1);
	loadi(ind(esp),ebx); // receives the return value
	popi(1); // Clean up return value

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


	     //Empty Statement


	print_string("Value of b in f is :: ");
	loadi(ind(ebp,8), eax);
	print_int(eax);
	print_char('\n');


	     //Empty Statement


	print_string("Value of c in f is :: ");
	loadf(ind(ebp,12), eax);
	print_float(eax);
	print_char('\n');


	     //Empty Statement


	storei(5, ind(ebp, -8));


	loadi(ind(ebp,8), eax);
	pushi(eax);
	loadi(ind(ebp,4), eax);
	loadi(ind(ebp,8), ebx);
	muli(ebx,eax);
	loadi(ind(esp),ebx);
	popi(1);
	muli(ebx,eax);
	storei(eax, ind(ebp, -4));


	print_string("Value of x in f is :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_char('\n');


	     //Empty Statement


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


	     //Empty Statement


	// returnast
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
	addi(-184,esp); // making space for locals
	move(1.500000,eax);
	floatToint(eax);
	pushi(eax);
	move(1,eax);
	muli(-20,eax);
	pushi(eax);
	move(1,eax);
	muli(-4,eax);
	pushi(eax);
	move(-20,eax);
	loadi(ind(esp),ebx);
	addi(ebx,eax);
	popi(1);
	loadi(ind(esp),ebx);
	addi(ebx,eax);
	popi(1);
	loadi(ind(esp),ebx);
	popi(1);
	storei(ebx, ind(ebp, eax));


	move(1.600000,eax);
	floatToint(eax);
	pushi(eax);
	move(3,eax);
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
	loadi(ind(esp),ebx);
	popi(1);
	storei(ebx, ind(ebp, eax));


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
	loadi(ind(esp),eax);
	popi(1);
	loadi(ind(esp),ebx); // receives the return value
	popi(1); // Clean up return value

	addi(ebx,eax);
	pushi(eax); // argument to fact
	fact();
	popi(1);
	loadi(ind(esp),eax); // receives the return value
	popi(1); // Clean up return value

	print_int(eax);
	print_char('\n');


	     //Empty Statement


	storei(0, ind(ebp, -4));


	// For Statement:

l5:
	loadi(ind(ebp,-4), eax);
	cmpi(20,eax);
	jg(l6);
	move(0,eax);
	j(e6);
	l6:
	move(1,eax);
	e6:
	cmpi(0, eax);
	je(e5); // Jump if not equal
	// If Statement:
	loadi(ind(ebp,-4), eax);
	cmpi(10,eax);
	jg(l8);
	move(0,eax);
	j(e8);
	l8:
	move(1,eax);
	e8:
	cmpi(0, eax);
	je(l7); // Jump if not equal
	loadi(ind(ebp,-4), eax);
	pushi(eax);
	loadi(ind(ebp,-4), eax);
	muli(-4,eax);
	pushi(eax);
	move(-100,eax);
	loadi(ind(esp),ebx);
	addi(ebx,eax);
	popi(1);
	loadi(ind(esp),ebx);
	popi(1);
	storei(ebx, ind(ebp, eax));
	j(e7);
	l7:
	move(20,eax);
	loadi(ind(ebp,-4), ebx);
	muli(-1,ebx);
	addi(ebx,eax);
	pushi(eax);
	loadi(ind(ebp,-4), eax);
	muli(-4,eax);
	pushi(eax);
	move(-100,eax);
	loadi(ind(esp),ebx);
	addi(ebx,eax);
	popi(1);
	loadi(ind(esp),ebx);
	popi(1);
	storei(ebx, ind(ebp, eax));
	e7:


	print_string("array[x] :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_string(" : ");
	loadi(ind(ebp,-4), eax);
	muli(-4,eax);
	pushi(eax);
	move(-100,eax);
	loadi(ind(esp),ebx);
	addi(ebx,eax);
	popi(1);
	loadi(ind(ebp,eax),eax);
	print_int(eax);
	print_char('\n');


	     //Empty Statement


	loadi(ind(ebp,-4), eax);
	addi(1,eax);
	storei(eax,ind(ebp,-4));
	j(l5); // Jump if not equal
	e5:


	storei(0, ind(ebp, -184));


	// For Statement:
	storei(0, ind(ebp, -4));

l9:
	loadi(ind(ebp,-4), eax);
	cmpi(20,eax);
	jg(l10);
	move(0,eax);
	j(e10);
	l10:
	move(1,eax);
	e10:
	cmpi(0, eax);
	je(e9); // Jump if not equal
	// For Statement:
	storei(0, ind(ebp, -8));

l11:
	loadi(ind(ebp,-8), eax);
	loadi(ind(ebp,-4), ebx);
	cmpi(ebx,eax);
	jg(l12);
	move(0,eax);
	j(e12);
	l12:
	move(1,eax);
	e12:
	cmpi(0, eax);
	je(e11); // Jump if not equal
	// If Statement:
	loadi(ind(ebp,-4), eax);
	muli(-4,eax);
	pushi(eax);
	move(-100,eax);
	loadi(ind(esp),ebx);
	addi(ebx,eax);
	popi(1);
	loadi(ind(ebp,eax),eax);
	pushi(eax);
	loadi(ind(ebp,-8), eax);
	muli(-4,eax);
	pushi(eax);
	move(-100,eax);
	loadi(ind(esp),ebx);
	addi(ebx,eax);
	popi(1);
	loadi(ind(ebp,eax),eax);
	loadi(ind(esp),ebx);
	popi(1);
	cmpi(ebx,eax);
	jl(l14);
	move(0,eax);
	j(e14);
	l14:
	move(1,eax);
	e14:
	cmpi(0, eax);
	je(l13); // Jump if not equal
	loadi(ind(ebp,-184), eax);
	addi(1,eax);
	storei(eax, ind(ebp, -184));


	j(e13);
	l13:
	     //Empty Statement
	e13:


	loadi(ind(ebp,-8), eax);
	addi(1,eax);
	storei(eax,ind(ebp,-8));
	j(l11); // Jump if not equal
	e11:


	loadi(ind(ebp,-4), eax);
	addi(1,eax);
	storei(eax,ind(ebp,-4));
	j(l9); // Jump if not equal
	e9:


	print_string("invcounts :: ");
	loadi(ind(ebp,-184), eax);
	print_int(eax);
	print_char('\n');


	     //Empty Statement


	storei(1, ind(ebp, -4));


	storei(2, ind(ebp, -8));


	storei(5, ind(ebp, -12));


	move(8,eax);
	intTofloat(eax);
	storef(eax, ind(ebp, -180));


	loadi(ind(ebp,-12), eax);
	pushi(eax);
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
	loadi(ind(esp),eax);
	popi(1);
	loadi(ind(esp),ebx); // receives the return value
	popi(1); // Clean up return value

	muli(ebx,eax);
	loadi(ind(esp),ebx);
	popi(1);
	muli(ebx,eax);
	storei(eax, ind(ebp, -4));


	print_string("Value of x is :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_char('\n');


	     //Empty Statement


	loadi(ind(ebp,-4), eax);
	addi(1,eax);
	storei(eax,ind(ebp,-4));
	storei(eax, ind(ebp, -4));


	print_string("Value of x++ is :: ");
	loadi(ind(ebp,-4), eax);
	addi(1,eax);
	storei(eax,ind(ebp,-4));
	pushi(eax);
	loadi(ind(ebp,-4), eax);
	addi(1,eax);
	storei(eax,ind(ebp,-4));
	loadi(ind(esp),ebx);
	popi(1);
	addi(ebx,eax);
	print_int(eax);
	print_char('\n');


	     //Empty Statement


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
	pushi(eax);
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
	loadi(ind(esp),ebx);
	popi(1);
	addi(ebx,eax);
	print_int(eax);
	print_char('\n');


	     //Empty Statement


	// If Statement:
	loadi(ind(ebp,-4), eax);
	cmpi(0,eax);
	jne(l16);
	move(0,eax);
	j(e16);
	move(0,eax);
	j(e16);
l16:
	move(1,eax);
e16:
	cmpi(0, eax);
	je(l15); // Jump if not equal
	storei(3, ind(ebp, -12));
	j(e15);
	l15:
	storei(4, ind(ebp, -12));
	e15:


	// While Statement:

l17:
	loadi(ind(ebp,-12), eax);
	cmpi(0,eax);
	jl(l18);
	move(0,eax);
	j(e18);
	l18:
	move(1,eax);
	e18:
	cmpi(0, eax);
	je(e17); // Jump if not equal
	loadi(ind(ebp,-12), eax);
	addi(-1,eax);
	storei(eax, ind(ebp, -12));


	print_string("Value of z in loop is :: ");
	loadi(ind(ebp,-12), eax);
	print_int(eax);
	print_char('\n');


	     //Empty Statement


	j(l17); // Jump if not equal
	e17:


	storei(0, ind(ebp, -12));


	// For Statement:

l19:
	loadi(ind(ebp,-12), eax);
	cmpi(5,eax);
	jg(l20);
	move(0,eax);
	j(e20);
	l20:
	move(1,eax);
	e20:
	cmpi(0, eax);
	je(e19); // Jump if not equal
	loadi(ind(ebp,-12), eax);
	addi(1,eax);
	storei(eax, ind(ebp, -12));


	storei(0, ind(ebp, -8));


	// While Statement:

l21:
	loadi(ind(ebp,-8), eax);
	loadi(ind(ebp,-12), ebx);
	cmpi(ebx,eax);
	jg(l22);
	move(0,eax);
	j(e22);
	l22:
	move(1,eax);
	e22:
	cmpi(0, eax);
	je(e21); // Jump if not equal
	loadi(ind(ebp,-8), eax);
	addi(1,eax);
	storei(eax, ind(ebp, -8));


	print_string("Value of y in while for loop is :: ");
	loadi(ind(ebp,-8), eax);
	print_int(eax);
	print_char('\n');


	     //Empty Statement


	j(l21); // Jump if not equal
	e21:


	print_string("Value of z in loop is :: ");
	loadi(ind(ebp,-12), eax);
	print_int(eax);
	print_char('\n');


	     //Empty Statement


	j(l19); // Jump if not equal
	e19:


	print_string("Value of x is :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_char('\n');


	     //Empty Statement


	print_string("Value of y is :: ");
	loadi(ind(ebp,-8), eax);
	print_int(eax);
	print_char('\n');


	     //Empty Statement


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


	     //Empty Statement


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


	     //Empty Statement


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


	     //Empty Statement


	print_string("Value of z is :: ");
	loadi(ind(ebp,-12), eax);
	print_int(eax);
	print_char('\n');


	     //Empty Statement


	addi(184,esp); // removing space for locals
	return; //return
}

