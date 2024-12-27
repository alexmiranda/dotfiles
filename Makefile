SHELL=/bin/sh
BASH=/bin/bash
GIT_CLONE=git clone
GIT_CLONE_OPTS=--depth 1 --shallow-submodules --no-tags
GIT_PULL_OPTS=--ff-only
MINPAC_HOME=vim/.vim/pack/minpac/opt/minpac
BAT_CONFIG=bat/.config/bat
BAT_THEMES=$(BAT_CONFIG)/themes
ZSH_CONF=zsh/.config/zsh
TMUX_TPM=tmux/.tmux/plugins/tpm
TMUX_TPM_REPO=https://github.com/tmux-plugins/tpm
STOW_TARGET?=~
STOW_FLAGS?=--no-folding -vSt
BREW_INSTALL_SCRIPT=https://raw.githubusercontent.com/Homebrew/install/master/install.sh
SDKMAN_INSTALL_SCRIPT=https://get.sdkman.io?rcupdate=false
FIREFOX=open -a Firefox --background -W --args
FIREFOX_USERJS_HOME=firefox/arkenfox_userjs
FIREFOX_EXTS=firefox/.config/firefox/extensions
FIREFOX_USERJS_REPO=https://github.com/arkenfox/user.js.git
FIREFOX_PROFILE=$(HOME)/.config/firefox
FF_EXT_UBLOCK_ORIGIN_RELEASE_API="https://api.github.com/repos/gorhill/uBlock/releases/latest"
FF_EXT_HTTPS_EVERYWHERE_RELEASE_API="https://api.github.com/repos/EFForg/https-everywhere/releases/latest"
FF_EXT_VIMIUM_TAGS_API="https://api.github.com/repos/philc/vimium/tags"
FF_EXT_MULTI_ACCOUNT_CONTAINER_RELEASE_API="https://api.github.com/repos/mozilla/multi-account-containers/releases/latest"
FF_EXT_TEMPORARY_CONTAINERS_RELEASE_API="https://api.github.com/repos/stoically/temporary-containers/releases/latest"
FF_EXT_FOXY_PROXY_RELEASE_API="https://api.github.com/repos/foxyproxy/firefox-extension/releases/latest"
FF_EXT_KEEPASSXC_BROWSER_RELEASE_API="https://api.github.com/repos/keepassxreboot/keepassxc-browser/releases/latest"
FF_EXT_AUTO_TAB_DISCARD_MANIFEST="https://raw.githubusercontent.com/rNeomy/auto-tab-discard/master/manifest.json"
FF_EXT_REFERER_MOD_MANIFEST="https://raw.githubusercontent.com/airtower-luna/referer-mod/master/manifest.json"

ALL_PACKAGES=stow
ALL_PACKAGES+=nix
ALL_PACKAGES+=home-manager
ALL_PACKAGES+=ssh
ALL_PACKAGES+=git
ALL_PACKAGES+=gnupg
ALL_PACKAGES+=alacritty
ALL_PACKAGES+=ghostty
ALL_PACKAGES+=zsh
ALL_PACKAGES+=bash
ALL_PACKAGES+=direnv
ALL_PACKAGES+=tmux
ALL_PACKAGES+=docker
ALL_PACKAGES+=ripgrep
ALL_PACKAGES+=vim
ALL_PACKAGES+=coc
ALL_PACKAGES+=universal-ctags
ALL_PACKAGES+=bat
ALL_PACKAGES+=sdkman
ALL_PACKAGES+=pyenv
ALL_PACKAGES+=thefuck
ALL_PACKAGES+=vint
ALL_PACKAGES+=asciinema
ALL_PACKAGES+=scripts
ALL_PACKAGES+=starship
ALL_PACKAGES+=luarocks
ALL_PACKAGES+=firefox
ALL_PACKAGES+=tfswitch
PACKAGES?=$(ALL_PACKAGES)

