#!/bin/sh

#  pushCode.sh
#  RXSwift_Explore
#
#  Created by zhang dekai on 2021/5/15.
#  Copyright © 2021 mr dk. All rights reserved.

echo push code to remote

parmMsg=$1
pushSuccess=0
pushCount=1

function pushAgain() {

    while(( $pushCount<=5 && pushSuccess==0 ))
    do
        echo push again $pushCount 次
        
        git push
        
        if [ "$?" == '0' ]
        then
            echo "push success!\n"
            pushSuccess=1
            exit
        else
            pushCount+=1
        fi
    done
    
}

function push() {

    git add .
    
    echo "commit msg = $parmMsg \n"
    
    git commit -m"${parmMsg}"
    
    echo begin push

    git push
    
    if [ "$?" != '0' ]
    then
        echo "push failed!\n"
        pushSuccess=0
        pushAgain
    else
        echo "push success!\n"
        exit
    fi
}



push
