export CGO_ENABLED	:= 1
export GOOS 		:= linux
export GOARCH 		:= arm
export GOARM		:= 7

export CC      		:= $(CROSS_COMPILE)gcc
export LD      		:= $(CROSS_COMPILE)ld

RM 			:= rm -rf
MKDIR		:= mkdir -p

BUILDDIR 	:= bin
BINARY		:= cryptoapi

.PHONY: all clean

all: setup
	go build -o $(BUILDDIR)/$(BINARY) 

clean:
	rm -rf $(BUILDDIR)

setup:
	$(MKDIR) $(BUILDDIR)
