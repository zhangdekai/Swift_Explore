#!/bin/sh

#  shellIfElse.sh
#  RXSwift_Explore
#
#  Created by zhang dekai on 2021/5/15.
#  Copyright © 2021 mr dk. All rights reserved.

# link: https://www.runoob.com/linux/linux-shell-process-control.html

:<<EOF

if 语句格式

1：
if condition
then
    command1
    command2
    ...
    commandN
fi

2：
if condition
then
    command1
    command2
    ...
    commandN
else
    command
fi

EOF


if [ $(ps -ef | grep -c "ssh") -gt 1 ]; then echo "true\n"; fi


a=10
b=20
if [ $a == $b ]
then
   echo "a 等于 b"
elif [ $a -gt $b ]
then
   echo "a 大于 b"
elif [ $a -lt $b ]
then
   echo "a 小于 b"
else
   echo "没有符合的条件"
fi


num1=$[2*3]
num2=$[1+5]
if test $[num1] -eq $[num2]
then
    echo '两个数字相等!'
else
    echo '两个数字不相等!'
fi


:<<EOF

for var in item1 item2 ... itemN
do
    command1
    command2
    ...
    commandN
done

EOF

# 写成一行：
#for var in item1 item2 ... itemN; do command1; command2… done;


for loop in 1 2 3 4 5
do
    echo "The value is: $loop"
done


for str in This is a string
do
    echo $str
done

# while test
:<<EOF

while condition
do
    command
done

EOF

function whileTest() {

    printf "while loop\n"
    int=1
    while(( $int<=5 ))
    do
        echo $int
        let "int++" #使用了 Bash let 命令，它用于执行一个或多个表达式
    done
}

whileTest


function untilTest() {

    echo '按下 <CTRL-D> 退出'
    echo -n '输入你最喜欢的网站名: '
    while read FILM
    do
        echo "是的！$FILM 是一个好网站"
    done
}

#无限循环  for (( ; ; ))
#while true
#do
#    command
#done

#until
a=0

until [ ! $a -lt 10 ]
do
   echo $a
   a=`expr $a + 1`
done


function caseTest() {

    echo '输入 1 到 4 之间的数字:'
    echo '你输入的数字为:'
    read aNum   # 输入数字
    case $aNum in
        1)  echo '你选择了 1'
        ;;
        2)  echo '你选择了 2'
        ;;
        3)  echo '你选择了 3'
        ;;
        4)  echo '你选择了 4'
        ;;
        *)  echo '你没有输入 1 到 4 之间的数字'
        ;;
    esac
    
    
    site="runoob"

    case "$site" in
       "runoob") echo "菜鸟教程"
       ;;
       "google") echo "Google 搜索"
       ;;
       "taobao") echo "淘宝网"
       ;;
    esac
}


#caseTest

# break和continue 跳出循环

function breakTest(){
    while :
    do
        echo -n "输入 1 到 5 之间的数字:"
        read aNum
        case $aNum in
            1|2|3|4|5) echo "你输入的数字为 $aNum!"
            ;;
            *) echo "你输入的数字不是 1 到 5 之间的! \n游戏结束"
                break
            ;;
        esac
    done
    
    
    while :
    do
        echo -n "输入 1 到 5 之间的数字: "
        read aNum
        case $aNum in
            1|2|3|4|5) echo "你输入的数字为 $aNum!"
            ;;
            *) echo "你输入的数字不是 1 到 5 之间的!"
                continue  #游戏不会结束呢
                echo "游戏结束"
            ;;
        esac
    done
}

breakTest



