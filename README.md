🧠 Reflective Section
1. How the script handles arguments and options
It uses getopts to handle -n and -v flags robustly, supporting combinations like -vn.

Positional arguments after options are treated as the search string and filename.

Basic validation checks ensure correct usage and existence of the input file.

2. Adding -i, -c, or regex support
-i is already included via grep -i.

-c (count) or -l (list filenames) would require additional flags and logic (e.g., count_only=true).

For regex, the structure wouldn't need major changes, as grep supports regex by default—just ensure the search string isn't quoted.

3. Hardest part to implement
Option parsing was the trickiest—especially managing positional arguments after flags (getopts doesn’t handle this directly).

Also ensuring the correct behavior with combined flags and helpful error messages took time to test and fine-tune.

