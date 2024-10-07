The `echo -e` command in Bash enables interpretation of backslash escapes in the string that follows, allowing the use of various escape sequences to format output.

\n
\t

echo -e "Hello \n World"

Hello
 World


echo "Hello \n World"

hello \n world


The -E option tells grep to interpret the pattern as an "extended regular expression" (ERE).

The -E flag allows you to use special characters directly without escaping them.
grep -E '...': The -E option allows the use of the | operator to match multiple patterns
| grep -v -E 'On-line|NUMA': The -v option inverts the match, meaning it will exclude any line containing the patterns specified in the regex (in this case, On-line and NUMA).
