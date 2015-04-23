void remake()
{
	pushi(ebp); // Setting dynamic link
	move(esp,ebp); // Setting dynamic link
dummy gen code
dummy gen code
e:  loadi(ind(ebp), ebp); // restoring dynamic link
	popi(1); //pop stack
	return; //return
}

void swap()
{
	pushi(ebp); // Setting dynamic link
	move(esp,ebp); // Setting dynamic link
dummy gen code
e:  loadi(ind(ebp), ebp); // restoring dynamic link
	popi(1); //pop stack
	return; //return
}

void main()
{
dummy gen code
dummy gen code
dummy gen code
dummy gen code
dummy gen code
dummy gen code
	return; //return
}

