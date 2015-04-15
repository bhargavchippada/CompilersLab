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
	j(e3);
l3:
e3:
	return; //return
}

