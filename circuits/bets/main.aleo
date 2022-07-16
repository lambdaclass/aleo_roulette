// The 'bets.aleo' program.

program bets.aleo;

record token:
    owner as address.private;
    gates as u64.private;
    amount as u64.private;

function mint_casino_token:
    // casino address
    input r0 as address.private;
    // casino amount of tokens
    input r1 as u64.private;
    cast r0 0u64 r1 into r2 as token.record;
    output r2 as token.record;

function transfer_casino_to_player:
    // casino token record
    input r0 as token.record;
    // player address
    input r1 as address.private;
    // amount of token to transfer to player
    input r2 as u64.private;

    //check balance
    sub r0.amount r2 into r3;

    // token record for player
    cast r1 0u64 r2 into r4 as token.record;

    // token record for casino
    cast r0.owner r0.gates r3 into r5 as token.record;

    // casino new token record
    output r4 as token.record;
    // player new token record
    output r5 as token.record;

function bet:
    // casino token record
    input r0 as token.record;
    // player address
    input r1 as address.private;
    // Random roulette result
    input r2 as u8.private;
    // Player number bet
    input r3 as u8.private;
    // Player amount of tokens bet
    input r4 as u64.private;
    // Player amount of available tokens
    input r5 as u64.private
    
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
