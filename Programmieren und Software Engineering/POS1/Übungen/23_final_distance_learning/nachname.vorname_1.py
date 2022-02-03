letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I"]
letDic = {}
wordList = []


def encrypt(digits):
    for i in range(len(letters)):
            letDic[i+1] = letters[i]
    for words in str(digits):
        wordList.append(letDic[int(words)])
    print("".join(wordList))


encrypt(24459)