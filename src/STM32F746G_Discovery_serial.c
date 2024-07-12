/* Copyright 2024 The MathWorks, Inc. */
#include "STM32F746G_Discovery_serial.h"
#include "stm32f7xx_hal.h"

extern UART_HandleTypeDef huart1;

int rtIOStreamOpen(int argc, void * argv[])
{
	(void)argc;
	(void)argv;
	return RTIOSTREAM_NO_ERROR;
}

int rtIOStreamSend(int streamID, const void * src, size_t size,size_t* sizeSent)
{
	(void)streamID;
	if (HAL_OK == HAL_UART_Transmit(&huart1, src, size, HAL_MAX_DELAY)) {
		*sizeSent = size;
		return RTIOSTREAM_NO_ERROR;
	} else {
		*sizeSent = (size - huart1.TxXferCount);
		return RTIOSTREAM_ERROR;
	}
}

int rtIOStreamRecv(int streamID, void * dst, size_t size, size_t* sizeRecvd)
{
	(void)streamID;
	if (HAL_OK == HAL_UART_Receive(&huart1, dst, size, HAL_MAX_DELAY)) {
		*sizeRecvd = size;
		return RTIOSTREAM_NO_ERROR;
	} else {
		*sizeRecvd = (size - huart1.RxXferCount);
		return RTIOSTREAM_ERROR;
	}
}


int rtIOStreamClose(int streamID)
{
	(void)streamID;
	return RTIOSTREAM_NO_ERROR;
}
