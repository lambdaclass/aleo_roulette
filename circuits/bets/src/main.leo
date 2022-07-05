import hashing.poseidon;


//rand_bit_field is the factorization of the poseidon hash of the rand_seed
function main(bet_number: field, rand_seed: field, rand_bit_field: [bool;254]) -> bool {
    let rand_field = poseidon(rand_seed, rand_seed);
    // TO DO: Use rand_field to verify bit factorization 
    // (This requires to loop with a field as index)

    let spinned_number = spin_roulette_from_rand_bit_field(rand_bit_field);
    return true;
}

function spin_roulette_from_rand_bit_field(rand_bit_field: [bool;254]) -> u32{
    let rand_six_bits: u32 = six_bits_int_from_bitfield(rand_bit_field);
    // Modulus 32 operator
    return rand_six_bits - (rand_six_bits / 32 * 32);
}

function six_bits_int_from_bitfield(bit_field: [bool;254]) -> u32 {
    let number: u32 = 0;
    for i in 0..7{
        if bit_field[253-i] == true{
            number = number + 2**(i);
        }
    }
    return number;
}

@test
function test_roulette_number () {
    let rand_bit_field: [bool; 254] = [
        false, false,  true,  true,  true, false,  true,  true, false,
        true, false,  true,  true,  true, false,  true, false, false,
        true,  true, false, false,  true, false, false,  true,  true,
        true,  true,  true, false, false,  true,  true, false, false,
        true, false,  true, false,  true, false,  true,  true, false,
       false, false,  true, false,  true, false,  true,  true, false,
       false, false,  true, false,  true, false, false, false,  true,
        true,  true,  true, false,  true,  true,  true,  true, false,
        true,  true,  true, false,  true, false,  true,  true, false,
        true, false, false, false, false,  true,  true,  true,  true,
        true, false, false, false, false,  true, false,  true,  true,
        true,  true, false,  true, false,  true,  true, false,  true,
        true,  true,  true, false,  true, false, false, false,  true,
       false,  true, false,  true, false,  true, false, false, false,
        true, false,  true, false,  true,  true, false, false,  true,
       false, false, false, false,  true, false, false, false, false,
        true,  true, false,  true,  true,  true, false, false,  true,
       false,  true,  true, false,  true, false, false, false, false,
        true,  true,  true,  true, false,  true, false, false, false,
        true,  true, false, false, false,  true,  true,  true, false,
       false,  true,  true,  true, false, false, false,  true, false,
       false, false, false, false,  true, false,  true,  true,  true,
        true, false,  true,  true, false,  true, false,  true, false,
       false, false,  true,  true, false, false, false, false,  true,
       false, false,  true,  true,  true,  true, false,  true, false,
        true,  true, false, false,  true,  true,  true, false,  true,
       false, false,  true,  true, false,  true, false, false, false,
       false,  true, false, false, false,  true,  true, false,  true,
       false, true];

    console.assert(spin_roulette_from_rand_bit_field(rand_bit_field) < 38);
}
