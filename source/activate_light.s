@ See Broadcom BC2835 Peripherals, page 90-... for details
@ The physical address for GPIO starts at 0x20200000
@ Control for pin 16, the LED, is controlled by GPFSEL1.
@ To set pin 16 to output mode, we set bits 18-20 to 0b001.
@ To output on pin 16, we set bit 16 of GPSET0 to the desired output.
	.section .init
	.globl _start
_start:
	ldr r0,=0x20200000 	@ This load the address of the start of GPIO from a literal area
	mov r1,#1
	lsl r1,#18 		@ This gets the bit pattern for setting pin 16 to output
	str r1,[r0,#4]

light_on:
	mov r2,#1		@ Set the bit to activate the LED
	lsl r2,#16
	str r2,[r0,#0x28]	@ Store the bit to the pin

	mov r1,#0x3F0000	@ Wait for some time
light_on_delay:
	sub r1,r1,#1
	cmp r1,#0
	bne light_on_delay	@ If the counter is still positive, keep looping

light_off:	
	mov r2,#1
	lsl r2,#16
	str r2,[r0,#0x1C]

	mov r1,#0x3F0000
light_off_delay:
	sub r1,r1,#1
	cmp r1,#0
	bne light_off_delay

	b light_on

wait:	b wait
	
