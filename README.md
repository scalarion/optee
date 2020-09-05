# optee

Demo project to evaluate calling OPTEE Trusted Applications from Go

setup.sh will run OPTEE in a arm7 QUEMU

To setup a clean environment install https://multipass.run and execute following commands from your commandline

```Bash
multipass launch --mem <mem> --disk 20G --cpus <cpus> --name optee bionic
multipass exec opteex -- git clone https://github.com/scalarion/optee.git
multipass exec opteex -- optee/setup.sh
```
