// The 'roulette' main function.
record Token {
    owner: address,
    gates: u64,
    amount: u64
}

function psd_hash(public a: u32) -> field {
    return Poseidon2::hash(a);
}

function mint_casino_token_record(a: address, b: u64) -> Token {
    return Token {
        owner: a,
        gates: 0u64,
        amount: b,
    };
}

function make_bet(
    casino: Token, 
    player: address, 
    spin: u8, 
    bet: u8, 
    bet_amount: u64,
    balance: u64,
) -> (Token, Token) {
    let win: bool = spin == bet;

    let reward: u64 = bet_amount * 35u64;

    let casino_balance: u64 = 0u64;
    let player_balance: u64 = 0u64;

    if win {
        casino_balance = casino.amount - bet_amount;
        player_balance = balance + bet_amount;
    } else {
        casino_balance = casino.amount + bet_amount;
        player_balance = balance - bet_amount;
    }

    let casino_output: Token = Token {
        owner: casino.owner,
        gates: casino.gates,
        amount: casino_balance,
    };

    let player_output: Token = Token {
        owner: player,
        gates: 0u64,
        amount: player_balance,
    };

    return (casino_output, player_output);
}

function psd_bits_mod(
    public r0: bool,
    public r1: bool,
    public r2: bool,
    public r3: bool,
    public r4: bool,
    public r5: bool,
    public r6: u16,
) -> bool {
    let one: u16 = 1u16;
    let two: u16 = 2u16;
    let four: u16 = 4u16;
    let eight: u16 = 8u16;
    let sixteen: u16 = 16u16;
    let thirtytwo: u16 = 32u16;

    let r13: u16 = r5 ? one : 0u16;
    let r14: u16 = r4 ? two : 0u16;
    let r15: u16 = r3 ? four : 0u16;
    let r16: u16 = r2 ? eight : 0u16;
    let r17: u16 = r1 ? sixteen : 0u16;
    let r18: u16 = r0 ? thirtytwo : 0u16;

    let result: u16 = r13 + r14 + r15 + r16 + r17 + r18;
    let div_result: u16 = result / 37u16;
    let mul_result: u16 = div_result * 37u16;
    let sub_result: u16 = result - mul_result;

    return r6 == sub_result;
}
