all: install

install:
	mv aura.sh aura
	cp aura /usr/bin/
	@echo Done!

clean:
	rm aura
	@echo Done!
