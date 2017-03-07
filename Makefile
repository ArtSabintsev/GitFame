BINARIES_FOLDER = /usr/local/bin/
EXECUTABLE_NAME = gitfame
EXECUTABLE_BINARY = ./build/Release/$(EXECUTABLE_NAME)

SWIFT_BINARY = /usr/bin/swift
SWIFT_BUILD_COMMAND = $(SWIFT_BINARY) build

install:
	xcodebuild -project 'GitFame.xcodeproj'
	mkdir -p $(BINARIES_FOLDER)
	cp -f $(EXECUTABLE_BINARY) $(BINARIES_FOLDER)

uninstall:
	rm -f $(BINARIES_FOLDER)$(EXECUTABLE_NAME)
