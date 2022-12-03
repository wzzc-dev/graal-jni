import java.lang.String;
import java.lang.System;

public class Hello{
  public native void call(); // native方法

  public static void main(String[] args) { //Java入口
    System.out.println("java in...");
    new Hello().call();
    System.out.println("java out..");
  }
  static {
    System.loadLibrary("demo"); //加载libdemo.so
  }
}
