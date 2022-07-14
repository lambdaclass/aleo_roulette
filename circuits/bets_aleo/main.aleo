program bets_aleo.aleo;

record gambler:
    owner as address.private;
    balance as u64.private;


// Casino record should be owned by the casino for production release
record casino:
    owner as address.private;
    balance as u64.private;

function bets:
    // Bet number
    input r0 as gambler.record;
    input r1 as casino.record;
    // Represents a random result
    input r2 as u8.private;
    // The number the gambler used to bet
    input r3 as u8.private;
    // The betted amount of money
    input r4 as u64.private;

    //This should be eq but it doesn't work right now
    gte r3 r3 into r5;

    ternary r5 36u64 0u64 into r6;
    ternary r5 0u64 1u64 into r7;
    add r2 0u8 into r8;

    cast r0.owner r6 into r9 as gambler.record;
    cast r0.owner r7 into r10 as casino.record;

    output r9 as gambler.record;
    output r10 as casino.record;
