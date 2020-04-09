#!/bin/bash
pathFile=$1
extFile=$2
text2Find=$3
text2Replace=$4

function usage {
	progName=`basename $0`
	echo "usage: $progName pathFile extFile text2Find text2Replace [testMode]"
    echo "  pathFile     (mandatory) The path of the files to work to"
    echo "  extFile      (mandatory) The extension of the files to work to"
    echo "               with whitespaces"
    echo "  text2Find    (mandatory) The text to find to. Use quotes for words separated"
    echo "               with whitespaces"
    echo "  text2Replace (mandatory) The text to find to. Use quotes for words separated"
    echo "               with whitespaces or empty word with [testMode]"
    echo "  testMode     (optional)  If informed, the script does the replacement but"
    echo "               ONLY THESE changes are kept in new files with '.2' extension."
    echo "               The next execution does not kept the previous changes"
    echo "  "
    echo "  Without params shows this help"
    exit 1
}

#echo "text2Find:$text2Find:"

[ -z $text2Find ] && { usage; }
[ -z $text2Replace ] && { usage; }

if [ -n $testMode ]; then
	echo "Executing in REAL mode"
else
	echo "Executing in TEST mode"
fi

echo "Replacing in '$1' with '$2' in $pathFile the files with extension "*.$extFich"  "
read -p "Press Enter to continue" option

#echo "find $pathFile -name \"*.$extFich\" -print | xargs sed -i \"s/$text2Find/$text2Replace/g\""
#find $pathFile -name "*.$extFich" -print | xargs sed -e 's/$text2Find/$text2Replace/g'
for file in `find $pathFile -name "*.$extFich"`; do
	if [ -n `grep -EH $text2Find $file` ]; then
		echo encontrado $text2Find en $file
		sed s/$text2Find/$text2Replace/g $file > $file.2
		rm $file
		mv $file.2 $file
	fi
done