# A simple Makefile to manage the dotfiles

# Define the hostnames for the work and home machines
WORK_HOSTNAME := polarbear
HOME_HOSTNAME := archlinux
HOSTNAME := $(shell uname -n)

# Get the current directory
DOTFILES_DIR := $(shell pwd)

# Packages: every non-hidden top-level directory. Host overrides are the
# ones ending in -home / -work; everything else is a generic package.
PACKAGES := $(shell find $(DOTFILES_DIR) -mindepth 1 -maxdepth 1 -type d ! -name '.*' -exec basename {} \; | sort)
WORK_OVERRIDES := $(filter %-work,$(PACKAGES))
HOME_OVERRIDES := $(filter %-home,$(PACKAGES))
PROGRAMS := $(filter-out %-work %-home,$(PACKAGES))

# Check if the current host is the work or home machine
ifeq ($(HOSTNAME),$(HOME_HOSTNAME))
OVERRIDES := $(HOME_OVERRIDES)
else ifeq ($(HOSTNAME),$(WORK_HOSTNAME))
OVERRIDES := $(WORK_OVERRIDES)
else
$(warning Unknown host '$(HOSTNAME)': no -home/-work overrides will be stowed (see HOME_HOSTNAME/WORK_HOSTNAME))
endif

# Define the targets that do not correspond to files
.PHONY: all update clean check $(PROGRAMS) $(OVERRIDES)

# Target to stow all program configurations and host-specific overrides
all: $(PROGRAMS) $(OVERRIDES)

# Stow the host-specific overrides and program configurations
$(OVERRIDES):
	@echo "Stowing $@ for host $(HOSTNAME)..."
	@stow -d $(DOTFILES_DIR) -S $@

# Stow the program configurations
$(PROGRAMS):
	@echo "Stowing $@ ..."
	@stow -d $(DOTFILES_DIR) -S $@

# Update the symlinks for all programs and host-specific overrides
update:
	@echo "Updating symlinks for all programs and host-specific overrides..."
	@stow -d $(DOTFILES_DIR) -R $(PROGRAMS) $(OVERRIDES)

# Unstow all program configurations and host-specific overrides
clean:
	@echo "Unstowing all program configurations and host-specific overrides..."
	@stow -d $(DOTFILES_DIR) -D $(PROGRAMS) $(OVERRIDES)

# Dry run: show what update would change without touching $(HOME)
check:
	@stow -d $(DOTFILES_DIR) -n -v -R $(PROGRAMS) $(OVERRIDES)
