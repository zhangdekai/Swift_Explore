#!/bin/sh
# 第一行 "#!" 是一个约定的标记，它告诉系统这个脚本需要什么解释器来执行，即使用哪一种 Shell。
#  TestShell.sh
#  Runner
#
#  Created by zhang dekai on 2021/5/14.

# 大段注释
:<<’

‘ 可以为EOF

教程链接：https://www.runoob.com/linux/linux-shell.html

 chmod +x ./TestShell.sh  开启sh执行权限
 
 ./TestShell.sh  #执行脚本

  /bin/sh test.sh  And /bin/php test.php : 直接运行解释器, 不需要在第一行指定解释器信息
’

echo 'echo is print. hello shell world ###################################11'  # 打印

# 变量 PS：不能有空格 不能是bash 里的关键字；无标点符号；
# 变量类型 局部变量 环境变量 shell变量
yourName='cat'
your_age='20'
your_address1="jinan + \"$yourName"!\" # 双引号可以添加变量+转义字符
_your2_address="beijing + ${your_age}"
readonly yourEmail='664939067@qq.com'


echo ${yourName} 年龄是 ${your_age} 1地址是 $your_address1 2地址is $_your2_address
# yourEmail='7484y7'  #line 26: yourEmail: readonly variable
echo yourEmail = $yourEmail

echo '修改变量'
_your2_address='huang_he'
echo _your2_address=$_your2_address

# 删除变量，不可删只读变量
unset _your2_address

# 获取字符串长度
echo yourEmail len = ${#yourEmail}

#字符串截取
echo 截取 String = ${yourEmail:1:5} # 截取 String = 64939

#查找字符串失败了呢？？？
string="runoob is a great site"
#echo `expr index "$string" io`  # 输出 4

#数组 只支持 一维数组
array_name=(value0 3345 value2 value3 7366 477384)
array_name1=(
value0
value1
value2
value3
)

array_name[0]=1123

number1=${array_name[0]}

# 打印数组元素
echo ${array_name[1]}  number1=$number1

#数组长度
echo array len = ${#array_name[*]}  array1 len=${#array_name[1]}
echo "数组的元素为: ${array_name[*]}"
echo "数组的元素为: ${array_name1[@]}"


echo "Shell 传递参数实例！";
echo "执行的文件名：$0";
echo "第一个参数为：$1"
echo "第二个参数为：$2"
echo "第三个参数为：$3"
echo "第四个参数为：$4";
echo "参数们是 $#个 是 $*"
echo 脚本运行的当前进程ID号是 $$
echo 后台运行的最后一个进程的ID号 $!
echo "参数们是 $#个 是 $@"

echo 加油

# * 与 @ 的区别  " * " 等价于 "1 2 3"（传递了一个参数），而 "@" 等价于 "1" "2" "3"（传递了三个参数）。
echo "-- \$* 演示 ---"
for i in "$*"; do
    echo $i
done

echo "-- \$@ 演示 ---"
for i in "$@"; do
    echo $i
done

for j in $*; do
    echo $j
done

#  数字运算 expr ESC 按键下边 `expr 2 + 2`
echo 数字运算
val=`expr 2 + 2` #空格
echo "两数之和为 : $val"

echo '循环执行 for in ; do done'
for ele in Cat dog house bed; do

    echo "院子里有 ${ele}" #推荐给变量加 {}

done





