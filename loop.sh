#!/bin/bash
ARRAY=(stdrsv1121 stdrsv1122)
echo -n "Password: "
read pass

for item in ${ARRAY[@]}; do
    expect -c "
    spawn ssh -l $USER $item who
    expect \"Please select one (cancel, once, *\" 
	send \"once\n\"
	expect -regexp \"Password*\"
	send \"$pass\n\"
	expect -regexp \"Authentication successful*\"
	log_file log
	spawn echo $HOST
	expect \"{$USER}*\"
	log_file
	" 
done

cat log | awk '{ print $1 }' > log_awk.txt

