# optee

Demo project to evaluate calling OPTEE Trusted Applications from Go

The project requires an Ubuntu 18.04 host. Clone the repository into your home directory and run setup.sh. It will install and run OPTEE in an 32bit armv7 QEMU emulator.

To setup a clean virtual Ubuntu 18.04 environment install https://multipass.run and execute following commands from your commandline:

```
multipass launch --mem <mem> --disk 20G --cpus <cpus> --name optee bionic
multipass exec optee -- git clone https://github.com/scalarion/optee.git
multipass exec optee -- optee/setup.sh
```

Set ```<mem>``` to at least ```2G``` and ```<cpus>```to the number of cpus you want to have in your virtual machine. 

To start your installation run following commands from your commandline each in its own terminal window:

```
multipass exec optee -- optee/run_ree_terminal.sh
multipass exec optee -- optee/run_tee_terminal.sh
multipass exec optee -- optee/run.sh
```

At the ```(qemu)``` prompt continue execution with ```c```.

Login with ```root``` in the REE terminal window and execute the test program with ```./run.sh``` in root home directory.

You may want to install [Visual Studio Code](https://code.visualstudio.com) with [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) extension and connect Visual Studio Code to the virtual machine by typing ```Cmd+Shift+P``` and ```Remote-SSH: Connect to Host...```using ```ssh ubuntu@<xx.xx.xx.xx>``` and password ```ubuntu``` . You then could open the workspace from ```~/optee/cryptoapi/cryptoapi.code-workspace``` to browse the demo project. To experience full convenience with code completion and build on save install [Go for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=golang.Go), [C/C++ for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools) and [File Watcher](https://marketplace.visualstudio.com/items?itemName=appulate.filewatcher) extensions.
