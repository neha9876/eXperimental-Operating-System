decl
    integer status,n;
enddecl

integer main()
{
    status = Fork();
    if(status == -2) then
	n = Exec("odd.xsm");
    endif;
    n = Exec("even.xsm");

    return 0;
}
