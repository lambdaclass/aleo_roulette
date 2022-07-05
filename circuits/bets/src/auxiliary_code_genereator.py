

#number = number + bit_field[254]*1;
#number = number + bit_field[253]*2;
#number = number + bit_field[252]*4;
print("Convert bit field to field code")
for i in range(254):
    a = 254-i
    b = 2**i
    print("number = number + bit_field[{}]*{};".format(253-i,2**i))
