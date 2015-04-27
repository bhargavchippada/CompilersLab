void main()
{
loadi(ind(ebp,-4), eax);
	expast dummy gen code
loadi(ind(ebp,-8), eax);
	expast dummy gen code
loadi(ind(ebp,-12), eax);
	expast dummy gen code
loadi(ind(ebp,-16), eax);
	expast dummy gen code
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
loadf(ind(ebp,eax),eax);
	return; //return
}

