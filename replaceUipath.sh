#!/bin/bash
text2Find=$1
text2Replace=$2
testMode=$3

function usage {
	progName=`basename $0`
	echo "usage: $progName text2Find text2Replace [testMode]"
	echo "  text2Find    (mandatory) The text to find to. Use quotes for words separated"
	echo "               with whitespaces"
	echo "  text2Replace (optional)  The text to find to. Use quotes for words separated"
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

if [ -n $testMode ]; then
	echo "Executing in REAL mode"
else
	echo "Executing in TEST mode"
fi

	echo "Replacing '$1' with '$2' for all "*.xaml" "
	read -p "Press Enter to continue" option

for file in `find . -name "*.xaml" -exec grep -il "$text2Find" {} \;` ; do
	echo Match $text2Find found in $file
	sed s/$text2Find/$text2Replace/g $file > $file.2
	if [ -n $testMode ]; then
		rm $file
		mv $file.2 $file
	fi
done
