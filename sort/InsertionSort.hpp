#pragma once
template<typename T>
int InsertionSort(T *a,int N)
{
    T temp;
    for(int i=1;i<N;i++)
    {
        for(int j=i; j>0&&a[j]<a[j-1];j--)
        {
            temp=a[j];
            a[j]=a[j-1];
            a[j-1]=temp;
        }
    }
    return 1;
}