dry-run: STOW_FLAGS:=-n $(STOW_FLAGS)
bat-theme-install: BATENV=BAT_CONFIG_PATH=$(BAT_CONFIG)/config
pip-packages: SHELL=/bin/zsh
zsh-plugins: SHELL=/bin/zsh
ff-ext-%: FIREFOX_EXT_TMP_DIR:=$(shell mktemp -d -t $(shell date +"%Y%m%d"))

define install_package
stow $(STOW_FLAGS) $(STOW_TARGET) $(1)$;

endef

.PHONY: all
all: $(ZSH_CONF)/.zsh-plugins.sh minpac bat-theme tmux-tpm firefox-userjs

.PHONY: symlinks
symlinks: all destination-targets
	$(foreach package,$(PACKAGES),$(call install_package,$(package)))

.PHONY: dry-run
dry-run: symlinks

.PHONY: install
install: symlinks zsh-plugins gitconfig coc-plugins bat-theme-install firefox-settings

.PHONY: destination-targets
destination-targets:
	# some folders cannot be symlinks
	mkdir -p $(STOW_TARGET)/.ssh
	mkdir -p $(STOW_TARGET)/.gnupg
	mkdir -p $(STOW_TARGET)/.config/zsh
	mkdir -p $(STOW_TARGET)/.vim/pack/minpac/{start,opt}
	mkdir -p $(STOW_TARGET)/.config/coc/extensions
	mkdir -p $(STOW_TARGET)/.config/firefox
	# if any existing files in gnupg folder, then fix permissions
	find $(STOW_TARGET)/.gnupg -type f -exec chmod 600 {} \;
	find $(STOW_TARGET)/.gnupg -type f -exec chmod 700 {} \;

.PHONY: zsh-test
zsh-test:
	(cd $(ZSH_CONF); ZDOTDIR=. zsh -l; cd -)

# $(ZSH_CONF)/.zsh-plugins.sh: $(ZSH_CONF)/.zsh-plugins.txt
# 	antibody bundle < $< > $@

.PHONY: zsh-plugins
zsh-plugins:
	if [ -d "$${ZDOTDIR}/.antidote" ]; then \
		source "$${ZDOTDIR}/.antidote/antidote.zsh"; \
		test -d "$$(antidote home)" || mkdir -p "$$(antidote home)"; \
		antidote update; \
	fi

.PHONY: gitconfig
gitconfig:
	touch $(STOW_TARGET)/.config/git/extra.gitconfig

.PHONY: home-manager
home-manager:
	home-manager switch

.PHONY: minpac
minpac:
	if [ -d "$(MINPAC_HOME)" ]; then \
		git -C "$(MINPAC_HOME)" pull $(GIT_PULL_OPTS); \
	else \
		$(GIT_CLONE) https://github.com/k-takata/minpac.git \
		$(MINPAC_HOME) \
		$(GIT_CLONE_OPTS); \
	fi

.PHONY: coc-plugins
coc-plugins:
	if command -v npx > /dev/null 2>&1; then \
		cd $(STOW_TARGET)/.config/coc/extensions && \
		npx yarn; \
	fi

.PHONY: bat-theme
bat-theme:
	if [ -d "$(BAT_THEMES)/gruvbox" ]; then \
		git -C "$(BAT_THEMES)/gruvbox" pull $(GIT_PULL_OPTS); \
	else \
		$(GIT_CLONE) https://github.com/peaceant/gruvbox.git \
		$(BAT_THEMES)/gruvbox \
		$(GIT_CLONE_OPTS); \
	fi

.PHONY: bat-theme-install
bat-theme-install:
	$(BATENV) bat cache --build

.PHONY: tmux-tpm
tmux-tpm:
	if [ -d "$(TMUX_TPM)" ]; then \
		git -C "$(TMUX_TPM)" pull $(GIT_PULL_OPTS); \
	else \
		$(GIT_CLONE) "$(TMUX_TPM_REPO)" \
		"$(TMUX_TPM)" \
		$(GIT_CLONE_OPTS); \
	fi

