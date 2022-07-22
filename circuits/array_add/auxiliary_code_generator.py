# Here the output is:
# input r0 as field;
# input r1 as field;
# ...
# input r253 as field;
for i in range(254):
    print("\tinput r{} as field.public;".format(i))

# Here the output is:
# add r0 r1 into r254;
# add r254 r2 into r255;
# ...
# add r0.a253 r252 into r253;
print("\n\tadd r0 r1 into r254;")
for i in range(254, 507):
    print("\tadd r{} r{} into r{};".format(i, i-253, i+1))
print("\n\toutput r507 as field.public;")

# The command for running a simple test:
print("aleo run hash_array_add ", end='')
for i in range(254):
    print("{}field ".format(i), end='')
