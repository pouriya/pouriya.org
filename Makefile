HUGO_RECOMMENDED_OPTS = --gc --verbose
HUGO_OPTS             =
DEST_DIR              = $(CURDIR)/pouriya.org
WWW_DIR               = $(DEST_DIR)/www
BASE_URL              = https://pouriya.org
HUGO_GLOBAL_CONFIG    = $(CURDIR)/src/global.toml
TMP_DIR               = $(CURDIR)/tmp
HUGO_TMP_CONFIG_FA    = $(TMP_DIR)/fa.toml
HUGO_TMP_CONFIG_EN    = $(TMP_DIR)/en.toml


.PHONY: build fa en build-dev clean dist-clean serve serve-it clean-fa clean-en ensure-dest-dirs


build: fa en
	cat Caddyfile >> $(DEST_DIR)/Caddyfile
	cat Caddy.env >> $(DEST_DIR)/Caddy.env


fa: ensure-dest-dirs clean-fa make-fa-config
	@echo Building Farsi site for $(BASE_URL)
	cd src/fa && hugo -b $(BASE_URL)/fa $(HUGO_RECOMMENDED_OPTS) --destination $(WWW_DIR)/fa $(HUGO_OPTS) --config $(HUGO_TMP_CONFIG_FA)


make-fa-config: ensure-tmp
	cat $(HUGO_GLOBAL_CONFIG) > $(HUGO_TMP_CONFIG_FA)
	cat src/fa/config.toml | awk '{gsub("BASEURL", "$(BASE_URL)", $$0); print $$0}' >> $(HUGO_TMP_CONFIG_FA)


en: ensure-dest-dirs clean-en make-en-config
	@ echo Building English site for $(BASE_URL)
	cd src/en && hugo -b $(BASE_URL)/en $(HUGO_RECOMMENDED_OPTS) --destination $(WWW_DIR)/en $(HUGO_OPTS) --config $(HUGO_TMP_CONFIG_EN)


make-en-config: ensure-tmp
	cat $(HUGO_GLOBAL_CONFIG) > $(HUGO_TMP_CONFIG_EN)
	cat src/en/config.toml | awk '{gsub("BASEURL", "$(BASE_URL)", $$0); print $$0}' >> $(HUGO_TMP_CONFIG_EN)


build-dev:
	$(MAKE) build BASE_URL=http://localhost
	cp DevCaddyfile $(DEST_DIR)/Caddyfile


clean: clean-fa clean-en
	@echo Cleaning destination directories
	rm -rf $(WWW_DIR)
	rm -rf $(TMP_DIR)


dist-clean: clean
	rm -rf $(DEST_DIR)
	rm -rf $(DEST_DIR)/Caddyfile


serve: build-dev serve-it


serve-it:
	export CADDY_POURIYA_ROOT_DIR=$(WWW_DIR) && caddy -root $(WWW_DIR) -conf $(DEST_DIR)/Caddyfile


clean-fa:
	@echo Cleaning Farsi site
	rm -rf $(WWW_DIR)/fa


clean-en:
	@echo Cleaning English site
	rm -rf $(WWW_DIR)/en


ensure-dest-dirs:
	mkdir -p $(DEST_DIR)
	mkdir -p $(WWW_DIR)


ensure-tmp:
	mkdir -p $(TMP_DIR)
