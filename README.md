# NadekoBot for Discord, for Docker
Nadeko is written in C# and Discord.net for more information visit https://github.com/Kwoth/NadekoBot

Full Documentation available @ http://nadekobot.readthedocs.io/en/latest/guides/Docker%20Guide/

Just swap out `uirel/nadeko:1.4` for `pixelperfect/nadeko:1.9`

## tl;dr

### To install

    docker create --name=nadeko -v /nadeko/conf/:/root/nadeko -v /nadeko/data:/opt/NadekoBot/src/NadekoBot/bin/Release/netcoreapp1.1/data pixelperfect/nadeko:1.9
    
Where `/nadeko/conf` is where you want your config files, and `/nadeko/data` is where you want your data files

(Hint: Your credentials.json will be in the conf folder) [More on that here](http://nadekobot.readthedocs.io/en/latest/JSON%20Explanations/)

### To start

With monitoring: `docker start nadeko; docker logs -f nadeko`

Without monitoring: `docker start nadeko`

### To update

    docker pull pixelperfect/nadeko:1.9
    docker stop nadeko
    dockerr rm nadeko
    docker create --name=nadeko -v /nadeko/conf/:/root/nadeko -v /nadeko/data:/opt/NadekoBot/src/NadekoBot/bin/Release/netcoreapp1.1/data pixelperfect/nadeko:1.9
    
