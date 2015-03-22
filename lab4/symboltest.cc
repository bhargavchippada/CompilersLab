// #include "symbol_table.h"
// #include <iostream>
// #include <stdio.h>

// using namespace std;

// int main(){

// 	symbTable *gobltable = new symbTable("gobl", NULL);

// 	symbTable *swaptable = new symbTable("swap",gobltable);
// 	swaptable->addEntity("x","var","int",true,4,NULL);
// 	swaptable->addEntity("y","var","int",true,4,NULL);
// 	// swaptable->printTable();

// 	gobltable->addEntity("swap","fun","void",false,0,swaptable);


// 	symbTable *trimtable = new symbTable("trim",gobltable);
// 	trimtable->addEntity("w","var","int",true,4,NULL);
// 	trimtable->addEntity("z","var","double",false,8,NULL);
// 	// trimtable->printTable();

// 	gobltable->addEntity("trim","fun","string",false,0,trimtable);

// 	gobltable->printTable();
// }