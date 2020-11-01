grep --line-buffered -m 1 "refs/tags" manifest/default.xml | awk -F '/' '{print $3}' | awk -F '"' '{print $1}'

