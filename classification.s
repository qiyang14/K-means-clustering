/*
 * classification.s
 *
 *  Created on: 2021/8/26
 *      Author: Gu Jing
 */
   .syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.thumb

		.global classification

@ Start of executable code
.section .text

@ EE2028 Assignment 1, Sem 1, AY 2021/22
@ (c) ECE NUS, 2021

@ Write Student 1’s Name here: Sun Qiyang A0242744E
@ Write Student 2’s Name here: Darryl See A0216216N

@ You could create a look-up table of registers here:
@ classification((int*)points10, (int*)centroids10, (int*)class, (int*)new_centroids10);

@ [R0] R4 points10[0][0] X0
@ [R0, #4]! points10[0][1] Y0
@ [R0, #4]! points10[1][0] X0

@ [R1] R5 centroids10[0][0] C1x
@ [R1, #4]! centroids10[0][1] C1y  - R8

@ [R2] R6 class[0]
@ [R3, #4]! class[1]

@ R3 M

@ write your program from here:
classification:
    @check how many registers r u used, R0-R5, you must remember the original value. retrive R0-R5

    @initailization
    PUSH {R0-R12, R14}
    LDR R4, [R0] @X0
    LDR R5, [R1] @C1x
    LDR R7, [R3] @M
    LDR R8, [R1, #4] @C1y
    LDR R9, [R1, #8] @C2x
    LDR R10, [R1, #12] @C2y
    BL Loop1
    POP {R0-R12, R14}
    BX LR

    Loop1:
    @calculate the distance from point C1
    SUB R11, R4, R5  @calculate the diffenerce in x
    MUL R11, R11, R11
    LDR R3, [R0, #4]!
    SUB R12, R3, R8 @calculate the diffenerce in y
    MUL R12, R12, R12
    ADD R6, R11, R12

    @calculate the distance from point C2
    SUB R11, R4, R9
    MUL R11, R11, R11
    SUB R12, R3, R10
    MUL R12, R12, R12
    ADD R3, R11, R12
    @compare the distance
    MOV R11, #1
    MOV R12, #2
    CMP R6, R3
    ITE MI @ if negative - class 2 else class 1
    STRMI R11, [R2], #4 @class[M] = 1  MI-negative N=1
    STRPL R12, [R2], #4 @class[M] = 2  PL-positive or zero N=0

    LDR R4, [R0, #4]!
    SUBS R7, #1
    BNE Loop1 @ Not Equal flag Z=0

    BX LR


	@BL SUBROUTINE


@SUBROUTINE:

@	BX LR
