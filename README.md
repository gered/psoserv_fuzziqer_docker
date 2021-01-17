# Phantasy Star Online (PSO) Dockerized Fuzziqer "Newserv" Server

This repository contains a Dockerfile and scripts to run an instance of the
[Fuzziqer Software "newserv"](https://github.com/fuzziqersoftware/newserv)
via Docker.

**Please note that I _do not_ support the "newserv" software itself. It is not perfect and should
only really be used by advanced users who are comfortable digging in and troubleshooting issues 
themselves. If you ask me for help with configuring or troubleshooting "newserv", your questions
_will_ go un-answered!**

## Usage

Make a copy of the file `config.json` called `myconfig.json` and edit it as desired.

Some important/useful config values in `myconfig.json` that you may want to tweak:

* `LocalAddress` should specify the IP address of the Docker host running the newserv container. This is how PSO clients that utilize newserv's built-in DNS server will be connecting (e.g. Gamecube).
* `AllowUnregisteredUsers` if you're just running a server at home for private use only (not accessible by anyone outside your home), then for convenience, you could set this option to `true` to allow anyone to connect to your server without needing to pre-register their license.

Then run the `run.sh` script, which will start up a Docker container running "newserv" that
will be using your `myconfig.json` file.

Some extra convenience scripts are included to manage/monitor the running server:

* `logs.sh` just runs a `docker logs -f` on the container. This output will be very busy when clients are connected!
* `stop.sh` stops the container.
* `newserv_cli.sh` attaches to the running container so you can run newserv CLI commands. Type `help` to see a list of supported commands.

### Connecting Gamecube Clients

Set up one of the two network configurations for your server.

* Go to Options > Network Option > Provider Option
* Then go into "Network Setup", select which network configuration to edit, then select "Edit menu"
  * Edit ISP name
    * Give it a name, select "Next"
  * Ethernet Settings
    * Set the "Connection settings" as appropriate for your home network. Most people probably want to use "Automatically obtain an IP address (DHCP)"
    * For "Line timeout", most people will probably want to select "Do not automatically disconnect"
    * Select "Next"
  * _(If you selected "Manually set an IP address")_ IP address manual-settings
    * Enter an "IP address" and "Subnet mask" as appropriate for your home network. For "Primary DNS" however, enter the IP address of the Docker host.
    * Select "Next"
  * _(If you selected "Automatically obtain an IP address (DHCP)")_ IP address auto-settings
    * Under "DNS server address", ensure "Manual" is selected and then for "Primary DNS" enter the IP address of the Docker host.
    * Select "Next"
  * Browser settings
    * Ignore these, unless you know that you need them for your home network (in which case, you probably didn't need to read these instructions at all I would be willing to bet...) and just select "Next"
  * Select "Save" and then "Return to the game"

Now you should be able to choose "Online Mode" from the main menu and be able to connect to your server.

### Other Clients

I don't play via anything other than Gamecube. You're on your own!
