msg = input("Satz oder Wort: ")
alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
caeser = "DEFGHIJKLMNOPQRSTUVWXYZABC"
alphabet_lower = "abcdefghijklmnopqrstuvwxyz"
caeser_lower = "defghijklmnopqrstuvwxyzabc"
caDict = {}
caDict_lower = {}
wordsList = []
decryptWordList = []
# key is alphabet | value is caeser


def encrypt1(msg):
    for key, key2 in zip(alphabet, caeser):
        caDict[key] = key2
    for lkey, lkey2 in zip(alphabet_lower, caeser_lower):
        caDict_lower[lkey] = lkey2
    for word in msg:
        if word == " ":
            wordsList.append(" ")
        else:
            if word.islower():
                wordsList.append(caDict_lower[word])
            else:
                wordsList.append(caDict[word])


def encrypt2():
    for word in wordsList:
        if word.islower():
            for k, v in caDict_lower.items():
                if v == word:
                    decryptWordList.append(k)
        else:
            for k, v in caDict.items():
                if v == word:
                    decryptWordList.append(k)
    return "".join(decryptWordList)


print(encrypt1(msg))
print(encrypt2())