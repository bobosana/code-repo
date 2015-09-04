#!/bin/ksh
#===========================================
# Script: export_wf_list.ksh
# Author: Bobosana Naorem
# Date	: 4th September 2015
# Info	: The script exports list of workflows specified in the workflow list file.
# Usage : export_wf_list.ksh <Domain Name> <Repository Name> <Folder Name> <Workflow list file>
# 
# Note	: Change the INFA_HOME, PM_HOME according to the file structure of your Informatica Server. 
# *****************IMPORTANT**********************
# **  THE AUTHOR IS NOT RESPONSIBLE FOR ANY     **
# **  ISSUE/DAMAGE CAUSED. USE AT YOUR OWN RISK **
# ************************************************

export INFA_HOME=/path/to/your/infa/home
export PM_HOME=/path/to/your/PM/home
export PATH=$PATH:$INFA_HOME/server/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INFA_HOME/server/bin

OUTPUT_DIR=/your/xml/output/path
DOMAIN_NAME=$1
REPO_NAME=$2
FOLDER_NAME=$3
LIST_FILE=$4

echo $INFA_HOME
echo $PM_HOME
echo $FOLDER_NAME
echo $LIST_FILE
echo "Enter your PowerCenter user name:"
read USERN
echo "Enter your PowerCenter password:"
stty -echo
read PASSWD
stty echo
for FILE in `cat ${LIST_FILE}`
do
echo "==================================================="
echo "Starting export for: ${FILE}"
echo "==================================================="
pmrep <<EOF
connect -n ${USERN} -d ${DOMAIN_NAME} -r ${REPO_NAME} -s EDW_USER_DOMAINE -x ${PASSWD}
objectexport -n ${FILE} -o workflow -f ${FOLDER_NAME} -m -s -b -r -u /${OUTPUT_DIR}/${FILE}_pmrep.xml
exit
EOF

echo "==================================================="
echo "End export for: ${FILE}"
echo "==================================================="
done
echo
