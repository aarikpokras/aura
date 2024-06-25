all: install

install:
	chmod +x aura.sh
	mv aura.sh aura
	mv man1/aura.1 .
	gzip aura.1
	cp aura.1.gz /usr/share/man/man1/
	cp aura /usr/bin/
	@echo Done!

clean:
	@rm -rf ../aura
	@echo Done!
