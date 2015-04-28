void f()
{
	pushi(ebp); // Setting dynamic link
	move(esp,ebp); // Setting dynamic link
e:  loadi(ind(ebp), ebp); // restoring dynamic link
	popi(1); //pop stack
	return; //return
}

void main()
{
	addi(-96,esp);
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


	print_string("Value of y is :: ");
	loadi(ind(ebp,-8), eax);
	print_int(eax);
	print_char('\n');




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




	return; //return
}

