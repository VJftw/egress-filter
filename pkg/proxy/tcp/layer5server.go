package tcp

import "fmt"

type Layer5Server struct {
	port uint16
}

func NewLayer5Server(port uint16) *Layer5Server {
	return &Layer5Server{
		port: port,
	}
}

func (ls *Layer5Server) GetNetworkAddress() (string, string) {
	return "tcp", fmt.Sprintf(":%d", ls.port)
}
