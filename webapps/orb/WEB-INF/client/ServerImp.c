#include <jni.h>
#include "Server.h"
#include <stdio.h>

JNIEXPORT jstring JNICALL 
Java_Server_displayServer(JNIEnv *env, jobject obj, jstring prompt)
{
 char buf[128];

  const char *str = (*env)->GetStringUTFChars(env, prompt, 0);
  
  printf("%s\n", str);

  (*env)->ReleaseStringUTFChars(env, prompt, str);

  strcpy(buf, "from client");
  return (*env)->NewStringUTF(env, buf);


}


