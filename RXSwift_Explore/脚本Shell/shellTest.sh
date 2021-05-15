#!/bin/sh

#  shellTest.sh
#  RXSwift_Explore
#
#  Created by zhang dekai on 2021/5/15.
#  Copyright © 2021 mr dk. All rights reserved.
# shell test 命令 链接：https://www.runoob.com/linux/linux-shell-test.html

# Shell中的 test 命令用于检查某个条件是否成立，它可以进行数值、字符和文件三个方面的测试。


# 数值测试
num1=100
num2=100

#if test $[num1] -eq $[num2]
if test $num1 -eq $num2
then
    echo '两个数相等！'
else
    echo '两个数不相等！'
fi


a=5
b=6

result=$[a+b] # 注意等号两边不能有空格
echo "result 为： $result"


# 字符串测试

num1="ru1noob"
num2="runoob"
if test $num1 = $num2
then
    echo '两个字符串相等!'
else
    echo '两个字符串不相等!'
fi

# 文件测试

cd /bin
if test -e ./bash
then
    echo '文件已存在!'
else
    echo '文件不存在!'
fi


cd /bin
if test -e ./notFile -o -e ./bash
then
    echo '至少有一个文件存在!'
else
    echo '两个文件都不存在'
fi
