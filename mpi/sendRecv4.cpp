#include <stdio.h>
#include <stdlib.h>
#include <mpich/mpi.h>

int main(int argc, char *argv[])
{
    int myid, nproc;
    int value = 0;
    MPI_Status status;
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
    MPI_Comm_size(MPI_COMM_WORLD, &nproc);
    if(0 == myid)
    {
        for(int i = 1; i < nproc; i++)
        {
            MPI_Recv(&value, 1, MPI_INT, MPI_ANY_SOURCE, MPI_ANY_TAG,MPI_COMM_WORLD, &status);
            printf("receive from process %d and values is %d\n",status.MPI_SOURCE,value);
        }
    }
    else
    {
        value = myid * 2;
        MPI_Send(&value, 1, MPI_INT, 0, myid, MPI_COMM_WORLD);
    }

    MPI_Finalize();
}
