# optee

Demo project to evaluate calling OPTEE Trusted Applications from Go

setup.sh will run OPTEE in a arm7 QUEMU

To setup a clean environment install https://multipass.run and execute following commands from your commandline

multipass launch --mem 8G --disk 100G --cpus 8 --name opteex bionic

multipass exec opteex -- git clone https://github.com/scalarion/optee.git

multipass exec opteex -- optee/setup.sh
