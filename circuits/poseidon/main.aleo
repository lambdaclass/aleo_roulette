// The 'poseidon.aleo' program.
program poseidon.aleo;

function psd_hash:
    input r0 as u32.public;
    hash.psd2 r0 into r1;
    output r1 as field.private;
