strvar1="Hello"
strvar2="world"
strvar3="$strvar1 $strvar2!"
intvar1=1
intvar2=2
intvar3=$(($intvar1 + $intvar2))
echo $strvar3, 1+2=$intvar3 | grep "Hello world!, 1+2=3" || echo "You can't count to 3 :-D"

if [ -e /tmp/file.txt ]; then
 echo "Creating copy of /tmp/file.txt to /tmp/file_copy.txt"
 cat /tmp/file.txt > /tmp/file_copy.txt
fi
date +"%d/%M/%Y %X" > /tmp/file.txt
printf "Date: " && grep -E '[[:digit:]]{2}/[[:digit:]]{2}/[[:digit:]]{4} [[:digit:]]{2}:[[:digit:]]{2}:[[:digit:]]{2}' /tmp/file.txt

echo "How will it look like when allien comes to our land?"
year=$(date +"%Y")
echo $(date +"%Y") | grep 2013

[[ $? != 0 ]] && echo "Today is year $year? Omg, I have to come back to Mars..." && exit 1
