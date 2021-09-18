//大话设计模式，计算器程序
//简单工厂模式
#include <iostream>
#include <string>

class Operation
{

private:
    double _numberA;
    double _numberB;

public:
    double getNumberA() const { return _numberA; };
    void setNumberA(double value) { _numberA = value; }
    double getNumberB() const { return _numberB; };
    void setNumberB(double value) { _numberB = value; }

    virtual double GetResult() const = 0;
};
class OperationAdd : public Operation
{
    double GetResult() const
    {
        double result = getNumberA() + getNumberB();
        return result;
    }

};
class OperationSub : public Operation
{
    double GetResult() const
    {
        double result = getNumberA() - getNumberB();
        return result;
    }

};

class OperationMul : public Operation
{
    double GetResult() const
    {
        double result = getNumberA() * getNumberB();
        return result;
    }
};

class OperationDiv : public Operation
{
    double GetResult() const
    {
        double result = getNumberA() / getNumberB();
        return result;
    }

};

class OperationFactory
{
public:
    static Operation *CreateOperate(std::string operate)
    {
        Operation *pOper = nullptr;
        if (operate == "+")
        {
            pOper = new OperationAdd[1];
        }
        else if (operate == "-")
        {
            pOper = new OperationSub[1];
        }
        else if (operate == "*")
        {
            pOper = new OperationMul[1];
        }
        else if (operate == "/")
        {
            pOper = new OperationDiv[1];
        }
        else
        {
            std::string err("Error: operate is error!");
            throw err;
            // return nullptr;
        }
        return pOper;
    }
    static void DestroyOperate(Operation *pOper)
    {
        if (nullptr == pOper)
        {
            delete[] pOper;
            pOper = nullptr;
        }
    }
};

int main(int argc, char *argv[])
{

    Operation *pOper = nullptr;
    std::string strOper = "/";

    try
    {
        pOper = OperationFactory::CreateOperate(strOper);
    }
    catch (std::string e)
    {
        std::cerr << e << std::endl;
    }

    pOper->setNumberA(20.0);
    pOper->setNumberB(10.0);
    // pOper->show();
    double result = pOper->GetResult();
    std::cout << pOper->getNumberA() << strOper << pOper->getNumberB() << "=" << pOper->GetResult() << std::endl;

    OperationFactory::DestroyOperate(pOper);

    return 0;
}