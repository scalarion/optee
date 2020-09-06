package main

import (
	"fmt"
	"time"

	"github.com/scalarion/cryptoapi/teesvc"
)

type signal struct {
	terminate bool
	value     uint32
	duration  time.Duration
}

func tee(c chan signal) {
	fmt.Println("tee enter")

	sig := new(signal)
	sig.terminate = false
	sig.value = 41

	for i := 1; i < 50; i++ {
		t := time.Now()
		sig.value, _ = teesvc.ValidateCertificate(sig.value)
		sig.duration = time.Since(t)
		c <- *sig
	}
	sig.terminate = true
	c <- *sig

	fmt.Println("tee exit")
}

func ree() {
	fmt.Println("ree enter")
	for {
		fmt.Println("!!! ============ howdy ============ !!!")
		time.Sleep(167 * time.Millisecond)
	}
}

func result(c chan signal) {
	for sig := <-c; !sig.terminate; sig = <-c {
		fmt.Printf("Go: received value from TEE: %d %d\n", sig.duration.Milliseconds(), sig.value)
	}
}

func main() {
	c := make(chan signal)

	go ree()

	go tee(c)

	result(c)
}
