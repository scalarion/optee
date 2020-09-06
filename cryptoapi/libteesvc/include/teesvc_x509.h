#ifndef TEESVC_X509_H
#define TEESVC_X509_H

/* OP-TEE TEE client API (built by optee_client) */
#include <tee_client_api.h>

extern TEEC_Result ValidateCertificate(uint32_t* value, uint32_t* err_origin);

#endif