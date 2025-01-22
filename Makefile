# Nombre del proyecto
TARGET     := space_invaders
BUILD      := build
SOURCE     := src
INCLUDE    := include
ASSETS     := assets

# Herramientas
PREFIX     := arm-none-eabi-
CC         := $(PREFIX)gcc
LD         := $(PREFIX)ld
OBJCOPY    := $(PREFIX)objcopy
SIZE       := $(PREFIX)size

# Configuración de compilación
ARCH       := -mthumb -mthumb-interwork
SPECS      := -specs=gba.specs
CFLAGS     := -Wall -O2 $(ARCH) -I$(INCLUDE) -ffast-math
LDFLAGS    := $(ARCH) $(SPECS)

# Archivos
SOURCES    := $(shell find $(SOURCE) -name "*.c")
OBJECTS    := $(patsubst $(SOURCE)/%.c, $(BUILD)/%.o, $(SOURCES))

# Objetivo principal: construir el ROM
$(BUILD)/$(TARGET).gba: $(OBJECTS)
	@echo "Compilando el ROM..."
	@mkdir -p $(BUILD)
	$(CC) $(LDFLAGS) -o $(BUILD)/$(TARGET).elf $(OBJECTS)
	$(OBJCOPY) -O binary $(BUILD)/$(TARGET).elf $(BUILD)/$(TARGET).gba
	$(SIZE) $(BUILD)/$(TARGET).elf

# Regla para compilar los archivos .c
$(BUILD)/%.o: $(SOURCE)/%.c
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

# Limpiar el proyecto
clean:
	@echo "Limpiando archivos generados..."
	@rm -rf $(BUILD)

# Alias
.PHONY: clean
