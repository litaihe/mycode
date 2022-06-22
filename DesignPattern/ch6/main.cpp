//大话设计模式
//装饰模式
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
        this->pComponent = pComponent;
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
            Decorator::Operation();
            addedState = "New State";
            std::cout << "具体装饰对象A的操作" << std::endl;
        }
};

class ConcreteDecoratorB :public Decorator
{
    private:
        std::string addedState;
        void AddedBehavior()
        {
            std::cout << "B私有操作"<< std::endl;

        }
    public:
        void Operation() override
        {
            Decorator::Operation();
            AddedBehavior();
            std::cout << "具体装饰对象B的操作" << std::endl;
        }
};

int main(int argc, char *argv[])
{
    ConcreteComponent *pC=new ConcreteComponent();
    ConcreteDecoratorA *pA = new ConcreteDecoratorA();
    ConcreteDecoratorB *pB = new ConcreteDecoratorB();

    pA->SetComponent(pC);
    pB->SetComponent(pA);
    pB->Operation();

    return 0;
}
