//大话设计模式，计算器程序
//简单工厂模式
#include <iostream>
#include <string>

class Component
{
public:
    virtual void Operation() = 0;
};
class ConcreteComponent : public Component
{
public:
    void Operation() override
    {
        std::cout << "具体对象的操作" << std::endl;
    }
};

class Decorator : public Component
{
protected:
    Component *pComponent;

public:
    void SetComponent(Component *pComponent)
    {
        this.pComponent = pComponent;
    }
    void Operation() override
    {
        if (pComponent != nullptr)
        {
            pComponent->Operation();
        }
    }
};

class ConcreteDecoratorA :public Decorator
{
    private:
        std::string addedState;
    public:
        void Operation() override
        {
              
        }


        
}

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