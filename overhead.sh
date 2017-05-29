#!/bin/bash -xe
> overhead.txt
for file in `seq 1 10`; do
	sudo /sbin/iptables -Z
	scp -P 2222 testfile${file}.dat student_bsos@147.229.149.129:/tmp/
	size=$(ls -l testfile${file}.dat | awk '{print $5}')
	transfer=$(sudo /sbin/iptables -L OUTPUT -v -x | grep dohled | awk '{print $2}')
	overhead=$(echo -e "scale=10\n(${transfer} - ${size}) / ${transfer} * 100" | bc)
	echo "${size} ${transfer} ${overhead}" >> overhead.txt
done

cat overhead.txt
