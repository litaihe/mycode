#pragma once

template <typename T>
void ShellSort(T *a,int N)
{
    int h=1;
    T temp=0;
    while(h<N/3)
    {
        h=3*h+1;
    }
    while(h>=1)
    {
        for(int i=h;i<N;i++)
        {
            for(int j=i;j>=h &&a[j]<a[j-h];j-=h)
            {
                temp=a[j];
                a[j]=a[j-h];
                a[j-h]=temp;
            }
        }
        h=h/3;
    }
}