#!/usr/local/bin/python3

def main():
    filename = 'day1.txt'
    with open(filename) as fd:
        lines = fd.readlines()
        lines = [int(l.rstrip()) for l in lines]
    prev = lines[0]
    increases = 0
    for index in range(1, len(lines)):
        if lines[index] > prev:
            # print(prev, lines[index])
            increases += 1
        else:
            print(prev, lines[index])
        prev = lines[index]
    return increases

if __name__ == '__main__':
    print(main())