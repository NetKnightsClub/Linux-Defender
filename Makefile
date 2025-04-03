# Something might be broken here, first time using makefile - Kel
# Also I did uh... Use AI for this, come on I was in the middle of class and I was in a rush.
# Define variables
CC = gcc
CFLAGS = -Wall -Werror
SOURCES = $(wildcard src/*.c)
OBJECTS = $(SOURCES:.c=.o)
EXECUTABLE = linux_defender

# Default target
all: $(EXECUTABLE)

# Link object files to create the executable
$(EXECUTABLE): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^

# Compile C source files into object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Run Python scripts
run-python:
	python3 scripts/linux_defender_gui.py

# Run Shell scripts
run-shell:
	./scripts/setup.sh

# Clean up object files and executable
clean:
	rm -f $(OBJECTS) $(EXECUTABLE)

# Phony targets to avoid conflicts with files of the same name
.PHONY: all run-python run-shell clean
