package main

import (
	"fmt"
	"math/rand"
	"time"

	"github.com/scalarion/optee/cryptoapi/go/teesvc"
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

	for i := 1; i < 5; i++ {
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
		fmt.Println("REE: !!! ============ howdy ============ !!!")
		time.Sleep(time.Duration(rand.Intn(100)) * time.Millisecond)
	}
}

func result(c chan signal) {
	for sig := <-c; !sig.terminate; sig = <-c {
		fmt.Printf("TEE: \"%d\", computing time: %d\n", sig.value, sig.duration.Milliseconds())
	}
}

func main() {
	c := make(chan signal)

	go ree()

	go tee(c)

	result(c)
}
