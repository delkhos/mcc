int global;

int test_32bits(){
  int f;
  int j;
  int c;
  f = fopen("./unittests","r");
  j = 0;
  while((c = fgetc(f)) != (-1) && j< 45000 ){
    j++;
  }
  fclose(f);
  return j;
}

int testing_registers_preservation(int a, int b, int c, int d, int e, int f, int g, int h){
  return a+b+c+d+e+f+g+h;
}

int stack_test_impair(int n){
  int a;
  int b;
  if(n != 4){
    stack_test_pair(n+1);
    printf("    [ stack alignment test%d passed] Passed\n", n);
  }else{
    return 0;
  }
}
int stack_test_pair(int n){
  int a;
  if(n != 4){
    stack_test_impair(n+1);
    printf("    [ stack alignment test%d passed] Passed\n", n);
  }else{
    return 0;
  }
}

int setting_glob(int n){
  global = n;
}

int testing_glob(int n, int number){
  if( global != n){
    printf("    [ global test%d failed with balue : %d] Failed\n",number,global);
    exit(1);
  }else{
    printf("    [ global test%d passed] Passed\n", number);
  }
}

int testing_scope(){
  int global;
  global = 12;
  setting_glob(30);
  testing_glob(30, 1);

  if( global != 12){
    printf("    [ global test2 failed with balue : %d] Failed\n",global);
    exit(1);
  }else{
    printf("    [ global test2 passed] Passed\n");
  }

  {
    int global;
    global = 100;
    testing_glob(30, 3);

    if( global != 100){
      printf("    [ global test4 failed with balue : %d] Failed\n",global);
      exit(1);
    }else{
      printf("    [ global test4 passed] Passed\n");
    }
  }
  if( global != 12){
    printf("    [ global test5 failed with balue : %d] Failed\n",global);
    exit(1);
  }else{
    printf("    [ global test5 passed] Passed\n");
  }

  return 0;
}

