EMACS = emacs
EMACSFLAGS =
CASK = cask
EMACS_VERSION = `$(CASK) exec $(EMACS) --version | head -1`
ALCHEMIST = alchemist.el

VERSION = $(shell git describe --tags --abbrev=0 | sed 's/^v//')
PACKAGE_NAME = alchemist-$(VERSION)

NO_COLOR=\033[0m
INFO_COLOR=\033[2;32m
STAT_COLOR=\033[2;33m

all: test

info:
	@ echo "\n$(INFO_COLOR)Installed Emacs info: $(NO_COLOR)\n"
	@ echo "  $(STAT_COLOR)[PATH]$(NO_COLOR)    = `which $(EMACS)`"
	@ echo "  $(STAT_COLOR)[VERSION]$(NO_COLOR) = $(EMACS_VERSION)"

test:	unit

unit:
	@ echo "\n$(INFO_COLOR)Run tests: $(NO_COLOR)\n"
	$(CASK) exec ert-runner

cask:
	@ echo "\n$(INFO_COLOR)Install package dependencies: $(NO_COLOR)\n"
	@ echo "$(STAT_COLOR)[cask install]$(NO_COLOR)"
	@ echo `$(CASK) install`
	@ echo "$(STAT_COLOR)[cask update]$(NO_COLOR)"
	@ echo `$(CASK) update`

clean:
	@ echo "\n$(INFO_COLOR)Clean environment: $(NO_COLOR)\n"
	rm -f $(OBJECTS)
	rm -rf .cask

package:
	@ echo "\n$(INFO_COLOR)Package Alchemist: $(NO_COLOR)\n"
	$(CASK) package

packageclean:
	@ echo "\n$(INFO_COLOR)Clean Alchemist Package: $(NO_COLOR)\n"
	rm dist/$(PACKAGE_NAME).tar

.PHONY: info test cask clean clean-elc test-elc
