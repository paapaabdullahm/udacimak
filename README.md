# Udacimak
Udacity Course Downloader

**Current Udacimak CLI Tag: v1.6.6**

## Install as native binary

First export and persist version
```sh
$ export UDACIMAK_VERSION="v1.6.6"
$ echo 'UDACIMAK_VERSION="v1.6.6"' | sudo tee -a /etc/environment > /dev/null
```

To update an already exported version (optional)
```sh
$ export UDACIMAK_VERSION="<your-new-version-string-goes-here>"
$ sudo sed -i "/UDACIMAK_VERSION/c UDACIMAK_VERSION=\"${UDACIMAK_VERSION}\"" /etc/environment
```

Pull image from docker.io
```sh
$ docker pull pam79/udacimak:${UDACIMAK_VERSION}
```

Create a wrapper script with your favorite editor
```sh
$ sudo vim /usr/local/bin/udacimak
```

Add the following docker run command to the file
```sh
#!/bin/sh

# A wrapper script for invoking udacimak with docker
# Put this script in $PATH as udacimak

TTY_FLAG=``

if [ -t 1 ]; then TTY_FLAG="-t"; fi

exec docker run --rm -i ${TTY_FLAG} \
     --volume ~/.udacimak:/.udacimak \
     --volume "$(pwd)":/downloads \
     --workdir /downloads \
     "pam79/udacimak:${UDACIMAK_VERSION}" "$@";
```

Create the .udacimak volume
```sh
mkdir -p ~/.udacimak
```

Make script executable
```sh
$ sudo chmod +x /usr/local/bin/udacimak
```

Test script
```sh
$ udacimak --version
```

## How to

**Usage:** &emsp;
&emsp;udacimak &emsp; `<command>` `<args>` `[options]`


**Options:** &emsp;
&emsp;-v, --version &emsp; output the version number
&emsp;-h, --help &emsp;&emsp;&nbsp; output usage information


**Commands:** &emsp;
&emsp;download&nbsp;`[options]`&nbsp;`[courseid...]` &emsp; Fetch course/Nanodegree data from
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&ensp; Udacity and save them locally as
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&ensp; JSON files.

&emsp;listnd &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; List user's enrolled and graduated
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&ensp; Nanodegree.

&emsp;render `[options]` `<path>` &emsp;&emsp;&emsp;&emsp;&emsp;&emsp; Render downloaded json course content
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&ensp; into HTML by downloading all videos,
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&ensp; creating text content, etc.

&emsp;renderdir `[options]` `<path>` &emsp;&emsp;&emsp;&emsp;&ensp;&nbsp; Render a whole directory of downloaded
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&ensp; json course contents.

&emsp;settoken `<token>` &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&ensp;&nbsp; Save Udacity authentication token locally.

&emsp;login &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; Login to audacity and save the token
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp; locally.

For more info on udacimak, visit their [official wiki page](https://github.com/udacimak/udacimak/wiki).
