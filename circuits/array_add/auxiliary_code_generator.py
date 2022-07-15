print("interface hash_array:")
# Here the output is:
# a0 as field;
# a1 as field;
# ...
# a253 as field;
for i in range(254):
    print("\ta{} as field;".format(i))

print("function hash_array_add:")
# Here the output is:
# add r0.a0 r0.a1 into r1;
# add r0.a2 r1 into r2;
# add r0.a3 r2 into r3;
# ...
# add r0.a253 r252 into r253;
print("\tinput r0 as hash_array.public;")
print("\tadd r0.a0 r0.a1 into r1;")
for i in range(2, 254):
    print("\tadd r0.a{} r{} into r{};".format(i, i-1, i))
print("\toutput r253 as field.public;")

# The command for running a simple test:
print("aleo run hash_array_add \"{", end='')
for i in range(254):
    print("a{}: {}field, ".format(i, i), end='')
print("}\"")    
