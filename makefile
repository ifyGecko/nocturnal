default: nocturnal.nim
	nim compile --gc:regions -d:release --opt:size nocturnal.nim
	strip --strip-all nocturnal

clean:
	rm -f nocturnal *~
