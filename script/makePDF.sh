#!/bin/bash

if [[ $# -lt 1 ]] ;then
	echo "Specified value of the argument is invalid"
	echo "USAGE: $0 (result_file) "
	exit 1
fi

DIR=`pwd`

if [ -d $1 ]; then
	echo "$1 exists."
	CNT=1
	while [ -d "${1}.${CNT}" ]
	do
		(( CNT++))
	done
	mv $1 ${1}.${CNT}
fi

mkdir $1
cd $1
SAVE_DIR=`pwd`
cd $DIR

#sudo apt update
echo "install python-venv"
#sudo apt install python3.8-venv

#make venv
python3 -m venv virtualenv
# venv activate
source virtualenv/bin/activate
pip install wheel
pip install pdfkit
pip install selenium
pip install PyPDF2
#pip install chromedriver-binary==96.0.4664.18
pip install webdriver_manager
echo "install package:"
pip freeze


#wget https://chromedriver.storage.googleapis.com/96.0.4664.18/chromedriver_linux64.zip
#unzip chromedriver_linux64.zip
#rm chromedriver_linux64.zip
#mv chromedriver ../utils/

pwd

python3 src/HTML2PDF.py data/mondai.html $SAVE_DIR
python3 src/ConnectPDF.py $SAVE_DIR
rm -r virtualenv
echo END