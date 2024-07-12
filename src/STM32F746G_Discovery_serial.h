/* Copyright 2024 The MathWorks, Inc. */

#ifndef STM32F746G_DISCOVERY_SERIAL
#define STM32F746G_DISCOVERY_SERIAL

#include <stddef.h>

#define RTIOSTREAM_ERROR (-1)
#define RTIOSTREAM_NO_ERROR (0)

/* Note: if the functions declared in this file should be compiled into a shared
 * library (e.g. a .dll file on Windows), you must ensure that the functions are
 * externally visible. The procedure to achieve this depends on the compiler and
 * linker you are using. For example, on Windows, you may need to provide an
 * exports definition .def file that lists all of the functions to be
 * exported; see ./rtiostream/rtiostream_pc.def for a suitable .def file.
 */


extern int rtIOStreamOpen(
    int    argc,
    void * argv[]
);

extern int rtIOStreamSend(
    int          streamID,
    const void * src, 
    size_t       size,
    size_t     * sizeSent
    );

extern int rtIOStreamRecv(
    int      streamID,
    void   * dst, 
    size_t   size,
    size_t * sizeRecvd
    );

extern int rtIOStreamClose(
    int streamID
    );


#endif /* #ifndef STM32F746G_DISCOVERY_SERIAL */
