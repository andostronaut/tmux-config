.PHONY: build

# Default values (optional)
THEME ?= tokyonight
OUTPUT ?= root

build:
	chmod +x ./scripts/build.sh
	./scripts/build.sh -t $(THEME) -o $(OUTPUT)