.PHONY: configure
configure: xcode brew brew-packages sdkman pip-packages firefox

.PHONY: brew
brew:
	$(BASH) -c "$$(curl -fsSL $(BREW_INSTALL_SCRIPT))"

.PHONY: brew-packages
brew-packages:
	brew bundle

.PHONY: sdkman
sdkman:
	curl -s "$(SDKMAN_INSTALL_SCRIPT)" | $(BASH)

.PHONY: update-sdkman
update-sdkman:
	sdk selfupdate force

.PHONY: python
python:
	LATEST="$$(pyenv install -l | grep -v '[-b]' | tail -1)" && \
	pyenv install $$LATEST --skip-existing && \
	pyenv global $$LATEST && \
	pyenv exec pip install --upgrade pip

.PHONY: pip-packages
pip-packages:
	pyenv exec pip install --user -r requirements.txt

.PHONY: lua
lua:
	LATEST="$$( \
		   curl -sL \
		       -H 'Accept: application/vnd.github.v3+json' \
		       https://api.github.com/repos/LuaJIT/LuaJIT/tags | \
		   jq -r '.[] | select(.name | contains("-") | not) | .name | sub("^v";"")' | \
		   sort -t '.' -k1,1n -k2,2n -k3,3n | \
		   tail -n1 \
		   )" && \
	(yes | MACOSX_DEPLOYMENT_TARGET="10.15" luaver install-luajit "$$LATEST")

.PHONY: update-brewfile
update-brewfile:
	brew bundle dump -f

.PHONY: firefox
firefox:
	test -d "$(FIREFOX_PROFILE)" || \
		$(FIREFOX) -no-remote \
		-CreateProfile "$(USER) $(FIREFOX_PROFILE)" \
		-override $(PWD)/firefox/.config/firefox/override.ini \
		-setDefaultBrowser \
		-safe-mode \
		-silent

.PHONY: firefox-userjs
firefox-userjs:
	if [ -d "$(FIREFOX_USERJS_HOME)" ]; then \
		git -C "$(FIREFOX_USERJS_HOME)" pull $(GIT_PULL_OPTS); \
	else \
		$(GIT_CLONE) $(FIREFOX_USERJS_REPO) \
		$(FIREFOX_USERJS_HOME) \
		$(GIT_CLONE_OPTS); \
	fi

.PHONY: firefox-settings
firefox-settings: firefox/.config/firefox/user-overrides.js
	$(SHELL) $(FIREFOX_USERJS_HOME)/updater.sh -p "$(FIREFOX_PROFILE)" -d -s

.PHONY: firefox-extensions
firefox-extensions: ff-ext-ublock-origin ff-ext-https-everywhere ff-ext-vimium ff-ext-multi-account-containers ff-ext-temporary-containers ff-ext-foxy-proxy ff-ext-keepassxc-browser ff-ext-auto-tab-discard ff-ext-referer-mod

.PHONY: ff-ext-ublock-origin
ff-ext-ublock-origin:
	DOWNLOAD_URL="$$( \
		curl -s -L $(FF_EXT_UBLOCK_ORIGIN_RELEASE_API) | \
		jq -r '.assets | .[] | select(.name | contains("firefox")) | .browser_download_url' \
	)"; \
	XPI_FILE="$(FIREFOX_EXT_TMP_DIR)/$${DOWNLOAD_URL##*/}"; \
	curl -s -o $${XPI_FILE} --create-dirs -L $${DOWNLOAD_URL}; \
	TARGET_NAME=$$(unzip -p $${XPI_FILE} manifest.json | jq -r '.browser_specific_settings.gecko.id'); \
	mkdir -p $(FIREFOX_EXTS); \
	mv $${XPI_FILE} $(FIREFOX_EXTS)/$${TARGET_NAME}.xpi; \
	rm -rf $(FIREFOX_EXT_TMP_DIR);

