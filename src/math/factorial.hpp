#ifndef FACTORIAL_HPP
#define FACTORIAL_HPP

int factorial(int n) {
  return (n == 1 ? n : n * factorial(n-1));
}

int double_factorial(int n) {
  if (n == 1 ||  n == 2)
    return n;
  else 
    return n * double_factorial(n-2);
}


#endif
