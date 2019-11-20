#!/bin/sh
# Make table of existing sketches in HTML, for pasting in README.md

# Variables that you can adjust

domain="https://you-create.github.io/three.js-sketches"  # Website domain
thumb="thumbnail.png"  # Common file name for thumbnails of the sketches
t="    "  # Tab character (as defined by spaces) to insert in the HTML code
test_server="127.0.0.1"  # If -t is specified, the domain will be set to this
test_port="8000"

# Get existing sketches

sketches=$( /usr/bin/find . -maxdepth 1 -type d -not \( -name 'lib' \
										             -o -name 'libm' \
											         -o -name 'assets' \
											         -o -name 'node_modules' \
											         -o -name '.git' \
											         -o -name '.' \
		    \) -exec basename {} ';');

if [ "$1" == "-t" ]
then

	domain="$test_server:$test_port"

fi
			
# Begin generating the table

/usr/bin/printf "<table>\n"

col=0

for sketch in $( /usr/bin/printf "$sketches" )
do
	
	if [[ $col -eq 0 ]]
	then

		/usr/bin/printf "$t<tr>\n"

	fi

	col=$(( $col + 1 ));
	
	/usr/bin/printf "$t$t<td align=\"center\">\n$t$t$t<a href=\"%s\"><img src=\"%s\"/></a><br/>\n$t$t$t<a href=\"%s\">%s</a>\n$t$t</td>\n" \
					"$domain/$sketch"  "$sketch/$thumb" "$sketch/" "$sketch"
	
	if [[ $col -eq 3 || $col -eq $(( $( /usr/bin/printf "$sketches" | /usr/bin/wc --lines ) + 1 )) ]]
	then

		/usr/bin/printf "$t</tr>\n"
		col=0

	fi

done

/usr/bin/printf "</table>\n"
