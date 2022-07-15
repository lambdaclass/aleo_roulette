program bets_aleo.aleo;

record gambler:
    owner as address.private;
    gates as u64.private;


// Casino record should be owned by the casino for production release
record casino:
    owner as address.private;
    gates as u64.private;

function bets:
    input r0 as gambler.record;
    input r1 as casino.record;
    // Represents a random result
    input r2 as u8.private;
    // The number the gambler used to bet
    input r3 as u8.private;
    // The betted amount of money
    input r4 as u64.private;

    //This should be eq but it doesn't work right now
    gte r3 r2 into r5;

    //Reward
    mul r4 35u64 into r6;

    //Casino money if win 
    add r1.gates r4 into r7;
    //Casino money if lose
    sub r1.gates r6 into r8;

    //Gambler money if win 
    add r0.gates r6 into r9;
    //Gambler money if lose
    sub r0.gates r4 into r10;

    //r5 is true if casino wins
    //r11 casino money after game
    ternary r5 r8 r7 into r11;
    //r12 gambler money after game
    ternary r5 r9 r10 into r12;

    cast r0.owner r12 into r13 as gambler.record;
    cast r1.owner r11 into r14 as casino.record;

    output r13 as gambler.record;
    output r14 as casino.record;

