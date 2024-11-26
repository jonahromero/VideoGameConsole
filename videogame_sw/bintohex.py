
import importlib
import argparse

def binary_string_to_file(binary_string, filename):
    """Converts a binary string to a binary file."""
    with open(filename, "wb") as file:
        byte_array = bytearray(int(binary_string[i:i+8], 2) for i in range(0, len(binary_string), 8))
        file.write(byte_array)

def create_bin():
    result = ""
    for i in range((2**13)):
        result += bin(i)[2:].zfill(32)
    return result

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", '--in-file')
    parser.add_argument("-o", '--out-file')
    parser.add_argument("-t", action="store_true")
    args = parser.parse_args()

    if args.t:
        binary_string_to_file(create_bin(), "test_binary.bin")
        return

    IntelHex = importlib.import_module("intelhex").IntelHex
    ih = IntelHex()
    ih.loadbin(args.in_file)
    ih.write_hex_file(args.out_file)

if __name__ == "__main__":
    main()
