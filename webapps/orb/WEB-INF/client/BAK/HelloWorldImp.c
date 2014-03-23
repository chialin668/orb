#include <jni.h>
#include "HelloWorld.h"
#include <stdio.h>

JNIEXPORT void JNICALL 
Java_HelloWorld_displayHelloWorld(JNIEnv *env, jobject obj, jstring prompt)
{
  const char *str = (*env)->GetStringUTFChars(env, prompt, 0);
  printf("%s", str);
  (*env)->ReleaseStringUTFChars(env, prompt, str);

}


