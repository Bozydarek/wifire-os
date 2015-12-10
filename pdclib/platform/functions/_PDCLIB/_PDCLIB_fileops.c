/* _PDCLIB_fileops

   This file is part of the Public Domain C Library (PDCLib).
   Permission is granted to use, modify, and / or redistribute at will.
*/

#ifndef REGTEST
#include <stdio.h>
#include <stdint.h>
#include <_PDCLIB_glue.h>
#include <errno.h>

#include "uart_raw.h"

static bool readf( _PDCLIB_fd_t self, void * buf, size_t length, 
                   size_t * numBytesRead )
{
    errno = ENOTSUP;
    return false;
}

static bool writef( _PDCLIB_fd_t self, const void * buf, size_t length, 
                   size_t * numBytesWritten )
{
    /* Ignore all file writes as not supported, EXCEPT when writing to
     * file 1 (stdout) or 2 (stderr).
     * In such case, push data to serial port.
     */
    if(self.sval == 1 || self.sval == 2){
        const char* str = (const char*)buf;
        // TODO: Implement uart_putnstr
        for(int i = 0; i < length; i++){
            uart_putch(str[i]);
        }
        // Report we have sucessfully written all bytes.
        *numBytesWritten = length;
        return true;
    }
    errno = ENOTSUP;
    return false;
}
static bool seekf( _PDCLIB_fd_t self, int_fast64_t offset, int whence,
    int_fast64_t* newPos )
{
    errno = ENOTSUP;
    return false;
}

static void closef( _PDCLIB_fd_t self )
{
    errno = ENOTSUP;
}

const _PDCLIB_fileops_t _PDCLIB_fileops = {
    .read  = readf,
    .write = writef,
    .seek  = seekf,
    .close = closef,
};

#endif

#ifdef TEST
#include <_PDCLIB_test.h>

int main( void )
{
    // Tested by stdio test cases
    return TEST_RESULTS;
}

#endif
