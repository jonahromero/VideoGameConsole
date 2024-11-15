
from intelhex import IntelHex
import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", '--in-file')
    parser.add_argument("-o", '--out-file')
    args = parser.parse_args()

    ih = IntelHex()
    ih.loadbin(args.in_file)
    ih.write_hex_file(args.out_file)
