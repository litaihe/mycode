#include <cstdio>
#include <cstdlib>
#include <mpich/mpi.h>
#include <vector>

template <typename T> inline T min(T a,T b)
{
    return a<b ? a:b;
}

template <typename T> inline T max(T a,T b)
{
    return a>b ? a:b;
}

int main(int argc, char *argv[])
{
    const int MAX_ROWS=1000,MAX_COLS=1000;
    std::vector<double> a(MAX_COLS*MAX_ROWS),b(MAX_COLS),
        c(MAX_ROWS),buffer(MAX_COLS),ans;
    int myid,nproc;
    
    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &nproc);
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
    
    const int root=0;
    int rows = 100;
    int cols = 100;

    if(0==myid)
    {
        for(int i=0; i<cols; i++)
        {
            b[i] = i;
            for(int j=0; j<rows; j++)
            {
                a[i*MAX_ROWS+j] = j;
            }
        }
        MPI_Bcast((void*)b.data(), cols, MPI_DOUBLE, root, MPI_COMM_WORLD);
        for(int i=1; i < min<int>(nproc-1,rows); i++)
        {
            for(int j=0; j<cols; j++)
            {
                buffer[j] = a[i*MAX_ROWS+j];
            }
            MPI_Send( (void*)buffer.data(),cols,MPI_DOUBLE,i,MPI_ANY_TAG,MPI_COMM_WORLD);
        }
    }
    else
    {
        MPI_Bcast((void*)b.data(), cols, MPI_DOUBLE, root, MPI_COMM_WORLD);
    }

    if(1 == myid)
    {
        for(int i=0; i<cols; i++)
        {
            printf("%lf ",b[i]);
        }
        printf("\n");
        fflush(stdout);
    }

    MPI_Finalize();

}
