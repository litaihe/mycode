#include <iostream>
#include <vector>
#include <ctime>
#include <cstdlib>
// #include "QuickSort.hpp"
// #include "ShellSort.hpp"
// #include "SelectionSort.hpp"
//#include "InsertionSort.hpp"
#include "MergeSort.hpp"
int main(int argc, char *argv[])
{
    const int size = 10;
    std::vector<float> data(size, 0);
    std::vector<float> aux(size,0);
    srand(time(NULL));
    for (auto it = data.begin(); it != data.end(); it++)
    {
        *it = rand() % 1000;
        std::cout << *it << " ";
    }
    std::cout << std::endl;

    // SelectionSort1<float>(data.data(),data.size());
    // InsertionSort<float>(data.data(),data.size());
    // QuickSort<float>(data.data(),0,data.size()-1);
    // ShellSort(data.data(),data.size());
    MergeSort<float>(data.data(), aux.data(), 0, data.size() - 1);
    for (auto it = data.begin(); it != data.end(); it++)
    {
        std::cout << *it << " ";
    }

    std::cout << std::endl;

    return 0;
}