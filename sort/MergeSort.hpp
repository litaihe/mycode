#pragma once

#include <cstring>
#include <cstdlib>

template <typename T>
void MergeSort(T *a,T *aux, int low, int high)
{
    if(high <=low) 
    {
        return ;
    }
    int mid=low+(high-low)/2;
    MergeSort(a, aux, low,mid);//将左边排序
    MergeSort(a,aux, mid+1,high);//将右边排序

    int i = low,j=mid+1;
    memcpy(aux+low,a+low,sizeof(T)*(high-low+1));
    
    for(int k=low; k<=high; k++)
    {
        if(i>mid)
        {
            a[k]=aux[j++];
        }
        else if(j>high)
        {
            a[k]=aux[i++];
        }
        else if(aux[j]<aux[i])
        {
            a[k]=aux[j++];
        }
        else
        {
            a[k]=aux[i++];
        }
 
    }
}