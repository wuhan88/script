#!/bin/bash
#####################################################
# Author: Jason Wu - jasonwux@gmail.com
# Last modified:	2010-12-31 12:31
# Filename:	vmrun.sh
#管理vmware server虚拟机
#####################################################



####Server
VM_RUN='vmrun -T server -h https://192.168.10.50:8333/sdk -u'
TD='Win2000_TD/Win2000_TD.vmx'
BREW='WinXP_Brew/WinXP.vmx'
MTK='WinXP_MTK_xmw/WinXP.vmx'
PPC='WinXP_PPC/WinXP.vmx'
S60='WinXP_S60/WinXP.vmx'
SP='WinXP_SP/WinXP.vmx'
QA='WinXP_QA/WinXP.vmx'
VM='[BuilderVM]'
LINUX='CMCC1.1/CMCC1.1.vmx'
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
LINUX|linux)
        SERVER=`echo $LINUX`
        VM='[standard]' ;;
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
        status='Stop  ...'
        else
        status='Running...'
        fi
}
clear
echo ""
echo "	************Execute Scripts Format************"
echo "	*SERVICE SPACE STATUS                        *"
echo "	*            Such As:  brew stop | BREW stop *"
echo "	**********************************************"
echo "	       Service	  	Status: start/stop  "
echo "	----------------------------------------------"
funcstatus $BREW
echo "		BREW|brew	-Status: $status"
funcstatus $SP
echo "		SP|sp		-Status: $status"
funcstatus $QA
echo "		QA|qa		-Status: $status"
funcstatus $PPC
echo "		PPC|ppc		-Status: $status"
funcstatus $S60
echo "		S60|s60		-Status: $status"
funcstatus $TD
echo "		TD|td		-Status: $status"
funcstatus $MTK
echo "		MTK|mtk		-Status: $status"
funcstatus $LINUX
echo "		LINUX|linux	-Status: $status"
echo "	+ ───────────────────── +"
echo "		Quit or Any key        		    "
echo ""
echo "	请输入VMWARE WEB登录用户名及密码"
echo -n "	用户名:"
read ADMIN  
echo -n "	密  码:"
#此处可以用read -s Var代替（不可以移植）
stty -echo
read PASSWORD
stty echo
echo " "
echo "	Service space status / 服务 状态"
echo "	Such As:brew stop|BREW stop"
echo -n "	"&& read SERVER VM_Status
judge
$VM_RUN $ADMIN -p $PASSWORD $VM_Status "$VM $SERVER"
echo -n "	"&&progress