.PHONY: ff-ext-https-everywhere
ff-ext-https-everywhere:
	DOWNLOAD_URL="https://www.eff.org/files/https-everywhere-latest.xpi"; \
	XPI_FILE="$(FIREFOX_EXT_TMP_DIR)/$${DOWNLOAD_URL##*/}"; \
	curl -s -o $${XPI_FILE} --create-dirs -L $${DOWNLOAD_URL}; \
	TARGET_NAME=$$(unzip -p $${XPI_FILE} manifest.json | jq -r '.applications.gecko.id'); \
	mkdir -p $(FIREFOX_EXTS); \
	mv $${XPI_FILE} $(FIREFOX_EXTS)/$${TARGET_NAME}.xpi; \
	rm -rf $(FIREFOX_EXT_TMP_DIR);

.PHONY: ff-ext-vimium
ff-ext-vimum:
	# FIXME: download won't work when new version is released
	LATEST_VERSION="$$(curl -s -L $(FF_EXT_VIMIUM_TAGS_API) | jq -r '.[0].name[1:]')"; \
	DOWNLOAD_URL="https://addons.mozilla.org/firefox/downloads/file/3518684/vimium_ff-$${LATEST_VERSION}-fx.xpi"; \
	XPI_FNAME="$${DOWNLOAD_URL##*/}"; \
	XPI_FILE="$(FIREFOX_EXT_TMP_DIR)/$${XPI_FNAME}"; \
	curl -s -o $${XPI_FILE} --create-dirs -L $${DOWNLOAD_URL}; \
	mkdir -p $(FIREFOX_EXTS); \
	mv $${XPI_FILE} $(FIREFOX_EXTS)/$${XPI_FNAME}; \
	rm -rf $(FIREFOX_EXT_TMP_DIR);

.PHONY: ff-ext-multi-account-containers
ff-ext-multi-account-containers:
	DOWNLOAD_URL="$$( \
		curl -s -L $(FF_EXT_MULTI_ACCOUNT_CONTAINER_RELEASE_API) | \
		jq -r '.assets | .[] | select(.name | endswith(".xpi")) | .browser_download_url' \
	)"; \
	XPI_FILE="$(FIREFOX_EXT_TMP_DIR)/$${DOWNLOAD_URL##*/}"; \
	curl -s -o $${XPI_FILE} --create-dirs -L $${DOWNLOAD_URL}; \
	TARGET_NAME=$$(unzip -p $${XPI_FILE} manifest.json | jq -r '.applications.gecko.id'); \
	mkdir -p $(FIREFOX_EXTS); \
	mv $${XPI_FILE} $(FIREFOX_EXTS)/$${TARGET_NAME}.xpi; \
	rm -rf $(FIREFOX_EXT_TMP_DIR);

.PHONY: ff-ext-temporary-containers
ff-ext-temporary-containers:
	DOWNLOAD_URL="$$( \
		curl -s -L $(FF_EXT_TEMPORARY_CONTAINERS_RELEASE_API) | \
		jq -r '.assets | .[] | select(.name | endswith(".xpi")) | .browser_download_url' \
	)"; \
	XPI_FILE="$(FIREFOX_EXT_TMP_DIR)/$${DOWNLOAD_URL##*/}"; \
	curl -s -o $${XPI_FILE} --create-dirs -L $${DOWNLOAD_URL}; \
	TARGET_NAME=$$(unzip -p $${XPI_FILE} manifest.json | jq -r '.applications.gecko.id'); \
	mkdir -p $(FIREFOX_EXTS); \
	mv $${XPI_FILE} $(FIREFOX_EXTS)/$${TARGET_NAME}.xpi; \
	rm -rf $(FIREFOX_EXT_TMP_DIR);

