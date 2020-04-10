#!/bin/bash

CURR_PATH=$PWD
DLOAD_BASE="https://download.uipath.com"

windowsHomePath="C:$HOMEPATH\\Documents\\UiPath\\Software\\"

#Nombre de los productos de UiPath
P1="UiPathPlatformInstaller.exe"
P2="UiPathStudio.msi"
P3="UiPathOrchestrator.msi"
P4="beta/UiPathStudioSetup.exe"
AllP="$P1 $P2 $P3 $P4"

function Quit {
	echo "---------------    Q U I T    ----------------"
	echo "--- Option QUIT selected"
	echo "--- Closing UiPath Suite downloader"
	echo "----------------------------------------------"
	exit 
}

function downloadAndRename {
	prod=$1
	DLOAD_LINK=$DLOAD_BASE$versionPath$prod
	wget -c $DLOAD_LINK

	if [ "$version" != "" ]; then
		#Rename section
		fromName=`basename $prod`
		toName=${fromName/\./\.$version\.}
		#echo "fromName:"$fromName
		#echo "toName:"$toName
		mv $fromName $toName
		echo "File renamed to "$toName
	fi
}

################
### MAIN
################
echo "+------------- UiPath Suite --------------+"
echo "|                                         |"
echo "| * Select a product to dowload:          |"
echo "|     1. UiPathPlatformInstaller.exe      |"
echo "|     2. UiPathStudio.msi                 |"
echo "|     3. UiPathOrchestrator.msi           |"
echo "|     4. UiPathStudioCommunityEdition.msi |"
echo "|     5. Donwload All                     |"
echo "|     *. Press any other key to quit      |"
echo "|                                         |"
echo "+-----------------------------------------+"
read -p "Option:" option

version=""
echo "" 
read -p "Introduce version (Enter for last release):" version

case "$option" in
	1) PRODUCT=$P1;;
	2) PRODUCT=$P2;;
	3) PRODUCT=$P3;;
	4) PRODUCT=$P4;;
	5) PRODUCT=$AllP;;
	*) Quit;;	
esac

if [ "$version" == "" ]; then
	versionPath="/"
	dloadDir="last"
else
	versionPath="/versions/"$version"/"
	dloadDir=$version
fi

fullDloadDir="$windowsHomePath$dloadDir"

mkdir -p "$fullDloadDir"
cd "$fullDloadDir"

for prod in $PRODUCT; do
	downloadAndRename $prod
done

chmod 755 "$fullDloadDir/*"

#Calculate checksum for later indentifications
for fich in "$fullDloadDir/*.exe $fullDloadDir/*.msi"; do
	echo "Calulating md5sum of " `basename $fich`
	md5sum $fich > $fich.md5
done

`/cygdrive/c/Windows/explorer.exe "$fullDloadDir" &`

cd ..
