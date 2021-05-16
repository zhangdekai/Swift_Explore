#!/bin/sh

#  shellInput.sh
#  RXSwift_Explore
#
#  Created by zhang dekai on 2021/5/15.
#  Copyright © 2021 mr dk. All rights reserved.


# link: https://www.runoob.com/linux/linux-shell-io-redirections.html

# 将输出重定向到 file  内容会被覆盖
echo "菜鸟教程：www.runoob.com" > users

echo "111菜鸟教程：www.runoob.com" > users

# 如果不希望文件内容被覆盖，可以使用 >> 追加到文件末尾
echo "222菜鸟教程：www.runoob.com" >> users
echo "333菜鸟教程：www.runoob.com" >> users

# 统计 users 文件的行数
wc -l users  # 3 users

wc -l < users # 3

#command 2>users


wc -l << EOF
    欢迎来到
    菜鸟教程
    www.runoob.com
EOF


cat << EOF
欢迎来到
菜鸟教程
www.runoob.com
EOF

# Shell 也可以包含外部脚本。这样可以很方便的封装一些公用的代码作为一个独立的文件。

#使用 . 号来引用shellFileImport.sh 文件
. ./shellFileImport.sh

# 或者使用以下包含文件代码
source ./shellFileImport.sh

echo "shellFileImport file url = ${url}"


#/dev/null 是一个特殊的文件，写入到它的内容都会被丢弃；如果尝试从该文件读取内容，
# 那么什么也读不到。但是 /dev/null 文件非常有用，将命令的输出重定向到它，会起到"禁止输出"的效果。
#

# 注意：0 是标准输入（STDIN），1 是标准输出（STDOUT），2 是标准错误输出（STDERR）。
# 这里的 2 和 > 之间不可以有空格，2> 是一体的时候才表示错误输出。
#command > /dev/null 2>&1
