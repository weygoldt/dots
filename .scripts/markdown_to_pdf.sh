# shell function to convert markdown files to pdf using pandoc and latex

pandoc "$1" \
    -f gfm \
    -V linkcolor:blue \
    -V geometry:a4paper \
    -V geometry:margin=2.5cm \
    --pdf-engine=xelatex \
    -o "$2"
