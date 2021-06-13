#/bin/bash
  
  while :; do
       read -ep "Enter the public IP address for K8s_Master: " Mas_ip
     if [[ $Mas_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
       break
     else
      echo "***PLEASE ENTER A VALID IP ADDRESS***"; continue;
     fi
  done

  while :; do
      read -ep "Enter the no.of K8s_Nodes: " num
      [[ $num =~ ^[0-9]+$ ]] || { echo "***PLEASE ENTER A VALID NUMBER***"; continue; } 
  break  
  done  

    if (($num > 0)); then
      echo -e "\n[Kube-All]\n$Mas_ip" >> /etc/ansible/hosts
      echo "$Mas_ip" >> /usr/local/src/K8s_ips
      for ((i=1; i<=num; i++)) do 
        while :; do
            read -ep "Enter the Public IP address for K8s_Node$i: " Node_ip
          if [[ $Node_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            break
          else
            echo "***PLEASE ENTER A VALID IP ADDRESS***"; continue;
          fi
        done
          echo "$Node_ip" >> /usr/local/src/K8s_ips
          echo "$Node_ip" >> /etc/ansible/hosts
          unset Node_ip
      done 
      echo -e "\n[Kube-Master]\n$Mas_ip" >> /etc/ansible/hosts
      unset Mas_ip
      unset Node_ip
    else
      echo "***You must specify atleast one node for the K8s cluster setup***" 
    fi

    IPLIST="/usr/local/src/K8s_ips"
    for ip in $(cat $IPLIST)
      do
        ansible $ip -m ping
    done
    unlink /usr/local/src/K8s_ips
