usage()
{ 
        echo "usage)   ./set_hostname.sh [hostname] [CIDR]"
        echo "example) ./set_hostname.sh worker0 20"
}

set_hostname()
{
        echo "$(ip addr | grep -w "inet")" > ip_inet.txt


        while read line || [ -n "$line" ]; do
                #echo "Line : $line"
                ip=$(echo "$line" | cut -d ' ' -f2)
                #echo "ip : $ip"
                cidr=$(echo "$ip" | cut -d '/' -f2)
                #echo "cidr : $cidr"
                if [[ "$cidr" == $2 ]]; then
                        target_ip=$(echo "$ip" | cut -d '/' -f1)
                        for i in {1..4}; do echo "$target_ip" | cut -d '.' -f $i >> target_ip.txt; done
                        break
                fi
        done < ip_inet.txt


        hostname="$1"
        while read line || [ -n "$line" ]; do
                if [ -z "$hostname" ]; then
                        hostname=$line
                else
                        hostname="$hostname-$line"
                fi
        done < target_ip.txt
        echo ">> hostname : $hostname"

        sudo hostname $hostname
        sudo bash -c "echo '$hostname' >  /etc/hostname"
}

num_args="$#"
host_name=$1
CIDR=$2
if [ $num_args -ne 2 ]; then
        usage
        exit
else
        set_hostname $host_name $CIDR
				rm -rf ip_inet.txt
				rm -rf target_ip.txt
fi
