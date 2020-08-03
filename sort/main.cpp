#include <iostream>
#include <vector>
#include <ctime>
#include <cstdlib>
#include "QuickSort.hpp"
// #include "SelectionSort.hpp"
//#include "InsertionSort.hpp"
int main(int argc, char *argv[])
{
    const int size=5;
    std::vector <float> data={24,1,69,11,45};
    srand(time(NULL));
    for(auto it=data.begin();it!=data.end();it++)
    {
        // *it=rand()%100;
        std::cout<<*it<<" ";
    }
    std::cout<<std::endl;
    
    //SelectionSort1<float>(data.data(),size);
    // InsertionSort<float>(data.data(),size);
    QuickSort<float>(data.data(),0,size-1);

    for(auto it=data.begin();it!=data.end();it++)
    {
        std::cout<<*it<<" ";
    }

    std::cout<<std::endl;

    return 0;
}