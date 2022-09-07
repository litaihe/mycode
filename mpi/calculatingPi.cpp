#include <iostream>
#include <cmath>
#include <mpich/mpi.h>

int main(int argc, char *argv[])
{
    MPI_Init(&argc, &argv);
    int myid,nproc;

    MPI_Comm_rank(MPI_COMM_WORLD,&myid);
    MPI_Comm_size(MPI_COMM_WORLD,&nproc);
    int NumOfIntervals;
//    while(1)
    {
        if(myid==0)
        {
 //           printf("Enter the number of intervals: (0 quits) ");
 //           scanf("%d",&NumOfIntervals);
            NumOfIntervals=1000000000;
 //           printf("the number of intervals is %d\n",NumOfIntervals);
        }
        MPI_Bcast(&NumOfIntervals, 1, MPI_INT, 0, MPI_COMM_WORLD);
        if(0==NumOfIntervals)
        {
 //           break;
        }
        else
        {
            double h=1.0/(double)NumOfIntervals;
            double sum=0.0;
            for(int i=myid+1; i<=NumOfIntervals; i+=nproc)
            {
                double x = h * (i-0.5) ;
                sum += 4/(1+x*x) ;
            }
            double mypi=sum * h;
            double pi;
            MPI_Reduce(&mypi,&pi,1,MPI_DOUBLE,MPI_SUM,0,MPI_COMM_WORLD);
            if(myid==0)
            {
                printf("pi is approximately %.16f\n",pi);
            }
        }
    }
}
