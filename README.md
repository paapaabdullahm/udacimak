# Udacimak
Dockerized Udacity Course Downloader.

![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/pam79/udacimak?style=for-the-badge)&ensp;![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/pam79/udacimak?style=for-the-badge)&ensp;![Docker Pulls](https://img.shields.io/docker/pulls/pam79/udacimak?style=for-the-badge)

**Current Udacimak CLI Tag: [v1.6.6](https://github.com/udacimak/udacimak/releases/tag/v1.6.6)**

Check this [pam79/udacimak](https://github.com/pam79/udacimak) Docker [image](https://hub.docker.com/repository/docker/pam79/udacimak) out. It works out of the box with the latest and greatest of everything required to run Udacimak on your machine. The only requirement is [Docker](https://www.docker.com/get-started). No need for any hacks - it just works. 

Star it and get social with it, or you won't drink _Bissap_ again 😃

![Udacimak Example](https://raw.githubusercontent.com/wiki/udacimak/udacimak/img/example-download.gif)

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
# Put this script in $PATH as `udacimak`

TTY_FLAG=``

if [ -t 1 ]; then TTY_FLAG="-t"; fi

exec docker run --rm -i ${TTY_FLAG} \
     --volume ~/.udacimak:/root \
     --volume "$(pwd)":/downloads \
     --workdir /downloads \
     "pam79/udacimak:${UDACIMAK_VERSION}" "$@";
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

**Usage:**

&emsp;udacimak  `<command>` `<args>` `[options]`


**Options:**

&emsp;-v, --version &emsp; output the version number

&emsp;-h, --help &emsp;&emsp;&nbsp; output usage information


**Commands:**

|`Command`    | `Description`   |
|:---         |:---             |
| download&nbsp;`[options]`&nbsp;`[courseid...]` | Fetch course/Nanodegree data from Udacity and save them locally as JSON files. |
| listnd | List user's enrolled and graduated Nanodegree. |
| render `[options]` `<path>` | Render downloaded json course content into HTML by downloading all videos, creating text content, etc. |
| renderdir `[options]` `<path>` | Render a whole directory of downloaded json course contents. |
| settoken `<token>` | Save Udacity authentication token locally. |
| login | Login to audacity and save the token locally. |


**Examples:**

1: Authenticate via login  
`$ udacimak login`


2: Authenticate via token  
`$ udacimak settoken YOUR_AUTH_TOKEN`


3: List your registered Nanodegree keys  
`$ udacimak listnd`


4: Download course content as JSON using keys obtained from _3:_ above  
`$ udacimak download nd001`


5: Download course content as JSON using free course keys from url  
`$ udacimak download ud281`


6: Download multiple course contents as JSON  
`$ udacimak download nd001 nd002 ud281`


7: Render downloaded JSON (e.g: _React v2.0.0_) as local viewable content  
`$ udacimak render 'React v2.0.0'`


For more info on Udacimak, visit their [official wiki page](https://github.com/udacimak/udacimak/wiki).
