rm *.log
find . -name '*.pyc' -delete

if git diff --quiet HEAD &>/dev/null
then
    rm ebdocker-py-*.zip
    HASH=$(git log --pretty=format:'%h' -n 1)
    zip -r ebdocker-py-$HASH.zip .
else
    echo "Can't build, your branch has uncommitted files"
fi
