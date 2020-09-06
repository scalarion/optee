CROSS_COMPILE 	?= arm-linux-gnueabihf-
TEEC_EXPORT		?= ../../qemu/optee_client/out/export/usr

CC      := $(CROSS_COMPILE)gcc
LD      := $(CROSS_COMPILE)ld
AR      := $(CROSS_COMPILE)ar
NM      := $(CROSS_COMPILE)nm
OBJCOPY := $(CROSS_COMPILE)objcopy
OBJDUMP := $(CROSS_COMPILE)objdump
READELF := $(CROSS_COMPILE)readelf

CFLAGS 	:= -fPIC -Wall -I$(TEEC_EXPORT)/include -I../ta/include 
LDFLAS 	:= -lteec -L$(TEEC_EXPORT)/lib

BINARY 	:= libteesvc

LIBDIR		:= lib
BUILDDIR 	:= bin
SOURCEDIR 	:= .
HEADERDIR 	:= include

SOURCES := $(wildcard $(SOURCEDIR)/*.c)
OBJECTS := $(patsubst $(SOURCEDIR)/%.c, $(BUILDDIR)/%.o, $(SOURCES))

RM := rm -rf
MKDIR := mkdir -p

.PHONY: all clean

all: $(BINARY)

$(BINARY): setup $(BUILDDIR)/$(OBJECTS)
	$(AR) rcs $(LIBDIR)/$(BINARY).a $(OBJECTS)

$(BUILDDIR)/%.o: $(SOURCEDIR)/%.c
	$(CC) $(CFLAGS) $(LDFLAGS) -I$(HEADERDIR) -I$(SOURCEDIR) -c $< -o $@

setup:
	$(MKDIR) $(LIBDIR) && $(MKDIR) $(BUILDDIR)

clean:
	$(RM) $(BUILDDIR) $(LIBDIR)
