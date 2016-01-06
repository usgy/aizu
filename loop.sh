#!/bin/bash
ARRAY=(stdrsv1121)
echo -n "id: "
read id
echo -n "Password: "
read pass

for item in ${ARRAY[@]}; do
    expect -c "
    spawn ssh -l $id $item who
    expect \"Please select one (cancel, once, *\" 
	send \"once\n\"
	expect \"Password*\"
	send \"$pass\n\"
	expect \"{s1220135}*\"
	"
done
