echo "Type an lower limit as the size of the dir to be found and moved, followed by [ENTER]:"
read size

echo "Type an upper limit as the size of the dir to be found and moved, followed by [ENTER]:"
read size2


if [[ ! -d dest_dir ]]
then
	mkdir dest_dir
fi

find ./ -mindepth 1 -maxdepth 1 -type d -exec du -s {} + | awk '$1 >= '"$size"' && $1 <= '"$size2"' {print $1, $2}'


echo "Continue moving? type yes of no, followed by [ENTER]:"
read decision
if [[ "$decision" == "yes" ]]
then
	find ./ -mindepth 1 -maxdepth 1 -type d -exec du -s {} + | awk '$1 >= '"$size"' && $1 <= '"$size2"' {print $2}' | while read f; do mv "$f" ./dest_dir; done
	echo 'move complete'
else
	echo 'move cancelled'
fi