#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mpich/mpi.h>

typedef struct{
    int a;
    int b;
}contiguous_type;

void cont_type()
{
    int rank, size;
    contiguous_type data;
    MPI_Datatype newtype;
    MPI_Status status;
    MPI_Init(NULL, NULL);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Type_contiguous(2, MPI_INT, &newtype);
    MPI_Type_commit(&newtype);
    int tag=99;
    if(0 == rank)
    {
        data.a = 1;
        data.b = 2;
        MPI_Send(&data, 1, newtype, 1, tag, MPI_COMM_WORLD);
    }

    if(1 == rank)
    {
        MPI_Recv(&data, 1, newtype, 0 ,tag, MPI_COMM_WORLD, &status);
    }
    printf("%d/%d : data.a=%d, data.b=%d\n",rank,size,data.a, data.b);
    
    MPI_Type_free(&newtype);
    
    MPI_Finalize();
}
void vector_type()
{
    MPI_Init(NULL,NULL);
    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    const int n=10;
    int *buffer=(int*)malloc(sizeof(int)*n);
    memset( buffer, 0, sizeof(int)*n );
    MPI_Datatype newtype;
    MPI_Status status;
    int tag=99;
    int count = 2;
    int blocklength = 2;
    int stride = 3;
    //int stride = 5*sizeof(int);
    MPI_Type_vector(count, blocklength, stride, MPI_INT, &newtype);
    //MPI_Type_hvector(count, blocklength, stride, MPI_INT, &newtype);
    MPI_Type_commit(&newtype);
    if(0==rank)
    {
        for(int i=0; i<n; i++)
        {
            buffer[i] = i+1;
        }
        MPI_Send(buffer, 1, newtype, 1, tag, MPI_COMM_WORLD);
    }
    
    if(1==rank)
    {
        MPI_Recv(buffer, 1 , newtype, 0, tag, MPI_COMM_WORLD, &status);
        for(int i=0; i<n; i++)
        {
            printf("buffer[%d] is %d\n",i, buffer[i]);
        }
    }
    MPI_Type_free(&newtype);
    if(buffer!=NULL)
    {
        free(buffer);
        buffer=NULL;
    }
    MPI_Finalize();

}
void index_type()
{
    int rank,size;
    int tag=99;
    int n=10;
    int *buffer=(int*)malloc(sizeof(int)*n);
    MPI_Init(NULL,NULL);
    const int count =2;
    int blocklength[count];
    int index[count];
    MPI_Datatype newtype;
    MPI_Status status;
    MPI_Comm_rank(MPI_COMM_WORLD,&rank);
    MPI_Comm_size(MPI_COMM_WORLD,&size);
    blocklength[0] = 1;
    blocklength[1] = 3;
    index[0] = 0;
    index[1] = 5;
    MPI_Type_indexed(count, blocklength, index, MPI_INT, &newtype);
    
    MPI_Type_commit(&newtype);
    if(0==rank)
    {
        for(int i=0; i<n; i++)
        {
            buffer[i] = i+1;
        }
        MPI_Send(buffer, 1, newtype, 1, tag, MPI_COMM_WORLD);
    }
    
    if(1==rank)
    {
        MPI_Recv(buffer, 1 , newtype, 0, tag, MPI_COMM_WORLD, &status);
        for(int i=0; i<n; i++)
        {
            printf("buffer[%d] is %d\n",i, buffer[i]);
        }
    }
    MPI_Type_free(&newtype);

    if(NULL != buffer)
    {
        free(buffer);
        buffer = NULL;
    }
    MPI_Finalize();
}
typedef struct
{
    double d;
    double d2;
    int i;
    char c;
}my_struct;
void struct_type()
{
    MPI_Init(NULL,NULL);
    int rank,size;
    const int count=3;
    int blocklength[count];
    MPI_Aint index[count];
    MPI_Datatype oldtype[count];
    MPI_Datatype newtype;
    MPI_Status status;
    my_struct data;

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    blocklength[0] = 2;
    blocklength[1] = 1;
    blocklength[2] = 1;
    index[0] = 0;
    index[1] = sizeof(double)*2;
    index[2] = sizeof(double)*2+sizeof(int);
    oldtype[0] = MPI_DOUBLE;
    oldtype[1] = MPI_INT;
    oldtype[2] = MPI_CHAR;
    printf("%ld,%ld,%ld\n",index[0],index[1],index[2]);
    MPI_Type_struct(count, blocklength, index, oldtype, &newtype);
    MPI_Type_commit(&newtype);
    MPI_Aint extent;
    MPI_Type_extent(newtype, &extent);
    printf("extent=%ld\n",extent);
    int newtypeSize;
    MPI_Type_size(newtype,&newtypeSize);
    printf("newtype size=%d\n",newtypeSize);
    int tag=99;
    if(0==rank)
    {
        data.d  = 2.0;
        data.d2 = 3.5;
        data.i = 400000;
        data.c = 'c';
        MPI_Send(&data, 1, newtype, 1, 99, MPI_COMM_WORLD);
        //printf("data.d is %.2f, data.d2 is %.3f, data.i is %d, data.c is %c\n",data.d, data.d2, data.i, data.c);
    }
    if(1==rank)
    {
        MPI_Recv(&data, 1, newtype, 0 ,99, MPI_COMM_WORLD, &status);
        printf("data.d is %.2f, data.d2 is %.2f, data.i is %d, data.c is %c\n",data.d, data.d2, data.i, data.c);
        int elemCount;
        MPI_Get_elements(&status, newtype, &elemCount);
        printf("elements count=%d\n",elemCount);
        int count;
        MPI_Get_count(&status, newtype, &count);
        printf("count=%d\n", count);
    }
    //MPI_Barrier(MPI_COMM_WORLD);
    MPI_Type_free(&newtype);
    MPI_Finalize();
}
void address_test()
{
    const int n=10;
    int buf[10];
    MPI_Init(NULL,NULL);
    MPI_Aint a1,a2;
    MPI_Get_address(&buf[0], &a1);
    MPI_Get_address(&buf[1], &a2);
    printf("a1=%ld,a2=%ld\n",a1,a2);
    MPI_Finalize();
}
void pack_and_unpack()
{
    int rank;
    int i;
    double d;
    char c;
    int tag=99;
    char buffer[20];
    int position = 0;
    MPI_Status status;
    MPI_Init(NULL,NULL);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    if(0 == rank)
    {
        i = 1;
        d = 4.5;
        c = 'a';
        MPI_Pack(&i, 1, MPI_INT, buffer, 20, &position, MPI_COMM_WORLD);
        MPI_Pack(&d, 1, MPI_DOUBLE, buffer, 20, &position, MPI_COMM_WORLD);
        MPI_Pack(&c, 1, MPI_CHAR, buffer, 20, &position, MPI_COMM_WORLD);
        printf("position is %d\n",position);
        MPI_Send(buffer, position, MPI_PACKED, 1, tag, MPI_COMM_WORLD);
    }
    if(1 == rank)
    {
        MPI_Recv(buffer, 20, MPI_PACKED, 0, tag, MPI_COMM_WORLD, &status);
        MPI_Unpack(buffer, 20, &position, &i, 1, MPI_INT, MPI_COMM_WORLD);
        MPI_Unpack(buffer, 20, &position, &d, 1, MPI_DOUBLE, MPI_COMM_WORLD);
        MPI_Unpack(buffer, 20, &position, &c, 1, MPI_CHAR, MPI_COMM_WORLD);
        printf("position is %d\n",position);
        printf("i is %d, d is %lf, c is %c\n",i,d,c);
    }
    MPI_Finalize();
}
int main()
{
    //cont_type();
    //vector_type();
    //index_type();
    //struct_type();
    pack_and_unpack();
    //address_test();
    return 0;
}
