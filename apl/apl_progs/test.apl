decl
	integer status , status1;
enddecl
integer main()
{
	status = Create("myfile.dat");
	print(status);
        
       status1 = Delete("myfile.dat");
        print(status1);
	return 0;
}
