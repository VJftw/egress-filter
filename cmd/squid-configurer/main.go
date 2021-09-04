package main

import (
	"log"
	"os"
	"strings"
)

const (
	WhitelistFile      = "/etc/squid/whitelist.txt"
	DomainWhitelistEnv = "DOMAIN_WHITELIST"
)

func main() {
	f, err := os.OpenFile(WhitelistFile,
		os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Println(err)
	}
	defer f.Close()

	for _, domain := range getDomainWhitelist() {
		log.Printf("whitelisting: %s", domain)

		if _, err := f.WriteString(domain + "\n"); err != nil {
			log.Println(err)
		}
	}
}

func getDomainWhitelist() []string {
	domainWhitelistCSV := os.Getenv(DomainWhitelistEnv)

	return strings.Split(domainWhitelistCSV, ",")
}
