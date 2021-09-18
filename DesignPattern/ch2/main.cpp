//大话设计模式，商场收银系统
//策略模式
#include <iostream>
#include <string>

class Strategy
{
public:
    // virtual void AlogrithmInterface() = 0;
     virtual void AlogrithmInterface();

};

class ConcreteStrategyA : public Strategy
{

 
public:
   int i;
    virtual void AlogrithmInterface()
    {
        std::cout << "算法A实现" << std::endl;
    }
};

class ConcreteStrategyB : public Strategy
{
public:
    virtual void AlogrithmInterface()
    {
        std::cout << "算法B实现" << std::endl;
    }
};

class ConcreteStrategyC : public Strategy
{
public:
    virtual void AlogrithmInterface()
    {
        std::cout << "算法C实现" << std::endl;
    }
};

class Context
{
    private:
        Strategy *pStrategy;
    public:
        
        Context(Strategy *pStrategy)
        {
            this->pStrategy =pStrategy;
        }

        void ContextInterface()
        {
            pStrategy->AlogrithmInterface();
        }
};


int main(int argc, char *argv[])
{

    Context* pContext;
    Strategy* pStrategy;
    // shared_ptr <Context> pContext;
    // shared_ptr <Strategy> pStrategy;
    ConcreteStrategyA concreteStrategyA;
    // pStrategy=new  ConcreteStrategyA;

    // pContext=new Context( pStrategy );
    // pContext->ContextInterface();

    // pStrategy=new  ConcreteStrategyB;
    // pContext=new Context( pStrategy );
    // pContext->ContextInterface();
    

    // pStrategy=new  ConcreteStrategyC;
    // pContext=new Context( pStrategy );
    // pContext->ContextInterface();
    
    return 0;

}