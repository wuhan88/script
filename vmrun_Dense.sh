#!/bin/bash
#####################################################
# Author: Jason Wu - jasonwux@gmail.com
# Last modified:	2010-12-31 12:31
# Filename:	vmrun.sh
#管理vmware server虚拟机
#####################################################

####Server
VM_RUN='vmrun -T server -h https://192.168.10.50:8333/sdk -u root -p w1nks1.c0m'
TD='Win2000_TD/Win2000_TD.vmx'
BREW='WinXP_Brew/WinXP.vmx'
MTK='WinXP_MTK_xmw/WinXP.vmx'
PPC='WinXP_PPC/WinXP.vmx'
S60='WinXP_S60/WinXP.vmx'
SP='WinXP_SP/WinXP.vmx'
QA='WinXP_QA/WinXP.vmx'
VM='[BuilderVM]'
ANDROID='WinXP_Android/WinXP.vmx'
#progress bar
progress(){
i=0
while [ $i -lt 20 ]
do
       ((i++))
       echo -ne "=>\033[s"
       echo -ne "\033[40;50"$((i*5*100/100))%"\033[u\033[1D"
   usleep 50000
done
echo
}

#judge Server key
judge(){
case $SERVER in
BREW|brew)
	SERVER=`echo $BREW` ;;
SP|sp)
	SERVER=`echo $SP`  ;;
QA|qa)
	SERVER=`echo $QA` ;;
MTK|mtk) 
	SERVER=`echo $MTK` ;;
PPC|ppc)
	SERVER=`echo $PPC` ;;
S60|s60)
	SERVER=`echo $S60` ;;
TD|td)
	SERVER=`echo $TD` ;;
ANDROID|android)
	SERVER=`echo $ANDROID`;;
exit|EXIT)
	exit ;;
*)
#echo "Please Input then name of Service and Status: "
exit
;;
esac
}


#Server status
funcstatus(){
        ps_ef=`ps -ef |grep $1|grep -v grep |wc -l`
        if [ ${ps_ef} == 0 ]
        then
        status='Stop   ...'
        else
        status='Running...'
        fi
}


clear
echo ""
echo "  ************Execute Scripts Format************"
echo "   SERVICE SPACE STATUS                         "
echo "               Such As:  brew stop | BREW STOP"
echo "  **********************************************"
echo "          Service          Status: start/stop  "
funcstatus $BREW
echo "          BREW| brew         -Status: $status"
funcstatus $SP
echo "          SP  | sp           -Status: $status"
funcstatus $QA
echo "          QA  | qa           -Status: $status"
funcstatus $PPC
echo "          PPC | ppc          -Status: $status"
funcstatus $S60
echo "          S60 | s60          -Status: $status"
funcstatus $TD
echo "          TD  | td           -Status: $status"
funcstatus $MTK
echo "          MTK | mtk          -Status: $status"
funcstatus $ANDROID
echo "          ANDROID | android	-Status: $status"

echo "  **********************************************"
echo "          Quit or Any key     		      "

echo " "
echo "	Service space status"
echo "	Such As:brew stop|BREW stop"
echo -n "	"&& read SERVER VM_Status
judge
$VM_RUN $VM_Status "$VM $SERVER"
echo -n "	"&&progress