.PHONY: ff-ext-foxy-proxy
ff-ext-foxy-proxy:
	DOWNLOAD_URL="$$( \
		curl -s -L $(FF_EXT_FOXY_PROXY_RELEASE_API) | \
		jq -r '.assets | .[] | select(.name | endswith(".xpi")) | .browser_download_url' \
	)"; \
	XPI_FILE="$(FIREFOX_EXT_TMP_DIR)/$${DOWNLOAD_URL##*/}"; \
	curl -s -o $${XPI_FILE} --create-dirs -L $${DOWNLOAD_URL}; \
	TARGET_NAME=$$(unzip -p $${XPI_FILE} manifest.json | jq -r '.browser_specific_settings.gecko.id'); \
	mkdir -p $(FIREFOX_EXTS); \
	mv $${XPI_FILE} $(FIREFOX_EXTS)/$${TARGET_NAME}.xpi; \
	rm -rf $(FIREFOX_EXT_TMP_DIR);

.PHONY: ff-ext-keepassxc-browser
ff-ext-keepassxc-browser:
	DOWNLOAD_URL="$$( \
		curl -s -L $(FF_EXT_KEEPASSXC_BROWSER_RELEASE_API) | \
		jq -r '.assets | .[] | select(.name | contains("firefox")) | .browser_download_url' \
	)"; \
	XPI_FILE="$(FIREFOX_EXT_TMP_DIR)/$${DOWNLOAD_URL##*/}"; \
	curl -s -o $${XPI_FILE} --create-dirs -L $${DOWNLOAD_URL}; \
	TARGET_NAME=$$(unzip -p $${XPI_FILE} manifest.json | jq -r '.applications.gecko.id'); \
	mkdir -p $(FIREFOX_EXTS); \
	mv $${XPI_FILE} $(FIREFOX_EXTS)/$${TARGET_NAME}.xpi; \
	rm -rf $(FIREFOX_EXT_TMP_DIR);

.PHONY: ff-ext-auto-tab-discard
ff-ext-auto-tab-discard:
	# FIXME: download won't work when new version is released
	LATEST_VERSION="$$(curl -s -L $(FF_EXT_AUTO_TAB_DISCARD_MANIFEST) | jq -r '.version')"; \
	DOWNLOAD_URL="https://addons.mozilla.org/firefox/downloads/file/3610821/auto_tab_discard-$${LATEST_VERSION}-an+fx.xpi"; \
	XPI_FNAME="$${DOWNLOAD_URL##*/}"; \
	XPI_FILE="$(FIREFOX_EXT_TMP_DIR)/$${XPI_FNAME}"; \
	curl -s -o $${XPI_FILE} --create-dirs -L $${DOWNLOAD_URL}; \
	mkdir -p $(FIREFOX_EXTS); \
	mv $${XPI_FILE} $(FIREFOX_EXTS)/$${XPI_FNAME}; \
	rm -rf $(FIREFOX_EXT_TMP_DIR)

.PHONY: ff-ext-referer-mod
ff-ext-referer-mod:
	# FIXME: download won't work when new version is released
	LATEST_VERSION="$$(curl -s -L $(FF_EXT_REFERER_MOD_MANIFEST) | jq -r '.version')"; \
	DOWNLOAD_URL="https://addons.mozilla.org/firefox/downloads/file/3598288/referer_modifier-$${LATEST_VERSION}-an+fx.xpi"; \
	XPI_FILE="$(FIREFOX_EXT_TMP_DIR)/$${DOWNLOAD_URL##*/}"; \
	curl -s -o $${XPI_FILE} --create-dirs -L $${DOWNLOAD_URL}; \
	TARGET_NAME="$$(unzip -p $${XPI_FILE} manifest.json | jq -r '.browser_specific_settings.gecko.id')"; \
	mkdir -p $(FIREFOX_EXTS); \
	mv $${XPI_FILE} $(FIREFOX_EXTS)/$${TARGET_NAME}; \
	rm -rf $(FIREFOX_EXT_TMP_DIR);

ghostty/.config/ghostty/default_config:
	ghostty +show-config --default --docs > $@

.PHONY: clean
clean:
	git clean -Xfd
