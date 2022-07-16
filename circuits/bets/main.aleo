// The 'bets.aleo' program.

program bets.aleo;

record token:
    owner as address.private;
    gates as u64.private;
    amount as u64.private;

function mint_casino_token_record:
    // casino address
    input r0 as address.private;
    // casino amount of tokens
    input r1 as u64.private;
    cast r0 0u64 r1 into r2 as token.record;
    output r2 as token.record;

function make_bet:
    // casino token record
    input r0 as token.record;
    // player address
    input r1 as address.private;
    // Random roulette result
    input r2 as u8.private;
    // Player bet number
    input r3 as u8.private;
    // Player bet amount of tokens
    input r4 as u64.private;
    // Player amount of available tokens
    input r5 as u64.private;
    
    //r6 is true if player wins
    //This should be eq but it doesn't work right now
    gte r3 r2 into r6;

    //Reward
    mul r4 35u64 into r7;

    //Casino amount of tokens if it wins 
    add r0.amount r4 into r8;
    //Casino amount of tokens if it loses
    sub r0.amount r7 into r9;

    //Player amount of tokens if it wins 
    add r5 r7 into r10;
    //Player amount of tokens if it loses 
    sub r5 r4 into r11;

    //r6 is true if player wins
    //r12 casino money after game
    ternary r6 r9 r8 into r12;
    //r13 player money after game
    ternary r6 r10 r11 into r13;

    // Casino token record after the bet
    cast r0.owner r0.gates r12 into r14 as token.record;
    // Player token record after the bet
    cast r1 0u64 r13 into r15 as token.record;

    //Casino new token record
    output r14 as token.record;
    //Player new token record
    output r15 as token.record;
