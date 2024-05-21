#!/bin/bash



    echo "--------------------------"
    echo "Bash_scrypt by Andrey S."
    echo "--------------------------"
    echo "Menu:"
    echo "1 : Net. Inf."
    echo "2 : Create new User"
    echo "3 : Weather"
    echo "4 : Disck clean"
    echo "5 : File sort by size"
    echo "6 : Del empty folders"
    echo "7 : File permissions/rename"
    echo "8 : Log cleaning"
    echo "9 : System update"
    echo "0"
    echo "--------------------------"


read Var

header() {
	echo "=================="
	echo "$1"
	echo "=================="
}


ex()	{
                 


if [ $Var = 1 ]; then
    header "System's network information"
    ip=$(hostname -I)
    echo "IP Address: $ip"
    gw=$(ip route | awk '/default/ { print $3 }')
    echo "Gateway: $gw"
    dns=$(grep "nameserver" /etc/resolv.conf | awk '{print $2}')
    echo "DNS Server: $dns"; fi

if [ $Var = 2 ]; then
    header "User create"
    read -p "Enter username: " username
    read -p "Enter password: " password

    useradd -m -s /bin/bash -p $(openssl passwd -1 $password) $username
    if [ $? -eq 0 ]; then
    usermod -a -G sudo $username

    mkdir /home/$username/mydir
    chown -R $username:$username /home/$username/mydir
    usermod -d /home/$username/mydir $username

    echo "$username ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

    echo "User $username created successfully!"
    echo "User $username added to sudo group!"
    else
    echo "Error while creating user!"
    fi; fi


if [ $Var = 3 ]; then    
    header "Weather"
    
    echo "Enter Ur city"
    read city

    curl -4 wttr.in/$city ; fi

if [ $Var = 4 ]; then    
    header "Cleaning disc"
    
    sudo sync && sudo echo 3 > /proc/sys/vm/drop_caches
    echo "Done"
    df -h; fi

if [ $Var = 5 ]; then
    header "Sort files"
    
    du -a -d 1 -h | sort -h; fi

if [ $Var = 6 ]; then
    header "Empty folders delete"
    
    find . -type d -empty -delete
    echo "Done!"; fi


if [ $Var = 7 ]; then
    header "File rename/permission"
    echo "Enter file name"  
    read name; fi
    if [[ -f $name ]] && [[ $Var -eq 7 ]]; then
        echo "1 - name"
        echo "2 - permission" 
        read trig; fi
    if [[ $trig -eq 1 ]]; then 
        echo "Enter new file name"
        read name1
        mv $name $name1; fi
    if [[ $trig -eq 2 ]] ; then
        read -p "What to do?
    + - add
    - - delete" wtd
        read -p "Which mech?
    r - read
    w - write
    x - execute" rwx 
        chmod ugo$wtd$rwx $name; fi




if [[ $Var = 8 ]]; then

header "Cleaning logs"

LOG_DIR=/var/log
cd $LOG_DIR

cat /dev/null > messages
cat /dev/null > wtmp
echo "Logs cleaned up."; fi


if [[ $Var = 9 ]]; then

header "Upgrade system"

echo -e "\n$(date "+%d-%m-%Y --- %T") --- Starting work\n"

apt-get update
apt-get -y upgrade

apt-get -y autoremove
apt-get autoclean

echo -e "\n$(date "+%T") \t Script Terminated"; fi 

if [[ $Var != 0 ]] && [[ $Var != 1 ]] && [[ $Var != 2 ]] && [[ $Var != 3 ]] && [[ $Var != 4 ]] && [[ $Var != 5 ]] && [[ $Var != 6 ]] && [[ $Var != 7 ]] && [[ $Var != 8 ]] && [[ $Var != 9 ]]; then
 echo "Incorrect input."; fi





if [ $Var = 0 ]; then
    header "Bye :3"; fi

    }

ex
