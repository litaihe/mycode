#include <stdio.h>
#include <stdlib.h>
#include <mpich/mpi.h>

int main(int argc, char *argv[])
{

    int param ;
    MPI_Status status;
    MPI_Init(&argc, &argv);
    int myid, nproc;
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
    MPI_Comm_size(MPI_COMM_WORLD, &nproc);
    if(0 == myid)
    {
        param = 3;
        printf("rank 0 send rank 1 : %d\n", param);
        param++;
        MPI_Send(&param, 1, MPI_INT, 1, 99, MPI_COMM_WORLD);
    }
    else
    {
        MPI_Recv(&param, 1, MPI_INT, myid-1,99, MPI_COMM_WORLD,&status);
        printf("rank %d receive from %d: %d\n", myid, myid-1, param);
        if( myid < nproc-1 )
        {
            param++;
            printf("rank %d send rank %d: %d\n",myid, myid+1, param);
            MPI_Send(&param,1, MPI_INT, myid+1, 99, MPI_COMM_WORLD);
        }
    }
    
    MPI_Finalize();

}
