# Shell Script (count.sh)
#!/bin/bash
sum=0
for ((i=1; i<=10000000; i++))
do
    ((sum+=i))
done
echo $sum

# C Program (count.c)
#include <stdio.h>

int main() {
    long long sum = 0;
    for (int i = 1; i <= 10000000; i++) {
        sum += i;
    }
    printf("%lld\n", sum);
    return 0;
}

# Odin Program (count.odin)
package main

import "core:fmt"

main :: proc() {
    sum: i64 = 0
    for i in 1..=10_000_000 {
        sum += i64(i)
    }
    fmt.println(sum)
}
