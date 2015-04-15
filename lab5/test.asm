void remake()
{
	pushi(ebp); // Setting dynamic link
	move(esp,ebp); // Setting dynamic link
	storef(ebx, ind(ebp,  3*F + I << )); // Save the return value in stack
	j(e); // Unconditional jump

e:  loadi(ind(ebp), ebp); // restoring dynamic link
	popi(1); //pop stack
	return; //return
}

void swap()
{
	pushi(ebp); // Setting dynamic link
	move(esp,ebp); // Setting dynamic link

e:  loadi(ind(ebp), ebp); // restoring dynamic link
	popi(1); //pop stack
	return; //return
}

void main()
{

	// parameter loading :: remake
	pushi(0); //To make space in stack for return val
	pushi(eax); // argument to fact
	pushf(2); // argument to fact
	remake();
	popi(1);
	popf(1);
	popi(1); // Clean up return value


	// parameter loading :: remake
	pushi(0); //To make space in stack for return val
	pushi(3); // argument to fact
	move(4, eax);
	intTofloat(eax);
	pushf(eax); // argument to fact
	remake();
	popi(1);
	popf(1);
	popi(1); // Clean up return value


l1:
	cmpi(0, eax);
	jne(e1); // Jump if not equal
	j(l1);

e1:

l2:
	cmpi(0, eax);
	jne(e2); // Jump if not equal
	j(l2);

e2:
	cmpi(0, eax);
	jne(l3); // Jump if not equal
	cmpi(0, eax);
	jne(l4); // Jump if not equal
	j(e4);
l4:

e4:
	j(e3);
l3:

e3:
	return; //return
}

