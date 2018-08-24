release:
	rm -Rf build/
	rake publish
server:
	middleman serve
install:
	bundle install
