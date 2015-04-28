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




	loadi(ind(ebp,-8), eax);
	storei(eax, ind(ebp, -4));


	loadi(ind(ebp,-4), eax);
	cmpi(6,eax);
	jl(l1);
	move(0,eax);
	j(e1);
	l1:
	move(1,eax);
	e1:
	storei(eax, ind(ebp, -12));


	print_string("Value of z in f is :: ");
	loadi(ind(ebp,-12), eax);
	print_int(eax);
	print_char('\n');




	loadi(ind(ebp,-4), eax);
	cmpi(6,eax);
	jg(l2);
	move(0,eax);
	j(e2);
	l2:
	move(1,eax);
	e2:
	storei(eax, ind(ebp, -12));


	print_string("Value of z in f is :: ");
	loadi(ind(ebp,-12), eax);
	print_int(eax);
	print_char('\n');




	loadi(ind(ebp,-4), eax);
	cmpi(6,eax);
	jle(l3);
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
	cmpi(6,eax);
	jge(l4);
	move(0,eax);
	j(e4);
	l4:
	move(1,eax);
	e4:
	storei(eax, ind(ebp, -12));


	print_string("Value of z in f is :: ");
	loadi(ind(ebp,-12), eax);
	print_int(eax);
	print_char('\n');




	loadi(ind(ebp,-4), eax);
	cmpi(6,eax);
	je(l5);
	move(0,eax);
	j(e5);
	l5:
	move(1,eax);
	e5:
	storei(eax, ind(ebp, -12));


	print_string("Value of z in f is :: ");
	loadi(ind(ebp,-12), eax);
	print_int(eax);
	print_char('\n');




	loadi(ind(ebp,-4), eax);
	cmpi(6,eax);
	jne(l6);
	move(0,eax);
	j(e6);
	l6:
	move(1,eax);
	e6:
	storei(eax, ind(ebp, -12));


	print_string("Value of z in f is :: ");
	loadi(ind(ebp,-12), eax);
	print_int(eax);
	print_char('\n');




	// returnast
	loadi(ind(ebp,-4), eax);
	loadi(ind(ebp,-8), ebx);
	cmpi(ebx,eax);
	jl(l7);
	move(0,eax);
	j(e7);
	l7:
	move(1,eax);
	e7:
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
	addi(-100,esp); // making space for locals
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


	storei(1, ind(ebp, -4));


	storei(2, ind(ebp, -8));


	storei(5, ind(ebp, -12));


	move(8,eax);
	intTofloat(eax);
	storef(eax, ind(ebp, -100));


	move(0,eax);
	intTofloat(eax);
	storef(eax, ind(ebp, -100));


	storei(0, ind(ebp, -8));


	loadi(ind(ebp,-4), eax);
	loadi(ind(ebp,-8), ebx);
	cmpi(ebx,eax);
	jne(l8);
	move(0,eax);
	j(e8);
	l8:
	move(1,eax);
	e8:
	storei(eax, ind(ebp, -8));


	print_string("Value of y in f is :: ");
	loadi(ind(ebp,-8), eax);
	print_int(eax);
	print_char('\n');




	move(1.000000,eax);
	cmpf(0,eax);
	je(l9);
	move(1,eax);
	j(e9);
	move(1,eax);
	j(e9);
l9:
	move(0,eax);