int main(){
  int a;
  int b;
  int c;


  // Testing printing
  printf("[Printing Works]\n");

  // Unit testing with constants
  printf("** Unit Testing with constants **\n");

  printf("  {Testing Comparisons}\n");

  if(5 == 7){
    printf("    [== Test1] Failed\n");
    exit(1);
  }else{
    printf("    [== Test1] Passed\n");
  }
  if(13 == 13){
    printf("    [== Test2] Passed\n");
  }else{
    printf("    [== Test2] Failed\n");
    exit(1);
  }


  if(8 < 10){
    printf("    [< Test1] Passed\n");
  }else{
    printf("    [< Test1] Failed\n");
    exit(1);
  }
  if(12 < 10){
    printf("    [< Test2] Failed\n");
    exit(1);
  }else{
    printf("    [< Test2] Passed\n");
  }


  if(8 <= 8){
    printf("    [<= Test1] Passed\n");
  }else{
    printf("    [<= Test1] Failed\n");
    exit(1);
  }
  if(4 <= 12){
    printf("    [<= Test2] Passed\n");
  }else{
    printf("    [<= Test2] Failed\n");
    exit(1);
  }


  printf("  {Testing Binary operators}\n");

  if( 8*7 == 56){
    printf("    [*] Passed\n");
  }else{
    printf("    [*] Failed\n");
    exit(1);
  }
  if(47/5 == 9){
    printf("    [/] Passed\n");
  }else{
    printf("    [/] Failed\n");
    exit(1);
  }
  if(47%5 == 2){
    printf("    [%%] Passed\n");
  }else{
    printf("    [%%] Failed\n");
    exit(1);
  }
  if(102+47 <= 149){
    printf("    [+] Passed\n");
  }else{
    printf("    [+] Failed\n");
    exit(1);
  }
  if(28-13 == 15){
    printf("    [- binary] Passed\n");
  }else{
    printf("    [- binary] Failed\n");
    exit(1);
  }

  // Unit testing with variables
  printf("** Unit Testing with variables **\n");

  printf("  {Testing Comparisons}\n");

  a = 5;
  b = 13;
  c = 7;
  if(a == c){
    printf("    [== Test1] Failed\n");
    exit(1);
  }else{
    printf("    [== Test1] Passed\n");
  }
  c = 13;
  if(b == c){
    printf("    [== Test2] Passed\n");
  }else{
    printf("    [== Test2] Failed\n");
    exit(1);
  }

  a = 8;
  b = 12;
  c = 10;
  if(a < c){
    printf("    [< Test1] Passed\n");
  }else{
    printf("    [< Test1] Failed\n");
    exit(1);
  }
  if(b < c){
    printf("    [< Test2] Failed\n");
    exit(1);
  }else{
    printf("    [< Test2] Passed\n");
  }


  if(a <= 8){
    printf("    [<= Test1] Passed\n");
  }else{
    printf("    [<= Test1] Failed\n");
    exit(1);
  }
  c = 4;
  if(c <= b){
    printf("    [<= Test2] Passed\n");
  }else{
    printf("    [<= Test2] Failed\n");
    exit(1);
  }


  printf("  {Testing Binary operators}\n");

  a = 8;
  b = 7;

  if( a*b == 56){
    printf("    [*] Passed\n");
  }else{
    printf("    [*] Failed\n");
    exit(1);
  }
  a = 47;
  b = 5;
  if(a/b == 9){
    printf("    [/] Passed\n");
  }else{
    printf("    [/] Failed\n");
    exit(1);
  }
  if(a%b == 2){
    printf("    [%%] Passed\n");
  }else{
    printf("    [%%] Failed\n");
    exit(1);
  }
  b = 102;
  if(b+a <= 149){
    printf("    [+] Passed\n");
  }else{
    printf("    [+] Failed\n");
    exit(1);
  }
  a = 28;
  b = 13;
  if(a-b == 15){
    printf("    [- binary] Passed\n");
  }else{
    printf("    [- binary] Failed\n");
    exit(1);
  }


  printf("  {Testing Unary operators}\n");

  a = 33;
  if( -a == -33){
    printf("    [- unary] Passed\n");
  }else{
    printf("    [- unary] Failed\n");
    exit(1);
  }
  a = 0;
  if( ~a == -1){
    printf("    [~] Passed\n");
  }else{
    printf("    [~] Failed\n");
    exit(1);
  }
  a = 5;
  if( a++ == 5){
    printf("    [x++] Passed\n");
  }else{
    printf("    [x++] Failed\n");
    exit(1);
  }
  if( ++a == 7){
    printf("    [++x] Passed\n");
  }else{
    printf("    [++x] Failed\n");
    exit(1);
  }

  a = 13;
  if( a-- == 13){
    printf("    [x--] Passed\n");
  }else{
    printf("    [x--] Failed\n");
    exit(1);
  }
  if( --a == 11){
    printf("    [--x] Passed\n");
  }else{
    printf("    [--x] Failed\n");
    exit(1);
  }



  // Unit testing with arrays
  printf("** Unit Testing with arrays **\n");

  printf("  {Testing Comparisons}\n");

  a = malloc(8*3); // malloc an array on 3 int
  a[0] = 12;
  a[1] = 12;
  a[2] = 7;
  if(a[0] == a[2]){
    printf("    [== Test1] Failed\n");
    exit(1);
  }else{
    printf("    [== Test1] Passed\n");
  }
  if(a[0] == a[1]){
    printf("    [== Test2] Passed\n");
  }else{
    printf("    [== Test2] Failed\n");
    exit(1);
  }

  a[0] = 8;
  a[1] = 12;
  a[2] = 10;
  if(a[0] < a[2]){
    printf("    [< Test1] Passed\n");
  }else{
    printf("    [< Test1] Failed\n");
    exit(1);
  }
  if(a[1] < a[2]){
    printf("    [< Test2] Failed\n");
    exit(1);
  }else{
    printf("    [< Test2] Passed\n");
  }


  if(a[0] <= 8){
    printf("    [<= Test1] Passed\n");
  }else{
    printf("    [<= Test1] Failed\n");
    exit(1);
  }
  a[2] = 4;
  if(a[2] <= a[1]){
    printf("    [<= Test2] Passed\n");
  }else{
    printf("    [<= Test2] Failed\n");
    exit(1);
  }


  printf("  {Testing Binary operators}\n");

  a[0] = 1672;
  a[1] = 8971;
  a[2] = 45;
  if( a[0] == 1672 && a[1] == 8971 && a[2]==45){
    printf("    [ a[i] ] Passed\n");
  }else{
    printf("    [ a[i] ] Failed\n");
    exit(1);
  }

  a[0] = 8;
  a[1] = 7;

  if( a[0]*a[1] == 56){
    printf("    [*] Passed\n");
  }else{
    printf("    [*] Failed\n");
    exit(1);
  }
  a[0] = 47;
  a[1] = 5;
  if(a[0]/a[1] == 9){
    printf("    [/] Passed\n");
  }else{
    printf("    [/] Failed\n");
    exit(1);
  }
  if(a[0]%a[1] == 2){
    printf("    [%%] Passed\n");
  }else{
    printf("    [%%] Failed\n");
    exit(1);
  }
  a[1] = 102;
  if(a[1]+a[0] <= 149){
    printf("    [+] Passed\n");
  }else{
    printf("    [+] Failed\n");
    exit(1);
  }
  a[0] = 28;
  a[1] = 13;
  if(a[0]-a[1] == 15){
    printf("    [- binary] Passed\n");
  }else{
    printf("    [- binary] Failed\n");
    exit(1);
  }


  printf("  {Testing Unary operators}\n");

  a[0] = 33;
  if( -a[0] == -33){
    printf("    [- unary] Passed\n");
  }else{
    printf("    [- unary] Failed\n");
    exit(1);
  }
  a[0] = 0;
  if( ~a[0] == -1){
    printf("    [~] Passed\n");
  }else{
    printf("    [~] Failed\n");
    exit(1);
  }
  a[0] = 5;
  if( a[0]++ == 5){
    printf("    [x++] Passed\n");
  }else{
    printf("    [x++] Failed\n");
    exit(1);
  }
  if( ++a[0] == 7){
    printf("    [++x] Passed\n");
  }else{
    printf("    [++x] Failed\n");
    exit(1);
  }

  a[0] = 13;
  if( a[0]-- == 13){
    printf("    [x--] Passed\n");
  }else{
    printf("    [x--] Failed\n");
    exit(1);
  }
  if( --a[0] == 11){
    printf("    [--x] Passed\n");
  }else{
    printf("    [--x] Failed\n");
    exit(1);
  }


  printf("** Testing variables scope **\n");
  testing_scope();

  printf("** Testing stack 16 alignment **\n");
  stack_test_impair(1);

  printf("** Testing register preservation **\n");
  a = testing_registers_preservation(
      testing_registers_preservation(1, 2, 3, 4, 5, 6, 7, 8),
      testing_registers_preservation(9, 10, 11, 12, 13, 14, 15, 16),
      testing_registers_preservation(17, 18, 19, 20, 21, 22, 23, 24),
      testing_registers_preservation(25, 26, 27, 28, 29, 30, 31, 32),
      testing_registers_preservation(33, 34, 35, 36, 37, 38, 39, 40),
      testing_registers_preservation(41, 42, 43, 44, 45, 46, 47, 48),
      testing_registers_preservation(49, 50, 51, 52, 53, 54, 55, 56),
      testing_registers_preservation(57, 58, 59, 60, 61, 62, 63, 64)
      );

  if( a == (64*65/2) ){
    printf("    [ Register preservation ] Passed\n");
  }else{
    printf("    [ Register preservation ] Failed\n");
    exit(1);
  }

  printf("** Testing 32bits compatibility **\n");
  if( test_32bits() == 45000){
    printf("    [ 32bits compatibility failed ]\n");
    exit(1);
  }else{
    printf("    [ 32bits compatibility passed ]\n");
  }
  
  printf("[** Congratulations ! All unit tests have succeeded **]\n");

  return 0;

}
