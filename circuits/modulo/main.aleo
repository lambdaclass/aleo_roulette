// The 'modulo.aleo' program.
program modulo.aleo;

function mod:
    input r0 as boolean.public;
    input r1 as boolean.public;
    input r2 as boolean.public;
    input r3 as boolean.public;
    input r4 as boolean.public;
    input r5 as boolean.public;

    add 1u16 0u16 into r6;
    add 2u16 0u16 into r7;
    add 4u16 0u16 into r8;
    add 8u16 0u16 into r9;
    add 16u16 0u16 into r10;
    add 32u16 0u16 into r11;

    ternary r5 r6 0u16 into r12;
    ternary r4 r7 0u16 into r13;
    ternary r3 r8 0u16 into r14;
    ternary r2 r9 0u16 into r15;
    ternary r1 r10 0u16 into r16;
    ternary r0 r11 0u16 into r17;

    add r12 r13 into r18;
    add r14 r18 into r19;
    add r15 r19 into r20;
    add r16 r20 into r21;
    add r17 r21 into r22;

    div r22 37u16 into r23;
    mul 37u16 r23 into r24;
    sub r22 r24 into r25;

    output r25 as u16.public;
