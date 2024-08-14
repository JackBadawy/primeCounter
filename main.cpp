#include <iostream>
#include <cmath>
#include <stdexcept>
#include <fstream>
#include <vector>

#define RUN_TESTS

bool isPrime(int numToCheck)
{
    if (numToCheck <= 1) return false;
    int sqrtNum = std::sqrt(numToCheck);
    for (int i = 2; i <= sqrtNum; ++i)
    {
        if (numToCheck % i == 0) return false;
    }
    return true;
}

int countPrimes(int upTo)
{
    int count = 0;
    if (upTo < 2)
    {
        throw std::invalid_argument("Number must be greater than 1 to count primes.");
    }
    for (int i = 2; i <= upTo; ++i)
    {
        if (isPrime(i)) ++count;
    }
    return count;
}

std::vector<int> writePrimes(int upTo)
{
    std::vector<int> primes;
    if (upTo < 2)
    {
        throw std::invalid_argument("Number must be greater than 1 to get primes");
    }
    for (int i = 2; i <= upTo; ++i)
    {
        if (isPrime(i))
        {
            primes.push_back(i);
        }
    }
    return primes;
}

void generateTxtFile(const std::vector<int>& primes)
{
std::ofstream outFile("prime_numbers.txt");
for (int prime : primes)
    {
        outFile << prime << "\n";
    }
outFile.close();
std::cout << "Primes saved to prime_numbers.txt" << std::endl;
}



#ifdef RUN_TESTS
void testFunctions()
{
    if (isPrime(3) != true) std::cout << "Test Failed: isPrime(3)" << std::endl;
    if (countPrimes(10) != 4) std::cout << "Test Failed: countPrimes(10)" << std::endl;
    try
    {
        countPrimes(1);
        std::cout << "Test Failed: Exception not thrown for countPrimes(1)" << std::endl;
    }
    catch (const std::invalid_argument&) {}
    std::cout << "all Tests completed" << std::endl;
}
#endif

int main()
{
    #ifdef RUN_TESTS
    testFunctions();
    #endif

    int userInput;
    char saveInput;
    std::cout << "Enter a number to find the count of primes up to that number: ";
    std::cin >> userInput;

    try
    {
        int countOfPrimes = countPrimes(userInput);
        std::cout << "Primes count up to " << userInput << ": " << countOfPrimes << std::endl;

        std::cout << "Would you like to save a txt file containing each prime number counted? y/n";
        std::cin >> saveInput;

        if (saveInput == 'y' || saveInput == 'y')
        {
            std::vector<int> primes = writePrimes(userInput);
            generateTxtFile(primes);k
        }
    }
    catch (const std::invalid_argument& e)
    {
        std::cout << "Error: " << e.what() << std::endl;
    }


    return 0;
}
