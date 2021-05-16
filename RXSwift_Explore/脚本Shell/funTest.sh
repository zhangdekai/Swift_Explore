#!/bin/sh

#  funTest.sh
#  RXSwift_Explore
#
#  Created by zhang dekai on 2021/5/15.
#  Copyright © 2021 mr dk. All rights reserved.


#函数 link:https://www.runoob.com/linux/linux-shell-func.html
demoFun(){
    echo "这是我的第一个 shell 函数!\n"
}

demoFun

funWithReturn(){
    echo "这个函数会对输入的两个数字进行相加运算..."
    echo "输入第一个数字: "
    read aNum
    echo "输入第二个数字: "
    read anotherNum
    echo "两个数字分别为 $aNum 和 $anotherNum !"
    return $(($aNum+$anotherNum)) #计算值
}
funWithReturn
# 函数返回值在调用该函数后通过 $? 来获得。
echo "输入的两个数字之和为 $? !\n"  #获取函数结果值

# 参数函数
# 注意，$10 不能获取第十个参数，获取第十个参数需要${10}。当n>=10时，需要使用${n}来获取参数
funWithParam(){
    echo "第一个参数为 $1 !"
    echo "第二个参数为 $2 !"
    echo "第十个参数为 $10 !"
    echo "第十个参数为 ${10} !"
    echo "第十一个参数为 ${11} !"
    echo "参数总数有 $# 个!"
    echo "作为一个字符串输出所有参数 $* !"
}
funWithParam 1 2 3 4 5 6 7 8 9 34 73


