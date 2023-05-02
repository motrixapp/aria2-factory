# Aria2 Factory
A small factory that compiles [Aria2](https://github.com/aria2/aria2).

## Building

### macOS
It is recommended to install a clean and up-to-date macOS using Virtual Machine Tools. 

Ex. [Parallels Desktop](https://www.parallels.com/) + [macOS Ventura](https://www.apple.com/macos/ventura/)

Then install the basic software, such as [Homebrew](https://brew.sh), [Xcode Command Line Tools](https://developer.apple.com/xcode/resources/) etc.

```bash
# Git clone codes
git clone https://github.com/motrixapp/aria2-factory.git

# Based on the system arch, copy the build script.
ARCH=$(uname -m)
cp ./scripts/darwin/$ARCH/build.sh ./

# Make build.sh executable
chmod +x ./build.sh

# Go
sh ./build.sh
```

### Linux & Windows
Prepare a Linux host with docker installed.

[Install Docker Engine](https://docs.docker.com/engine/install/)


```bash
# Git clone codes
git clone https://github.com/motrixapp/aria2-factory.git

# Go
sh ./aria2-factory/scripts/[platform]/[arch]/build.sh
```


## References
- [Aria2](https://github.com/aria2/aria2)
- [Aria2 Manual](https://aria2.github.io/manual/en/html/)
- [q3aql/aria2-static-builds](https://github.com/q3aql/aria2-static-builds)
- [P3TERX/Aria2-Pro-Core](https://github.com/P3TERX/Aria2-Pro-Core)
- [Docker Docs](https://docs.docker.com/)
- [Homebrew](https://brew.sh)


## Licence
[![GPLv3](https://www.gnu.org/graphics/gplv3-127x51.png)](https://github.com/motrixapp/aria2-factory/blob/master/LICENSE)