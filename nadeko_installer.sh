#!/bin/sh
echo ""
echo "NadekoBot Installer started."

if hash git 1>/dev/null 2>&1
then
    echo ""
    echo "Git Installed."
else
    echo ""    
    echo "Git is not installed. Please install Git."
    exit 1
fi


if hash dotnet 1>/dev/null 2>&1
then
    echo ""
    echo "Dotnet installed."
else
    echo ""
    echo "Dotnet is not installed. Please install dotnet."
    exit 1
fi

root=/opt

cd "$root"

echo ""
echo "Downloading NadekoBot, please wait."
curl -O https://codeload.github.com/Kwoth/NadekoBot/tar.gz/1.7
mv 1.7 nadeko.tar.gz
tar xvf nadeko.tar.gz
mv NadekoBot-1.7/ NadekoBot/
cd $root/NadekoBot
echo ""
echo "NadekoBot downloaded."

echo ""
echo "Downloading Nadeko dependencies"
dotnet restore
echo ""
echo "Download done"

echo ""
echo "Building NadekoBot"
dotnet build --configuration Release
echo ""
echo "Building done."

echo ""
echo "Installation Complete."
exit 0
