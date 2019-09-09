NBE_TARGET ?= native
export NBE_TARGET
NBE_OUTPUT = $(NBE_ROOT)/$(NBE_TARGET)
export NBE_OUTPUT

NBE_BUILDPATH ?= $(NBE_OUTPUT)/build
export NBE_BUILDPATH
NBE_APPPATH ?= $(NBE_OUTPUT)/bin
export NBE_APPPATH
NBE_KMODPATH ?= $(NBE_OUTPUT)/kmod
export NBE_KMODPATH
NBE_LIBPATH ?= $(NBE_OUTPUT)/lib
export NBE_LIBPATH
NBE_INCPATH ?= $(NBE_OUTPUT)/include
export NBE_INCPATH
NBE_DBGPATH ?= $(NBE_OUTPUT)/debug
export NBE_DBGPATH
NBE_COVPATH ?= $(NBE_OUTPUT)/cov
export NBE_COVPATH

NBE_MK_INCPATH ?= $(NBE_OUTPUT)/_include
export NBE_MK_INCPATH
NBE_MK_OBJPATH ?= $(NBE_OUTPUT)/_obj
export NBE_MK_OBJPATH
NBE_MK_PICPATH ?= $(NBE_OUTPUT)/_pic
export NBE_MK_PICPATH
NBE_MK_KEXTPATH ?= $(NBE_OUTPUT)/_kext
export NBE_MK_KEXTPATH
NBE_MK_KBUILDPATH ?= $(NBE_OUTPUT)/_kbuild
export NBE_MK_KBUILDPATH
NBE_MK_COVPATH ?= $(NBE_OUTPUT)/_cov
export NBE_MK_COVPATH
NBE_MK_DPDKPATH ?= $(NBE_OUTPUT)/_dpdk
export NBE_MK_DPDKPATH

NBE_PATHLOG_RESTORE ?= $(NBE_OUTPUT)/restore.path
export NBE_PATHLOG_RESTORE
