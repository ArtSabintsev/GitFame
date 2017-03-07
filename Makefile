BINARIES_DIRECTORY= /usr/local/bin/
EXECUTABLE_NAME = gitfame
EXECUTABLE_BINARY = ./build/Release/$(EXECUTABLE_NAME)
XCODE_PROJECT = 'GitFame.xcodeproj'

SWIFT_BINARY = /usr/bin/swift
SWIFT_BUILD_COMMAND = $(SWIFT_BINARY) build

install:
	xcodebuild -project $(XCODE_PROJECT)
	mkdir -p $(BINARIES_DIRECTORY)
	cp -f $(EXECUTABLE_BINARY) $(BINARIES_DIRECTORY)

uninstall:
	rm -f $(BINARIES_DIRECTORY)$(EXECUTABLE_NAME)
