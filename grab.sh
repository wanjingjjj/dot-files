#!/usr/bin/bash
sx=30
sy=30
for window in $(xdotool search --onlyvisible -name .)
do
   ignore_flag=`xdotool getwindowname $window|grep 'WebKitWebProcess'|wc -l`
   if (( $ignore_flag > 0 ))
   then
       continue
   fi
   echo "show `xdotool getwindowname $window` "
   xdotool windowmove $window $sx $sy
   xdotool windowunmap $window
   xdotool windowmap $window
   sx=$(($sx + 40))
   sy=$(($sy + 40))
done
