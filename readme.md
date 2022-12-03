# welcome.c

```
#include<stdio.h>
#include"welcome.h"

void welcome()
{
    printf("welcome, this is static library\n");
}
```

# 库

```
libwelcome.a
```

获取方式 `make compile-lib`

# jvm

`make run-jar`

# native

```shell
make compile-native 
make run-native
```