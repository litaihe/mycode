#pragma once

template<typename T>
int SelectionSort(T *a,int N)
{
    T temp;
    for(int i=0;i<N;i++)
    {
        for(int j=i+1;j<N;j++)
        {
            if(a[i]>a[j])
            {
                temp=a[i];
                a[i]=a[j];
                a[j]=temp;     
            }
        }
        
    }
    
    return 1;
}