all: build

build:
	go build

run: build
	./twiddler

clean:
	rm twiddler
