r:
	odin run letsgo.odin -file
b:
	@odin build letsgo.odin -out=build/letsgo -file
	    ./build/letsgo $(n)

c:
	cp ./build/letsgo /usr/local/bin/letsgo
