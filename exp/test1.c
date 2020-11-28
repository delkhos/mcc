int test( int intri() ){
  return 3;
}

int glob1;
int glob2;


int test(){
  return 6;
}

int main(){
  int a;
  int b;
  {
    int a;
    a=b;
  }
  a=13;
  return a;
}
