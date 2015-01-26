
# Any files that are important to the project but not referenced from elsewhere
AUXFILES := LICENSE Makefile kernel.ld

# all directories that have project source
PROJDIRS := source/

SRCFILES := $(shell find $(PROJDIRS) -name "*.cpp")
ASMFILES := $(shell find $(PROJDIRS) -name "*.s")
HDRFILES := $(shell find $(PROJDIRS) -name "*.hpp")

OBJFILES := $(patsubst %.cpp,%.o,$(SRCFILES)) $(patsubst %.s,%.o,$(ASMFILES))

DEPFILES := $(patsubst %.o,%.d,$(OBJFILES))

ALLFILES := $(SRCFILES) $(HDRFILES) $(AUXFILES)

WARNINGS := -Wall -Wextra -Werror -Wreturn-type -Wunused -Wuninitialized \
		-Wsuggest-attribute=pure -Wsuggest-attribute=const \
		-Wsuggest-attribute=noreturn -Wsuggest-attribute=format \
		-Wwrite-strings -Wpadded -Wpacked

CXXFLAGS := -std=gnu++1y $(WARNINGS) -mcpu=arm1176jzf-s -fpic -ffreestanding
TARGET := arm-none-eabi
LINKER := $(TARGET)-ld
CXX := $(TARGET)-g++
COPIER := $(TARGET)-objcopy
AS := $(TARGET)-as

# These names should never be treated as files
.PHONY: all clean dist

all: kernel.img

install:
	@mount /dev/sdf1 /mnt/sd_card
	@cp kernel.img /mnt/sd_card/kernel.img
	@umount /mnt/sd_card

kernel.img: $(OBJFILES) kernel.ld
	@$(LINKER)  -T kernel.ld -o kernel.elf -O2 -nostdlib $(OBJFILES) --no-undefined -Map kernel.map
	@$(COPIER) kernel.elf -O binary kernel.img

clean:
	-$(RM) $(wildcard $(OBJFILES) $(DEPFILES) kernel.img kernel.elf kernel.list kernel.map)

dist:
	tar cvf kernel.tar $(ALLFILES)

-include $(DEPFILES)

%.o: %.cpp Makefile
	@$(CXX) $(CXXFLAGS) -MMD -MP -c $< -o $@

%.o: %.s Makefile
	@$(AS) -c $< -o $@
