package connparse

import "net"

// ConnParser abstracts the implementation of a net.Conn parser.
type ConnParser interface {
	// ParseDomain returns the FDQN of the given conn.
	ParseDomain(conn net.Conn) (string, error)
}
