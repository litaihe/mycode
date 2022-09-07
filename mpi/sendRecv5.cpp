#include <stdio.h>
#include <stdlib.h>
#include <mpich/mpi.h>

void bsend()
{
    int myid;
    int a;
    int *tmp_buffer;
    MPI_Status status;
    MPI_Init(NULL, NULL);
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
    if( 0==myid )
    {
        a = 3;
        int size;
        MPI_Pack_size(1,MPI_INT,MPI_COMM_WORLD,&size);
        size += MPI_BSEND_OVERHEAD;
        tmp_buffer =(int *)malloc(size);
        MPI_Buffer_attach(tmp_buffer,size);
        
        MPI_Bsend(&a, 1 , MPI_INT, 1, 99, MPI_COMM_WORLD);
        
        MPI_Buffer_detach(&tmp_buffer,&size);
    
    }
    if( 1==myid )
    {
        MPI_Recv(&a,1,MPI_INT,0,99,MPI_COMM_WORLD,&status);
        printf("a is %d\n", a);
    }
    MPI_Finalize();
}

void ssend()
{
    int myid;
    int a;
    MPI_Status status;
    MPI_Init(NULL, NULL);
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
    if( 0==myid )
    {
        a = 3;
        MPI_Ssend(&a, 1, MPI_INT, 1, 99, MPI_COMM_WORLD);
        printf("rank 0 has finished\n");
        fflush(stdout);
    }
    if( 1==myid )
    {
        MPI_Recv(&a, 1, MPI_INT, 0, 99, MPI_COMM_WORLD, &status);
        printf("a is %d\n",a);
        fflush(stdout);
    }
}

int main(int argc, char *argv[])
{
    
    //bsend();
    ssend();

    return 0;
}
