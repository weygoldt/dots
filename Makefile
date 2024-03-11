# Description: A simple Makefile to manage the dotfiles

# Define the hostnames for the work and home machines
WORK_HOSTNAME := polarbear
HOME_HOSTNAME := archlinux
HOSTNAME := $(shell uname -n)

# Get the current directory
DOTFILES_DIR := $(shell pwd)

# Find all directories in the dotfiles directory that are not hidden or the .git directory
WORK_OVERRIDES := $(shell find $(DOTFILES_DIR) -maxdepth 1 -type d -name "*-work" -exec basename {} \;)
HOME_OVERRIDES := $(shell find $(DOTFILES_DIR) -maxdepth 1 -type d -name "*-home" -exec basename {} \;)
PROGRAMS := $(shell find $(DOTFILES_DIR) -maxdepth 1 -type d -name "*" -exec basename {} \; | grep -vE '(\.git|\.|home|work)')

# Check if the current host is the work or home machine
ifeq ($(HOSTNAME),$(HOME_HOSTNAME))
OVERRIDES := $(HOME_OVERRIDES)
else ifeq ($(HOSTNAME),$(WORK_HOSTNAME))
OVERRIDES := $(WORK_OVERRIDES)
endif

# Define the targets that do not correspond to files
.PHONY: all $(PROGRAMS) $(OVERRIDES)

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
