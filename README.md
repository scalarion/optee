# optee

Demo project to evaluate calling OPTEE Trusted Applications from Go

The project requires an Ubuntu 18.04 host. Clone the repository into your home directory and run setup.sh. It will install and run OPTEE in an 32bit armv7 QEMU emulator.

To setup a clean virtual Ubuntu 18.04 environment install https://multipass.run and execute following commands from your commandline

```Bash
multipass launch --mem <mem> --disk 20G --cpus <cpus> --name optee bionic
multipass exec opteex -- git clone https://github.com/scalarion/optee.git
multipass exec opteex -- optee/setup.sh
```
