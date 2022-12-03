#include<stdio.h>
#include"Hello.h"
#include"welcome.h"

/*
 * Class:     Hello
 * Method:    call
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_Hello_call
  (JNIEnv * env, jobject obj) {
  printf("hello, demo!\n");
  welcome(); //welcome.a
}
