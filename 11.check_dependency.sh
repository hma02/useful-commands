deps=(
cmake
git
libgoogle-glog-dev 
libprotobuf-dev 
protobuf-compiler 
python-dev 
python-pip 

libgflags-dev
libgtest-dev 
libiomp-dev 
libleveldb-dev 
liblmdb-dev 
libopencv-dev 
libopenmpi-dev 
libsnappy-dev 
openmpi-bin 
openmpi-doc 
python-pydot     
)

for d in ${deps[@]}
do
	str=$(dpkg -s $d 2> /dev/null | grep 'ok installed' )
	
	if [[ -z $str ]]
	then
		echo $d' not installed'
	else
		echo $d' installed'
	fi
done