
import importlib
import argparse

def binary_string_to_file(binary_string, filename):
    """Converts a binary string to a binary file."""
    with open(filename, "wb") as file:
        byte_array = bytearray(int(binary_string[i:i+8], 2) for i in range(0, len(binary_string), 8))
        file.write(byte_array)


# just builds binary with ascending integers
def create_bin():
    result = ""
    for i in range((2**11)):
        result += bin(i*4)[2:].zfill(32)
    return result

PURPLE = (177, 3, 252)

def create_colors():
    return [(i%256, (i+200)%256, (i+100)%256) for i in range(4096)]

def create_colors2():
    # we get 4096 colors
    colors = []
    rainbow_colors = [
        (255, 0, 0),     # Red
        (255, 127, 0),   # Orange
        (255, 255, 0),   # Yellow
        (0, 255, 0),     # Green
        (0, 0, 255),     # Blue
        (75, 0, 130),    # Indigo
        (148, 0, 211)    # Violet
    ]
    ri = 0
    for i in range(12):
        print(f"{ri}: {rainbow_colors[ri]}")
        for _ in range(320):
            colors.append(rainbow_colors[ri])
        ri = (ri + 1) % len(rainbow_colors)

    for _ in range(256):
        colors.append(rainbow_colors[ri])
    return colors

def create_img():
    result = ""
    colors = create_colors2()
    def get_bin_digits(i, d):
        raw = bin(i)[2:]
        if len(raw) < d:
            return raw.zfill(d)
        else:
            return raw[-d:]
    if len(colors) != 4096:
        raise Exception("wrong size")
    for (r, g, b) in colors:
        rgb = get_bin_digits(r>>3, 5) + get_bin_digits(g>>2, 6) + get_bin_digits(b>>3, 5)
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
