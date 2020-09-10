# optee

This is a demo project to evaluate calling OPTEE Trusted Applications from Go.

The project requires an Ubuntu 18.04 host. Clone the repository into your home directory and run ```~/optee/setup.sh```. It will install and run OPTEE in a 32bit armv7 QEMU emulator.

To setup a fresh Ubuntu 18.04 virtual machine is highly recommended. Install [multipass](https://multipass.run) and run following commands from your commandline:

```
multipass launch --mem <mem> --disk 20G --cpus <cpus> --name optee bionic
multipass exec optee -- git clone https://github.com/scalarion/optee.git
multipass exec optee -- optee/setup.sh
```

Set ```<mem>``` to at least ```2G``` and ```<cpus>```to the number of cpus you want to have in your virtual machine. 

To start your installation run each of the following commands in its own terminal window:

```
multipass exec optee -- optee/run_ree_terminal.sh
multipass exec optee -- optee/run_tee_terminal.sh
multipass exec optee -- optee/run.sh
```

At the ```(qemu)``` prompt continue execution with ```c```. In the REE terminal window login with user ```root``` and execute the test program with ```./run.sh``` from the root home directory.

You may want to install [Visual Studio Code](https://code.visualstudio.com) with [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) extension and connect [Visual Studio Code](https://code.visualstudio.com) to the virtual machine. 

You can login into the virtual machine with user ubuntu and password ubuntu or use [SSH Key Authentication](https://help.ubuntu.com/community/SSH/OpenSSH/Keys) for automatic login. Then you can connect to it from within [Visual Studio Code](https://code.visualstudio.com) by typing ```Cmd+Shift+P``` and ```Remote-SSH: Connect to Host...``` with ```ssh ubuntu@<xx.xx.xx.xx>```. Open the workspace from ```~/optee/cryptoapi/cryptoapi.code-workspace``` to browse the demo project. 

To experience full convenience with code completion and build on save install [Go for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=golang.Go), [C/C++ for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools) and [File Watcher](https://marketplace.visualstudio.com/items?itemName=appulate.filewatcher) extensions into the remote virtual machine.

Have fun :-)
