package proxy

import (
	"bufio"
	"bytes"
	"fmt"
	"io"
	"log"
	"net"
	"regexp"
)

var GetDomain = regexp.MustCompile(`(?:[_a-z0-9](?:[_a-z0-9-]{0,61}[a-z0-9])?\.)+(?:[a-z](?:[a-z0-9-]{0,61}[a-z0-9])?)?`).FindString

// buffer is just here to make bytes.Buffer an io.ReadWriteCloser.
// Read about embedding to see how this works.
type buffer struct {
	bytes.Buffer
}

// Add a Close method to our buffer so that we satisfy io.ReadWriteCloser.
func (b *buffer) Close() error {
	b.Buffer.Reset()
	return nil
}

func Listen(l5server Layer5Server) error {
	network, address := l5server.GetNetworkAddress()
	listener, err := net.Listen(network, address)
	if err != nil {
		return fmt.Errorf("could not listen: %w", err)
	}

	for {
		conn, err := listener.Accept()
		if err != nil {
			log.Printf("err: %s\n", err)
		}

		go func() {
			reader := bufio.NewReader(conn)

			buf := &buffer{}

			// continuously read src conn into a buffer.
			// while reading src conn, try to extract domain.
			// once found domain, start dest conn and start copying buffer into dest conn

			domain := ""
			proxied := false
			for {
				// read a single byte which contains the message length
				// size, err := reader.ReadByte()
				// if err != nil {
				// 	log.Printf("error: %s\n", err)
				// 	return
				// }

				readBytes, err := reader.ReadBytes('\n')
				if err != nil {
					log.Printf("error: %s", err)
					return
				}
				log.Printf("read bytes: %s", readBytes)

				if _, err := buf.Write(readBytes); err != nil {
					log.Printf("error: %s", err)
					return
				}

				log.Printf("wrote bytes: %s", readBytes)

				// read the full message, or return an error
				// _, err = io.ReadFull(reader, buf[:int(size)])
				// if err != nil {
				// 	log.Printf("error: %s\n", err)
				// 	return
				// }

				// fmt.Printf("received (%d) %s\n", size, buf[:int(size)])

				if domain == "" {
					domain = GetDomain(string(readBytes))
				}
				if domain != "" && !proxied {
					go func() {
						destConn, err := net.Dial(network, "google.com:443")
						if err != nil {
							log.Printf("error: %s\n", err)
							return
						}

						copyConn(conn, destConn, buf)
					}()
					proxied = true
				}
			}
		}()
	}

	return nil
}

func copyConn(src, dst, buf io.ReadWriteCloser) {
	// src -> buf
	// buf -> dst
	// buf -> src
	done := make(chan struct{})

	go func() {
		defer src.Close()
		defer dst.Close()
		defer buf.Close()
		io.Copy(src, buf)
		done <- struct{}{}
	}()

	go func() {
		defer src.Close()
		defer dst.Close()
		defer buf.Close()
		io.Copy(buf, dst)
		done <- struct{}{}
	}()

	go func() {
		defer src.Close()
		defer dst.Close()
		defer buf.Close()
		io.Copy(buf, src)
		done <- struct{}{}
	}()

	<-done
	<-done
	<-done
}
