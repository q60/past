NAME = past
TARGET = ./past/past

all: build test

build:
	factor-vm deploy-me.factor . .

test:
	$(TARGET)

install:
	install -Dm755 "$(TARGET)" "$(DESTDIR)/usr/bin/$(NAME)"

uninstall:
	rm -rfv "$(DESTDIR)/usr/bin/$(NAME)"

clean:
	rm -rfv ./past/
