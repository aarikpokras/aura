all: install

install:
	chmod +x aura.sh
	mv aura.sh aura
	cp aura /usr/bin/
	@echo Done!

clean:
	@rm -rf ../aura
	@echo Done!
