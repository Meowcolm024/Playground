import os

def main():
    paths = ["Haskell"]
    for path in paths:
        for root, dirs, files in os.walk(path):
            for file in files:
                if file.endswith(".o") or file.endswith(".hi"):
                    os.remove(path + "/" + file)


if __name__ == "__main__":
    main()
 