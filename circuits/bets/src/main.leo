import hashing.poseidon;


//rand_bit_field is the factorization of the poseidon hash of the rand_seed
function main(bet_number: field, rand_seed: field, rand_bit_field: [field;254]) -> bool {
    let rand_field = poseidon(rand_seed, rand_seed);
    // TO DO: Use rand_field to verify bit factorization 
    // (This requires to loop with a field as index)

    let spinned_number = spin_roulette_from_rand_bit_field(rand_bit_field);
    return true;
}

function spin_roulette_from_rand_bit_field(rand_bit_field: [field;254]) -> u32{
    let rand_six_bits: u32 = six_bits_int_from_bitfield(rand_bit_field);
    // Modulus 32 operator
    return rand_six_bits - (rand_six_bits / 37 * 37);
}

function six_bits_int_from_bitfield(bit_field: [field;254]) -> u32 {
    let number: u32 = 0;
    for i in 0..6{
        if bit_field[253-i] == 1 {
            number = number + (2**(i));
        }
    }
    return number;
}

// 254 bits -> field 
@test
function test_roulette_number () {
    let rand_bit_field: [field; 254] = [0, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1,
       1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0,
       0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0,
       1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1,
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1,
       0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0,
       1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0,
       1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0,
       0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0,
       1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1,
       0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0,
       0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1];

    console.assert(spin_roulette_from_rand_bit_field(rand_bit_field) < 38);
}
