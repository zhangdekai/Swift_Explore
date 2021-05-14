#!/bin/sh
# 第一行 "#!" 是一个约定的标记，它告诉系统这个脚本需要什么解释器来执行，即使用哪一种 Shell。
#  TestShell.sh
#  Runner
#
#  Created by zhang dekai on 2021/5/14.
#  
# chmod +x ./TestShell.sh  开启sh执行权限
# ./TestShell.sh  #执行脚本
#
#  /bin/sh test.sh  And /bin/php test.php : 直接运行解释器, 不需要在第一行指定解释器信息
#
#

echo 'echo is print. hello shell world'  # 打印

# 变量 PS：不能有空格 不能是bash 里的关键字；无标点符号；
yourName='cat'
your_age='20'
your_address1='jinan'
_your2_address='beijing'
readonly yourEmail='664939067@qq.com'


echo ${yourName} 年龄是 ${your_age} 1地址是 $your_address1 2地址is $_your2_address
# yourEmail='7484y7'  #line 26: yourEmail: readonly variable
echo yourEmail = $yourEmail

echo '修改变量'
_your2_address='huang_he'
echo _your2_address=$_your2_address

unset _your2_address # 删除变量，不可删只读变量

echo '循环执行 for in ; do done'
for ele in Cat dog house bed; do

    echo "院子里有 ${ele}" #推荐给变量加 {}

done





