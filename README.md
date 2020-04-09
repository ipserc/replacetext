# replacetext
Bash script to replace text in all the files with a given extension under a directory

<p>usage: rplacetext.sh pathFile extFile text2Find text2Replace [testMode]</p>
<p>  pathFile     (mandatory) The path of the files to work to</p>
  extFile      (mandatory) The extension of the files to work to
  text2Find    (mandatory) The text to find to. Use quotes for words separated
               with whitespaces
  text2Replace (mandatory) The text to find to. Use quotes for words separated
               with whitespaces or empty word with [testMode]
  testMode     (optional)  If informed, the script does the replacement but
               ONLY THESE changes are kept in new files with '.2' extension.
               The next execution does not kept the previous changes
  
  Without params shows this help
