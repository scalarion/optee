package teesvc

// #cgo linux,arm CFLAGS: -I../../../qemu/optee_client/out/export/usr/include
// #cgo linux,arm CFLAGS: -I../../ta/include
// #cgo linux,arm CFLAGS: -I../../libteesvc/include
// #cgo linux,arm LDFLAGS: -L../../../qemu/optee_client/out/export/usr/lib -lteec
// #cgo linux,arm LDFLAGS: -L../../libteesvc/lib -lteesvc
// #include "tee_client_api.h"
// #include "teesvc.h"
import "C"
import (
	"errors"
	"fmt"
)

func ValidateCertificate(value uint32) (uint32, error) {
	var val C.uint32_t = C.uint32_t(value)
	var err C.uint32_t
	var res C.uint32_t

	res = C.ValidateCertificate(&val, &err)

	if res != C.TEEC_SUCCESS {
		return 0, errors.New(fmt.Sprintf("TEE Error; Res: %8x; Err: %8x", res, err))
	} else {
		return uint32(val), nil
	}
}
