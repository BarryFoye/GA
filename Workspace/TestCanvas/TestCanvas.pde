class Test2{
  int j = 1000;
  Test test;
  
  void test(){
    test = new Test();
    println("__________________________________________");
    println("****Before****\ttest().i: " + test.i);
    test2(test);
    println("****After****\ttest().i: " + test.i);
  }
  
  void test2(Test t2){
    t2.i = j;
    println("t2.i: " + t2.i);
  }
}

class Test{
  int i = 0;
  
  
}
Test2 test2;


void setup() {
  size(100, 100);
  smooth(2);
  noStroke();
  test2 = new Test2();
}

void draw() {
  test2.test();
  background(0);
  ellipse(30, 48, 36, 36);
  ellipse(70, 48, 36, 36);
}
