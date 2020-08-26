decl 
	integer fileDesc,status;
enddecl

integer main()
{
	fileDesc = Open("myfile.dat");
	print(fileDesc);

	status = Close(fileDesc);
	print(status);

	

	return 0;
}
