#pragma once

template<typename T>
void QuickSort(T*a, int low, int high)
{

    if(high <=low)
    {
        return ;
    }
    
    //partition
    int i=low,j=high+1;
    T v=a[low];
    T temp;
    while(true)
    {
        while(a[++i]<v)
        {
            if(i==high)
            {
                break;
            }
        }
        while(v<a[--j])
        {
            if(j==low)
            {
                break;
            }
        }
        if(i>=j)
        {
            break;
        }
        temp=a[i];
        a[i]=a[j];
        a[j]=temp;
    }
    temp=a[low];
    a[low]=a[j];
    a[j]=temp;
    
    // int j = partition(a, low, high);
    QuickSort(a, low , j-1);
    QuickSort(a, j+1, high);     
}