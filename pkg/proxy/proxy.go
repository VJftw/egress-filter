package proxy

// Layer5Server abstracts the implementation of an OSI layer 5 proxy.
type Layer5Server interface {
	// Returns the network, address parameters to net.Listen().
	GetNetworkAddress() (string, string)
}
