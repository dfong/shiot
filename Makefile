# shiot makefile just for tests

ifeq ($(PWD),)
PWD:=$(shell /bin/pwd -P)
endif
export PATH:=$(PWD):$(PATH)

default: tests

.PHONY: default tests shiot-selftest shiot-doctest

tests: shiot-selftest shiot-doctest
	@echo ===== all tests passed!

shiot-selftest:
	shiot -C test/shiot-tests
	@echo ===== $@ passed

shiot-doctest:
	shiot -v -T
	@echo ===== $@ passed

