@ See Broadcom BC2835 Peripherals, page 90-... for details
@ The physical address for GPIO starts at 0x20200000
@ Control for pin 16, the LED, is controlled by GPFSEL1.
@ To set pin 16 to output mode, we set bits 18-20 to 0b001.
@ To output on pin 16, we set bit 16 of GPSET0 to the desired output.
	.section .init
	.globl _start
_start:
	bl kmain

wait:	b wait
	
