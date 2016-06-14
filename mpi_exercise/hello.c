#include "stdio.h"
#include <stdlib.h>
#include <mpi.h>
#include <string.h>
#include <unistd.h>
int main(int argc, char *argv[])
{
int rank, size, i;
int type = 0;
MPI_Status status;
char message[20];
char hostname[1024];
MPI_Init(&argc,&argv);
MPI_Comm_size(MPI_COMM_WORLD,&size);
MPI_Comm_rank(MPI_COMM_WORLD,&rank);
hostname[1023] = '\0';
gethostname(hostname, 1023);
printf("My Hostname proc %d : %s\n",rank,hostname);
if (rank == 0) {
strcpy(message,"Hello, world");
for (i = 1; i < size; i++) MPI_Send(message,
13,MPI_CHAR,i,type,MPI_COMM_WORLD);
}
else
MPI_Recv(message,20,MPI_CHAR,0,type,MPI_COMM_WORLD,&status);
printf("Message from node %d: %13s\n", rank,message);
MPI_Finalize();
}
