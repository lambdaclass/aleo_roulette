import hashing.poseidon;

function main(bet_number: field, spin_count: u32) -> bool {
    let rand = poseidon(bet_number, bet_number);
    return true;
}
