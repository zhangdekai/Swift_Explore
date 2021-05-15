#!/bin/sh

#  pushCode.sh
#  RXSwift_Explore
#
#  Created by zhang dekai on 2021/5/15.
#  Copyright © 2021 mr dk. All rights reserved.

echo push code to remote

parmMsg=$1

function push() {

    git add .
    
    echo "commit msg = $parmMsg"
    
    git commit -m"${parmMsg}"
    
    echo begin push

    git push .
    
    if [ "$?" != '0' ]
    then
        echo "push failed"
        exit
    fi

}

push
