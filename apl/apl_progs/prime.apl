decl
integer i,j,f,n;
enddecl
integer main(){
read(n);
i=2;
while(i<n) do
f=0;
j=2;
while(j<i) do
if(i%j==0) then
f=1;
break;
endif;
j=j+1;
endwhile;
if(f==0) then
print(i);
endif;
i=i+1;
endwhile;
return 0;
}










