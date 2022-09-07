#include <stdio.h>
#include <stdlib.h>
#include <mpich/mpi.h>
void mpi_jacobi()
{
    int m = 10;
    int n = 10;
    int a[m][n];
    int b[m][n];
    srand(20220906);
    for(int i=0; i < m; i++)
    {
        for(int j=0; j<n; j++)
        {
            a[i][j] = rand()/(RAND_MAX+1.0) * 10 * (i + j);
        }
    }
    int nproc, myid;
    MPI_Status status;
    MPI_Init(NULL, NULL);
    MPI_Comm_size(MPI_COMM_WORLD, &nproc);
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
    //每个进程的行数，为了简单这里假设刚好可以除尽
    int gap =( m - 2 )/nproc;
    int start = gap * myid + 1;
    int end = gap * ( myid + 1 );
    for(int k = 0; k < 10; k++)
    {
        //从右侧邻居获得数据
        if(myid < nproc -1 )
        {
            MPI_Recv(&a[end+1][0], n, MPI_INT, myid+1, 100,MPI_COMM_WORLD,&status);
        }
        //向左侧邻居发送数据
        if(myid > 0)
        {
            MPI_Send(&a[start][0], n, MPI_INT, myid - 1,100,MPI_COMM_WORLD);
        }
        //向右侧邻居发送数据
        if(myid < nproc - 1)
        {
            MPI_Send(&a[end][0], n, MPI_INT, myid + 1, 99,MPI_COMM_WORLD);

        }
        //从左侧邻居获得数据
        if(myid > 0)
        {
            MPI_Recv(&a[start-1][0], n, MPI_INT, myid -1, 99, MPI_COMM_WORLD,&status);
        }

        for(int i=start; i<=end; i++)
        {
            for(int j = 1; j< n-1; j++)
            {
                b[i][j]=0.25*(a[i-1][j] + a[i+1][j] + a[i][j-1] + a[i][j+1]);
            }
        }

        for(int i=start; i<=end; i++)
        {
            for(int j = 1; j< n-1; j++)
            {
                a[i][j]=b[i][j];
            }
        }
    }
    for (int id = 0; id<nproc; id++)
    {
        MPI_Barrier(MPI_COMM_WORLD);
        if(myid == id)
        {
            for(int i = start; i <= end; i++)
            {
                for(int j = 1; j < n-1; j++)
                {
                    printf("a[%d][%d] is %-4d", i, j, a[i][j]);
                }
                printf("\n");
            }
        }
    }
    MPI_Finalize();

}

void mpi_jacobi2()
{
    int m = 10;
    int n = 10;
    int a[m][n];
    int b[m][n];
    srand(20220906);
    for(int i=0; i < m; i++)
    {
        for(int j=0; j<n; j++)
        {
            a[i][j] = rand()/(RAND_MAX+1.0) * 10 * (i + j);
        }
    }
    int nproc, myid;
    MPI_Status status;
    MPI_Init(NULL, NULL);
    MPI_Comm_size(MPI_COMM_WORLD, &nproc);
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
    //每个进程的行数，为了简单这里假设刚好可以除尽
    int gap =( m - 2 )/nproc;
    int start = gap * myid + 1;
    int end = gap * ( myid + 1 );
    for(int k = 0; k < 10; k++)
    {
        //从右侧邻居获得数据
        if(myid < nproc -1 )
        {
            MPI_Sendrecv(&a[end][0], n, MPI_INT, myid+1, 100, &a[end+1][0], n, MPI_INT, myid+1, 100, MPI_COMM_WORLD, &status);
        }
        //向左侧邻居发送数据
        if(myid > 0)
        {
            MPI_Sendrecv(&a[start][0], n, MPI_INT, myid-1, 100, &a[start-1][0], n, MPI_INT, myid -1, 100, MPI_COMM_WORLD, &status);
        }

        for(int i=start; i<=end; i++)
        {
            for(int j = 1; j< n-1; j++)
            {
                b[i][j]=0.25*(a[i-1][j] + a[i+1][j] + a[i][j-1] + a[i][j+1]);
            }
        }

        for(int i=start; i<=end; i++)
        {
            for(int j = 1; j< n-1; j++)
            {
                a[i][j]=b[i][j];
            }
        }
    }
    for (int id = 0; id<nproc; id++)
    {
        MPI_Barrier(MPI_COMM_WORLD);
        if(myid == id)
        {
            for(int i = start; i <= end; i++)
            {
                for(int j = 1; j < n-1; j++)
                {
                    printf("a[%d][%d] is %-4d", i, j, a[i][j]);
                }
                printf("\n");
            }
        }
    }
    MPI_Finalize();

}
int main(int argc, char *argv[])
{
    //mpi_jacobi();
    mpi_jacobi2();

    return 0;
}
