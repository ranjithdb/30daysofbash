### tr command:
```
The tr command in Unix/Linux is used to translate or delete characters from a string.
* tr '/' '_': This command replaces all slashes (/) in the string with underscores (_)

#### For example:
Input: problem/stuff/stuff

Output: problem_stuff_stuff 
```


### tar command:
```
* tar -cf archive.tar foo bar           Create archive.tar from files foo and bar.
* tar -tvf archive.tar                  List all files in archive.tar verbosely.
* tar -xf archive.tar                   Extract all files from archive.tar.
* tar -czf demo.txt                     Create archive.tar.gz from demo.txt
* tar -f                                Refers to the archive file name.
* tar -xf archive.tar -C /path          Specifies the directory where the files should be extracted.                 
