#include <stdio.h>

int main() {
    unsigned char head=0b00110111;
    unsigned char leds[8] = {0};
    leds[head>>4] |= 1<<(head&0b00001111);
    for(int i=0; i<8; i++) {
        printf("LED %d: %x\n", i, leds[i]);
    }
}