/*
 * First example of using threads in C
 *
 * GIlberto Echeverria
 * 2024-05-28
 * This code was taken from the repository of the class
 */

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

typedef struct
{
    int id;
    long *counter_ptr

} thread_data_t;

// Function declarations
void *thread_func(void *);

int main(int argc, char *argv[])
{
    int num_threads = 4;
    int status;
    // This variable will be used by all threads
    long counter;

    if (argc == 2)
    {
        num_threads = atoi(argv[1]);
    }

    // Array to store the thread id's
    pthread_t tids[num_threads];
    // Array for the data to be sent to the threads
    thread_data_t data[num_threads];

    for (int i = 0; i < num_threads; i++)
    {
        data[i].id = i;
        data[i].counter_ptr = &counter;
        // pthread_create arguments:
        // - pointer to id variable
        // - pointer to thread options
        // - pointer to function
        // - pointer to funtion argument
        status = pthread_create(&tids[i], NULL, &thread_func, &data[i]);
        printf("Created thread %ld with id: %lu\n", i, tids[i]);
    }

    return 0;
}

void *thread_func(void *args)
{
    long id = (long)args;
    printf("This is thread %ld\n", id);
    pthread_exit(NULL);
}