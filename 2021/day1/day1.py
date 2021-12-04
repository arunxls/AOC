#!/usr/bin/env python3

def main():
    filename = 'day1.txt'
    with open(filename) as fd:
        lines = fd.readlines()
        lines = [int(l.rstrip()) for l in lines]
    return (count_window(lines, 1), count_window(lines, 3))

def count_window(depths, window_size):
    start = 0
    end = window_size
    increases = 0
    while end != len(depths) + 1:
        sum1 = sum(depths[start:end]) 
        sum2 = sum(depths[start+1: end+1])

        if sum1 < sum2:
            increases += 1
        start += 1
        end += 1
    return increases

if __name__ == '__main__':
    print(main())