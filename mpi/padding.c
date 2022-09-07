#include <stdio.h>

typedef struct
{
    double d;
    char c;
}CS;

typedef struct
{
    char c1;
    double d;
    char c2;
}CS1;
int main(int argc, char *argv[])
{
    CS a;
    CS1 b;
    
    printf("sizeof(CS)=%zd\n",sizeof(CS));
    printf("offse(a.d)=%ld,offset(a.c)=%ld\n",(char*)&a.d-(char*)&a,(char*)&a.c-(char*)&a);

    printf("sizeof(CS1)=%zd\n",sizeof(CS1));
    printf("offse(b.c1)=%ld,offset(b.d)=%ld,offset(b.d)=%ld\n",(char*)&b.c1-(char*)&b,(char*)&b.d-(char*)&b,(char*)&b.c2-(char*)&b);
    return 0;
}

