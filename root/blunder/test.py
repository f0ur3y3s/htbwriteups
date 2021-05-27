wordlist = []


with open('output.txt','r') as f:
    for i in f:
        wordlist.append(i.strip())

print(wordlist)