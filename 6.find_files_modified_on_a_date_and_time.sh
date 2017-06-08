time1="Jan 17 16:10"
time2="Jan 17 16:50"
find . -maxdepth 10 -newermt "${time1[@]}" \! -newermt "${time2[@]}" -ls | wc -l