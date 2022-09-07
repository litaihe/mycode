#include <mpich/mpi.h>
#include <cstring>
#include <iostream>

const int SIZE=16<<20;

int main(int argc,char *argv[])
{
    static int buf1[SIZE],buf2[SIZE];
    int nprocs, myid, tag, src, dst;
    MPI_Status status;
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD,&myid);
    MPI_Comm_size(MPI_COMM_WORLD,&nprocs);

    //初始化
    memset(buf1,1,SIZE*sizeof(int));
    tag=123;
    dst= (myid >= nprocs-1) ? 0 : myid+1;
    src= (myid==0) ? nprocs -1 : myid-1;
    MPI_Barrier(MPI_COMM_WORLD);
    printf("%d/%d:src-%d,dst-%d\n",myid,nprocs,src,dst);
  
    //MPI_Sendrecv(buf1, SIZE, MPI_INT, dst, tag, buf2, SIZE, MPI_INT, src, tag, MPI_COMM_WORLD, &status);
    

    //死锁
    //MPI_Send(buf1,SIZE,MPI_INT,dst,tag,MPI_COMM_WORLD);
    //MPI_Recv(buf2,SIZE,MPI_INT,src,tag,MPI_COMM_WORLD,&status);
    MPI_Request request_s,request_r;
    
    //
    MPI_Isend(buf1, SIZE, MPI_INT, dst, tag, MPI_COMM_WORLD,&request_s);
    MPI_Irecv(buf2, SIZE, MPI_INT, src, tag, MPI_COMM_WORLD,&request_r);

    MPI_Wait(&request_s,&status);
    MPI_Wait(&request_r,&status);
    
    //std::cout << status << std::endl;
    
    MPI_Finalize();
    return 0;
}
