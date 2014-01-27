#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>

int main( int argv, char **argc )
{
	if( argv != 3 )
	{
		printf( "Invalid Parameters\nUsage: truncate path bytes\n" ); 
		return -1;
	}

	int ret = truncate( argc[1], atoi( argc[2] ) );

	if( ret != 0 )
	{
		printf( "Error: %d\n", errno );
		return -1;
	}

	return 0;
}
