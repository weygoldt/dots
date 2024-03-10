DOTFILES_DIR := ~/.dotfiles
PROGRAMS := bat \
	    fontconfig \
	    git \
	    hypr \
	    kitty \
	    mako \
	    nvim \
	    ranger \
	    ssh \
	    starship \
	    tmux \
	    wlogout \
	    zathura \
	    zsh

.PHONY: all $(PROGRAMS)

all: $(PROGRAMS)

$(PROGRAMS):
	@echo "Stowing $@ configurations..."
	@stow -d $(DOTFILES_DIR) -S $@

.PHONY: update

update:
	@echo "Updating symlinks for all programs..."
	@stow -d $(DOTFILES_DIR) -R $(PROGRAMS)

.PHONY: clean

clean:
	@echo "Unstowing all program configurations..."
	@stow -d $(DOTFILES_DIR) -D $(PROGRAMS)
