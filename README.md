<style>
td, th {
   border: none!important;
   font-weight: 400!important;
   text-align: left!important;
   vertical-align: top!important;
}
</style>

# Udacimak
Udacity Course Downloader

**Current Udacimak CLI Tag: latest**

## Install as native binary

First export and persist version
```sh
$ export UDACIMAK_VERSION="latest"
$ echo 'UDACIMAK_VERSION="latest"' | sudo tee -a /etc/environment > /dev/null
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
     --volume ~/.udacimak:/root/.udacimak \
     --volume "$(pwd)":/downloads \
     --workdir /downloads \
     "pam79/udacimak:${UDACIMAK_VERSION}" "$@";
```

Create the cache volume
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

| **Usage:** |
| ----------------------------------------------- |
| &nbsp;udacimak `<command>` `<args>` `[options]` |


| **Options:** ||
| ------------------- | ---------------------------- |
| &nbsp;-v, --version | output the version number    |
| &nbsp;-h, --help    | output usage information     |


| **Commands:**  |||
| ---------------------------------------------------- |-|-|
| &nbsp;download&nbsp;`[options]`&nbsp;`[courseid...]` || Fetch course/Nanodegree data from Udacity and save them locally as JSON files. |
||||
| &nbsp;listnd || List user's enrolled and graduated Nanodegree. |
||||
| &nbsp;render `[options]` `<path>` || Render downloaded json course content into HTML by downloading all videos, creating text content, etc. |
||||
| &nbsp;renderdir `[options]` `<path>` || Render a whole directory of downloaded json course contents. |
||||
| &nbsp;settoken `<token>` || Save Udacity authentication token locally. |
||||
| &nbsp;login || Login to audacity and save the token locally. |


For more info on udacimak, visit their [official wiki page](https://github.com/udacimak/udacimak/wiki).
