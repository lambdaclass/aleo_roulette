print("Convert bit field to field - Aleo code")
#Here the output is:
#number = number + bit_field[253]*1;
#number = number + bit_field[252]*2;
#number = number + bit_field[251]*4;
#...
#number = number + bit_field[0]*2**253;
for i in range(254):
    a = 254-i
    b = 2**i
    print("number = number + bit_field[{}]*{};".format(253-i,2**i))
