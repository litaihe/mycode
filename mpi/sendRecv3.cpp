#include <stdio.h>
#include <stdlib.h>
#include <mpich/mpi.h>

int main(int argc, char *argv[])
{
    const int n=10;
    int half_n = 5;
    int buffer[n] = {0};
    int myid;
    MPI_Status status;
    for(int i=0; i<half_n; i++)
    {
        buffer[i] = i;
    }
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
    if(0 == myid)
    {
        MPI_Send(&buffer, half_n, MPI_INT, 1, 99, MPI_COMM_WORLD);
    }
    if(1 == myid)
    {
        int recv_count = 0;
        MPI_Probe(0, 99, MPI_COMM_WORLD, &status);
        MPI_Get_count(&status, MPI_INT, &recv_count);
        MPI_Recv(&buffer, n, MPI_INT, 0, 99, MPI_COMM_WORLD, &status);
        //MPI_Get_count(&status, MPI_INT, &recv_count);
        printf("rank 1 receive %d int\n",recv_count);
        for(int i = 0; i < n; i++)
        {
            printf("buffer[%d] is %d\n",i, buffer[i]);
        }
    }
    MPI_Finalize();

}
