/*
 * find_new_centroids.s
 *
 *  Created on: 2021/8/26
 *      Author: Gu Jing
 */
   .syntax unified
 .cpu cortex-m4
 .fpu softvfp
 .thumb

  .global find_new_centroids

@ Start of executable code
.section .text

@ EE2028 Assignment 1, Sem 1, AY 2021/22
@ (c) ECE NUS, 2021

@ Write Student 1’s Name here: Sun Qiyang A0242744E
@ Write Student 2’s Name here: Darryl See A0216216N

@ You could create a look-up table of registers here:


@ write your program from here:
find_new_centroids:
 PUSH {R0-R12, R14}
 LDR R4, [R0] @R0 is points X First point
 LDR R5, [R0, #4]! @Y of first point
 LDR R6, [R2] @R2 is class
 LDR R7, [R3]
 MOV R8, #0
 MOV R12, #0
 MOV R1, #0
 BL Loop1

 UDIV R10, R10, R8
 UDIV R11, R11, R8
 UDIV R12, R12, R1
 UDIV R9, R9, R1
 STR R10, [R3]
 STR R11, [R3, #4]
 STR R12, [R3, #8]
 STR R9, [R3, #12]

 POP {R0-R12, R14}
 BX LR

 Loop1:
 CMP R6, #1
 ITE NE
 ADDNE R1, #1
 ADDEQ R8, #1


 CMP R6, #1
 ITTEE EQ
 ADDEQ R10, R4
 ADDEQ R11, R5
 ADDNE R12, R4
 ADDNE R9, R5

 LDR R6, [R2, #4]! @NEXT VALUE IN CLASS
 LDR R4, [R0, #4]! @NEXT COORD X
 LDR R5, [R0, #4]! @NEXT COORD Y

 SUBS R7, #1
 BNE Loop1 @LOOP AGAIN

 BX LR
