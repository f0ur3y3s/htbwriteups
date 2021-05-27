namelist = ['Fergus Smith', 'Shaun Coins', 'Sophie Driver', 'Hugo Bear', 'Bowie Taylor', 'Steven Kerb']

f = open('userspython.txt', 'w')

for name in namelist:
    name = name.split()

    f.write(name[0] + '.'+name[1]+'\n')
    f.write(name[0][0]+name[1]+'\n')
    f.write(name[0][0:2]+name[1]+'\n')
    f.write(name[0][0:3]+name[1]+'\n')
f.close()