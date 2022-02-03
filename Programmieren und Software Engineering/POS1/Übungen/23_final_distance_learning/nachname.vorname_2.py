products = {}
i = 1


while True:
    try:
        product = input("Produkt: ")
        if product == "":
            break
        stock = int(input("Lagerstand: "))
        products[product] = stock
    except ValueError:
        print("Bitte nur Zahlen eingeben!")
        continue


for product, stock in sorted(products.items(), key=lambda x: x[1], reverse=True):
    print(f"{product}: {stock} Rang: {i}")
    i += 1