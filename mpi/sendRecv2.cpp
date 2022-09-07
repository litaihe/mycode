#include <stdio.h>
#include <stdlib.h>
#include "mpich/mpi.h"
typedef struct{
    int a;
    double b;
}custom_t;

int main(int argc, char *argv[])
{

    int myid;
    MPI_Status status;
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
    custom_t msg;

    if(0 == myid)
    {
        msg.a = 2;
        msg.b = 10.0;
        MPI_Send(&msg, sizeof(custom_t), MPI_BYTE, 1, 99, MPI_COMM_WORLD);
    }
    if(1 == myid)
    {
        MPI_Recv(&msg, sizeof(custom_t), MPI_BYTE, 0, 99, MPI_COMM_WORLD, &status);
        printf("msg: a is %d and b is %.2f\n",msg.a, msg.b);
    }
    MPI_Finalize();

}
