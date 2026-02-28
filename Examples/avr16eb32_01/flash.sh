avr-gcc -mmcu=avr16eb32 -Wl,--gc-sections -Wa,-gstabs -Wall -o main.elf main.S
avr-objcopy -O ihex main.elf main.hex
#avr-objdump -s -m avr6 -d -h main.elf
avr-objdump -s -m avr6 -D main.hex
avrdude -v -c pkobn_updi -p avr16eb32 -U flash:w:main.hex
rm main.elf main.hex

# DUMP: avrdude -v -c pkobn_updi -p avr16eb32 -U flash:r:board.hex:i
