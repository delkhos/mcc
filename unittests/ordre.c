int test_ordre_args(int a , int b, int c){
  int i;
  i = a+b+c;
  return (i=3)*i+b;
}

int main(){
  int a;
  int b;
  int c;
  int res;

  a=67;
  b=91;

  res = test_ordre_args( c=a , ++c, c=b);
  printf("c=%d\n",c);
  printf("res=%d\n", res);

  return 0;
}
