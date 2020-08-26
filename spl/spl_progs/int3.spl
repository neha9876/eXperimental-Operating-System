//Description: Changes the LSEEK position
//System Call No: 6
//Interrupt No: 3
//Arguments: 1. fileDescriptor 2. newLseek
//Return Value: 0 (Success) or -1 (Failure) 



alias physicalSP S0;
physicalSP = ([PTBR + 2*(SP/512)]*512) + SP%512;

alias sysCallNo S1;
sysCallNo = [physicalSP - 1];

alias newLseek S2;
newLseek = [physicalSP - 3];

alias fileDesc S3;
fileDesc = [physicalSP - 4];


//The Seek system call changes the word at which read/write operations take place within a file
//This field is modified to newLseek if the newLseek value is valid, i.e. the word lies within the file


if(sysCallNo == 6) then
    alias sw_index S4;
    alias fat_index S5;
    alias file_size S6;
    alias seek S7;

    if(fileDesc > 7 || fileDesc < 0) then
	[physicalSP - 2] = -1;
	
	//Return from the system call with -1, indicating failure if the fileDescriptor specified as argument is invalid. 
	
	ireturn;
    endif;


	//Index into the per-process open file table in the PCB of the process with the fileDescriptor.
	//If the entry is invalid, return from the system call with -1, indicating failure.
	
	
	
    sw_index = [READY_LIST + 15 + fileDesc*2];
    if(sw_index == -1) then
	[physicalSP - 2] = -1;
	ireturn;
    endif;

	//If a valid entry exists, store the Pointer to System Wide Open File Table Entry field in a register. 
	//Using the Pointer to System Wide Open File Table Entry field, index to the System Wide Open File Table to get the FAT Index Entry. 
	
	
    fat_index = [FILE_TABLE + sw_index*2];
    file_size = [FAT + fat_index*8 + 1];//Fetch the file size of the file from the FAT and store it in a register. 


	//LSEEK position is valid if it takes a value from 0 to file size. 
	//Check if the new LSEEK position specified as argument is valid.
	//If it is not valid, return from the system call with -1, indicating failure.
	
	
    if(newLseek >= file_size) then
	[physicalSP - 2] = -1;
	ireturn;
    endif;

    [READY_LIST + 15 + fileDesc*2 + 1] = newLseek;//Change the LSEEK in the per-process file table to newLseek.
    [physicalSP - 2] = 0;//Return with 0 (indicating success).

endif;




//Description: Reads a word from a file to the variable passed as argument.
//System Call No: 7
//Interrupt No: 3
//Arguments: 1) fileDescriptor 2) wordRead
//Return Value: 0 (success) and -1 (failure) 




//The Read system call takes the fileDescriptor given as argument to identify the open instance of the file in the per-process file table. 
//Read system call is used to read one word at the position pointed to by LSEEK in the file and store it in the variable wordRead specified as argument in APL


if(sysCallNo == 7) then
    alias sw_index S4;
    alias fat_index S5;
    alias file_size S6;
    alias LSEEK S7;
    alias bb S8;
    alias db S9;
    alias offset S10;

    if(fileDesc > 7 || fileDesc < 0) then
	[physicalSP - 2] = -1;//Return from the system call with -1, indicating failure if the fileDescriptor specified as argument is invalid.
	ireturn;
    endif;
	
	
	//Index into the per-process open file table in the PCB of the process with the fileDescriptor. 
	//If the entry is invalid return from the system call with -1, indicating failure.	
	
    sw_index = [READY_LIST + 15 + fileDesc*2];
    if(sw_index == -1) then
	[physicalSP - 2] = -1;
	ireturn;
    endif;


	//If a valid entry exists, store the Pointer to System Wide Open File Table Entry field and LSEEK position field in registers.
	//Using the Pointer to System Wide Open File Table Entry, index to the System Wide Open File Table to get the FAT Index field. 
    LSEEK = [READY_LIST + 15 + fileDesc*2 + 1];
    fat_index = [FILE_TABLE + sw_index*2];
	
	
	//Using the FAT Index, fetch the Basic Block from the FAT and load it to the scratchpad. 
	//This is done to find the block from which the word is to be read. The basic block contains block numbers of all data blocks of the file.
    file_size = [FAT + fat_index*8 + 1];
    bb = [FAT + fat_index*8 + 2];
	
	//Check if LSEEK position is at the end of the file. If it is at the end of the file, then there is no word to be read. 
	//Return from the system call with -1 indicating error. At the end of the file, LSEEK position value will be equal to file size. 
    if(LSEEK >= file_size) then
	[physicalSP - 2] = -1;
	ireturn;
    endif;
	
	
//Using LSEEK position, find the block number of the data block from which the word is to be read.
//The data block number can be obtained from the basic block of the file as explained in Write system call. 
    load(1,bb);
    db = [SCRATCHPAD + LSEEK/512];////Fetch the block from the disk to the scratchpad. 
    load(1,db);
    offset = LSEEK%512;//Read from this block using the offset calculated using LSEEK position.  
	
	
	//Icrement LSEEK Position by 1 in the Per-Process Open File Table.
	//This is because a word is read and LSEEK position must be pointing to the next word. 
    [physicalSP - 3] = [SCRATCHPAD + offset];//To do this store the word read to physicalSP - 3.
    [physicalSP - 2] = 0;//Return with 0, indicating success 
endif;

ireturn;
