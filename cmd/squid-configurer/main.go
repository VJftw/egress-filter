package main

import (
	"fmt"
	"log"
	"os"
	"strings"
)

const (
	ConfigFile         = "/etc/squid/squid.conf"
	DomainWhitelistEnv = "DOMAIN_WHITELIST"
)

func main() {
	f, err := os.OpenFile(ConfigFile,
		os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Println(err)
	}
	defer f.Close()

	for _, domain := range getDomainWhitelist() {
		log.Printf("whitelisting: %s", domain)

		if _, err := f.WriteString(fmt.Sprintf("acl whitelist dstdomain %s\n", domain)); err != nil {
			log.Println(err)
		}
	}

	if len(getDomainWhitelist()) > 0 {
		if _, err := f.WriteString("http_access allow whitelist\nhttp_access deny all"); err != nil {
			log.Println(err)
		}
	}
}

func getDomainWhitelist() []string {
	domainWhitelistCSV := os.Getenv(DomainWhitelistEnv)

	return strings.Split(domainWhitelistCSV, ",")
}
