
import importlib
import argparse

def binary_string_to_file(binary_string, filename):
    """Converts a binary string to a binary file."""
    with open(filename, "wb") as file:
        byte_array = bytearray(int(binary_string[i:i+8], 2) for i in range(0, len(binary_string), 8))
        file.write(byte_array)

def create_bin():
    result = ""
    for i in range((2**11)):
        result += bin(i*4)[2:].zfill(32)
    return result

def create_img():
    result = ""
    def get_bin_digits(i, d):
        raw = bin(i)[2:]
        if len(raw) < d:
            return raw.zfill(d)
        else:
            return raw[-d:]
    for i in range((2**12)):
        r = 177
        g = 3
        b = 252
        rgb = get_bin_digits(r, 5) + get_bin_digits(g, 6) + get_bin_digits(b, 5)
        result += rgb
    return result

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", '--in-file')
    parser.add_argument("-o", '--out-file')
    parser.add_argument("-t", action="store_true")
    args = parser.parse_args()

    if args.t:
        binary_string_to_file(create_img(), "test_img.bin")
        return

    IntelHex = importlib.import_module("intelhex").IntelHex
    ih = IntelHex()
    ih.loadbin(args.in_file)
    ih.write_hex_file(args.out_file)

if __name__ == "__main__":
    main()
