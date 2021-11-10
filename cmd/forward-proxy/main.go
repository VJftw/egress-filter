package main

import (
	"log"

	"github.com/VJftw/egress-filter/pkg/proxy"
	"github.com/VJftw/egress-filter/pkg/proxy/tcp"
)

func main() {
	l5Server := tcp.NewLayer5Server(443)

	if err := proxy.Listen(l5Server); err != nil {
		log.Fatal(err)
	}
}