e9:
	storei(eax, ind(ebp, -4));


	print_string("Value of x is :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_char('\n');




	move(1,eax);
	cmpi(0,eax);
	je(l10);
	move(1,eax);
	j(e10);
	move(1,eax);
	j(e10);
l10:
	move(0,eax);
e10:
	storei(eax, ind(ebp, -4));


	print_string("Value of x is :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_char('\n');




	move(0.000000,eax);
	cmpf(0,eax);
	je(l11);
	move(1,eax);
	j(e11);
	move(1,eax);
	j(e11);
l11:
	move(0,eax);
e11:
	floatToint(eax);
	storei(eax, ind(ebp, -4));


	print_string("Value of x is :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_char('\n');




	move(1.000000,eax);
	cmpf(0,eax);
	je(l12);
	move(1,eax);
	j(e12);
	move(1,eax);
	j(e12);
l12:
	move(0,eax);
e12:
	floatToint(eax);
	storei(eax, ind(ebp, -4));


	print_string("Value of x is :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_char('\n');




	move(6.000000,eax);
	cmpf(0,eax);
	je(l13);
	move(1,eax);
	j(e13);
	move(1,eax);
	j(e13);
l13:
	move(0,eax);
e13:
	floatToint(eax);
	storei(eax, ind(ebp, -4));


	print_string("Value of x is :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_char('\n');




	move(0,eax);
	loadi(ind(ebp,-12), ebx);
	cmpi(0,eax);
	je(l14);
	cmpi(0,ebx);
	je(l14);
	move(1,eax);
	j(e14);
l14:
	move(0,eax);
e14:
	storei(eax, ind(ebp, -4));


	print_string("Value of x is :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_char('\n');




	loadi(ind(ebp,-12), eax);
	cmpi(0,eax);
	je(l15);
	move(0,eax);
	j(e15);
	move(1,eax);
	j(e15);
l15:
	move(0,eax);
e15:
	storei(eax, ind(ebp, -4));


	print_string("Value of x is :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_char('\n');




	loadf(ind(ebp,-100), eax);
	cmpf(0,eax);
	je(l16);
	move(1,eax);
	j(e16);
	move(1,eax);
	j(e16);
l16:
	move(0,eax);
e16:
	storei(eax, ind(ebp, -4));


	print_string("Value of x is :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_char('\n');




	move(6,eax);
	loadf(ind(ebp,-100), ebx);
	cmpi(0,eax);
	je(l17);
	cmpf(0,ebx);
	je(l17);
	move(1,eax);
	j(e17);
l17:
	move(0,eax);
e17:
	storei(eax, ind(ebp, -4));


	print_string("Value of x is :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_char('\n');




	print_string("Value of x idlfdhflkjl");
	print_char('\n');




	loadi(ind(ebp,-8), eax);
	loadi(ind(ebp,-12), ebx);
	cmpi(0,eax);
	jne(l18);
	cmpi(0,ebx);
	jne(l18);
	move(0,eax);
	j(e18);
l18:
	move(1,eax);
e18:
	storei(eax, ind(ebp, -4));


	print_string("Value of x is :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_char('\n');




	loadi(ind(ebp,-12), eax);
	loadi(ind(ebp,-8), ebx);
	cmpi(0,eax);
	jne(l19);
	cmpi(0,ebx);
	jne(l19);
	move(0,eax);
	j(e19);
l19:
	move(1,eax);
e19:
	storei(eax, ind(ebp, -4));


	print_string("Value of x is :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_char('\n');





	 // paramater loading :: f
	pushi(0); //To make space in stack for return val
	move(6,eax);
	intTofloat(eax);
	pushf(eax); // argument to fact
	loadf(ind(ebp,-100), eax);
	floatToint(eax);
	pushi(eax); // argument to fact
	loadi(ind(ebp,-4), eax);
	pushi(eax); // argument to fact
	f();
	popi(2);
	popf(1);
	loadi(ind(esp),eax); // receives the return value
	popi(1); // Clean up return value

	storei(eax, ind(ebp, -4));


	print_string("Value of x after funcall is :: ");
	loadi(ind(ebp,-4), eax);
	print_int(eax);
	print_char('\n');




	loadi(ind(ebp,-12), eax);
	loadi(ind(ebp,-12), ebx);
	muli(ebx,eax);
	pushi(eax);
	loadi(ind(ebp,-8), eax);
	loadi(ind(ebp,-8), ebx);
	muli(ebx,eax);
	pushi(eax);
	loadi(ind(ebp,-4), eax);
	pushi(eax);
	move(1,eax);
	addi(2,eax);
	muli(-20,eax);
	pushi(eax);
	loadi(ind(ebp,-4), eax);
	loadi(ind(ebp,-8), ebx);
	addi(ebx,eax);
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
	loadi(ind(esp),ebx);
	popi(1);
	muli(ebx,eax);
	loadi(ind(esp),ebx);
	popi(1);
	addi(ebx,eax);
	loadi(ind(esp),ebx);
	popi(1);
	addi(ebx,eax);
	pushi(eax);
	move(1,eax);
	addi(1,eax);
	muli(-20,eax);
	pushi(eax);
	move(2,eax);
	addi(1,eax);
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


	print_string("Value of y is :: ");
	loadi(ind(ebp,-8), eax);
	print_int(eax);
	print_char('\n');




	move(1,eax);
	addi(1,eax);
	muli(-20,eax);
	pushi(eax);
	loadi(ind(ebp,-4), eax);
	loadi(ind(ebp,-8), ebx);
	addi(ebx,eax);
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
	pushi(eax);
	move(1,eax);
	addi(1,eax);
	muli(-20,eax);
	pushi(eax);
	loadi(ind(ebp,-4), eax);
	loadi(ind(ebp,-8), ebx);
	addi(ebx,eax);
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
	pushi(eax);
	move(1,eax);
	addi(1,eax);
	muli(-20,eax);
	pushi(eax);
	loadi(ind(ebp,-4), eax);
	loadi(ind(ebp,-8), ebx);
	addi(ebx,eax);
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
	pushi(eax);
	move(1,eax);
	addi(1,eax);
	muli(-20,eax);
	pushi(eax);
	loadi(ind(ebp,-4), eax);
	loadi(ind(ebp,-8), ebx);
	addi(ebx,eax);
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
	loadi(ind(esp),ebx);
	popi(1);
	muli(ebx,eax);
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
	loadi(ind(ebp,eax),eax);
	pushi(eax);
	move(2,eax);
	loadi(ind(esp),ebx);
	popi(1);
	muli(ebx,eax);
	pushi(eax);
	move(1,eax);
	muli(-20,eax);
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
	loadi(ind(ebp,eax),eax);
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
	loadi(ind(esp),ebx);
	popi(1);
	addi(ebx,eax);
	muli(-20,eax);
	pushi(eax);
	loadi(ind(ebp,-4), eax);
	loadi(ind(ebp,-8), ebx);
	addi(ebx,eax);
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
	pushi(eax);
	move(1,eax);
	addi(1,eax);
	muli(-20,eax);
	pushi(eax);
	loadi(ind(ebp,-4), eax);
	loadi(ind(ebp,-8), ebx);
	addi(ebx,eax);
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
	loadi(ind(esp),ebx);
	popi(1);
	muli(ebx,eax);
	loadi(ind(esp),ebx);
	popi(1);
	muli(ebx,eax);
	loadi(ind(esp),ebx);
	popi(1);
	muli(ebx,eax);
	loadi(ind(esp),ebx);
	popi(1);
	muli(ebx,eax);
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
	loadi(ind(ebp,eax),eax);
	pushi(eax);
	move(3,eax);
	loadi(ind(esp),ebx);
	popi(1);
	muli(ebx,eax);
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
	loadi(ind(ebp,eax),eax);
	pushi(eax);
	move(2,eax);
	loadi(ind(esp),ebx);
	popi(1);
	muli(ebx,eax);
	loadi(ind(esp),ebx);
	popi(1);
	addi(ebx,eax);
	pushi(eax);
	move(0,eax);
	loadi(ind(esp),ebx);
	popi(1);
	muli(ebx,eax);
	muli(-20,eax);
	pushi(eax);
	loadi(ind(ebp,-4), eax);
	loadi(ind(ebp,-8), ebx);
	addi(ebx,eax);
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


	storei(4, ind(ebp, -8));


	print_string("Value of y is :: ");
	loadi(ind(ebp,-8), eax);
	print_int(eax);
	print_char('\n');




	move(867.400024,eax);
	floatToint(eax);
	storei(eax, ind(ebp, -12));


	loadi(ind(ebp,-8), eax);
	loadi(ind(ebp,-12), ebx);
	muli(-1,ebx);
	addi(ebx,eax);
	storei(eax, ind(ebp, -4));


	print_string("Value of y is :: ");
	loadi(ind(ebp,-8), eax);
	print_int(eax);
	print_char('\n');




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
	loadi(ind(ebp,eax),eax);
	storei(eax, ind(ebp, -4));


	move(0,eax);
	cmpi(0,eax);
	jne(l20);
	move(0,eax);
	j(e20);
	move(0,eax);
	j(e20);
l20:
	move(1,eax);
e20:
	storei(eax, ind(ebp, -4));


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




	addi(100,esp); // removing space for locals
	return; //return
}

