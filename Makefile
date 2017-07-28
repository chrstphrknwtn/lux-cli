SWIFT=swiftc
FLAGS=-O
TARGET=lux
PREFIX=/usr/local/bin

bin: $(TARGET).swift
	$(SWIFT) $(FLAGS) $(TARGET).swift -o $(TARGET)

install: bin
	cp $(TARGET) $(PREFIX)/$(TARGET)

uninstall: $(TARGET)
	rm -f $(PREFIX)/$<

.PHONY: install uninstall
