integer main()
{
	integer status, newLseek, fileDesc;
	string wordToWrite, wordRead;

	read(wordToWrite);
	read(newLseek);
        
        status = Create("myfile.dat");
	print(status);
	
	fileDesc = Open("myfile.dat");
	print(status);

	status = Seek(fileDesc, newLseek);
	print(status);

	status = Write(fileDesc, wordToWrite);
	print(status);

	status = Seek(fileDesc, newLseek);
	status = Read(fileDesc, wordRead);
	print(wordRead);

	return 0;
}
