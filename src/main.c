#include <gba.h>

int main(void) {
    // Configurar modo gráfico
    REG_DISPCNT = MODE_3 | BG2_ENABLE | OBJ_ENABLE;

    // Pintar la pantalla de rojo
    u16* videoBuffer = (u16*)VRAM;
    for (int y = 0; y < 160; y++) {
        for (int x = 0; x < 240; x++) {
            videoBuffer[y * 240 + x] = RGB5(y & 255, (160 - y) & 255, (240 - x) & 255); // Rojo
        }
    }

    while (1) {
        VBlankIntrWait(); // Esperar sincronización vertical
    }

    return 0;
}
