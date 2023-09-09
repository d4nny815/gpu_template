from PIL import Image 

# RUN from root directory: python3 programs/make_mem_file.py
BITS = 0xFFF

def main():
    mem = get_mem(15, len(bin(BITS)[2:]))
    load_img_to_mem(mem, './programs/parrot.png')

    for data in mem:
        if data > BITS:
            print('data greater than 8 bits', data)
            return

    write_mem_file(mem, './HDL/gpu_mem.mem')


def get_mem(addr_bits: int, data_bits) -> list:
    max_data = 2 ** data_bits - 1    
    return [(i & max_data) for i in range(2 ** addr_bits)]

def load_img_to_mem(mem: list, infile_name: str) -> None:
    input_image = Image.open(infile_name)
    pixels = input_image.load()
    for v in range(input_image.height):
        for h in range(input_image.width):
            pixel_data = RGB_to_12b(pixels[h, v])
            addr = v * 200 + h
            mem[addr] = pixel_data & BITS
    return

def RGB_to_12b(pixel):
    r, g, b = map(lambda x: max(0, min(255, x)), pixel)
    red = int(r * 15 / 255)
    green = int(g * 15 / 255)
    blue = int(b * 15 / 255)
    return red << 8 | green << 4 | blue

def write_mem_file(mem: list, outfile_name: str):
    with open(outfile_name, 'w') as f:
        for data in mem:
            f.write(hex(data)[2:] + '\n')

if __name__ == '__main__':
    main()


