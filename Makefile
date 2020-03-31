HUGO_RECOMMENDED_OPTS = --gc --verbose
HUGO_OPTS             =
DEST_DIR              = $(CURDIR)/www
BASE_URL              = https://pouriya.org
HUGO_GLOBAL_CONFIG    = $(CURDIR)/src/global.toml
TMP_DIR               = $(CURDIR)/tmp
HUGO_TMP_CONFIG_FA    = $(TMP_DIR)/fa.toml
HUGO_TMP_CONFIG_EN    = $(TMP_DIR)/en.toml


.PHONY: build fa en build-dev clean serve serve-it clean-fa clean-en ensure-dest-dir


build: fa en


fa: ensure-dest-dir clean-fa make-fa-config
	@echo Building Farsi site for $(BASE_URL)
	cd src/fa && hugo -b $(BASE_URL)/fa $(HUGO_RECOMMENDED_OPTS) --destination $(DEST_DIR)/fa $(HUGO_OPTS) --config $(HUGO_TMP_CONFIG_FA)


make-fa-config: ensure-tmp
	rm -rf $(HUGO_TMP_CONFIG_FA)
	touch $(HUGO_TMP_CONFIG_FA)
	cat $(HUGO_GLOBAL_CONFIG) >> $(HUGO_TMP_CONFIG_FA)
	cat src/fa/config.toml | awk '{gsub("BASEURL", "$(BASE_URL)", $$0); print $$0}' >> $(HUGO_TMP_CONFIG_FA)


en: ensure-dest-dir clean-en make-en-config
	@ echo Building English site for $(BASE_URL)
	cd src/en && hugo -b $(BASE_URL)/en $(HUGO_RECOMMENDED_OPTS) --destination $(DEST_DIR)/en $(HUGO_OPTS) --config $(HUGO_TMP_CONFIG_EN)


make-en-config: ensure-tmp
	rm -rf $(HUGO_TMP_CONFIG_EN)
	touch $(HUGO_TMP_CONFIG_EN)
	cat $(HUGO_GLOBAL_CONFIG) >> $(HUGO_TMP_CONFIG_EN)
	cat src/en/config.toml | awk '{gsub("BASEURL", "$(BASE_URL)", $$0); print $$0}' >> $(HUGO_TMP_CONFIG_EN)


build-dev:
	$(MAKE) build BASE_URL=http://localhost


clean: clean-fa clean-en
	@echo Cleaning destination directory
	rm -rf $(DEST_DIR)
	rm -rf $(TMP_DIR)


serve: build-dev serve-it


serve-it:
	export DEST_DIR=$(DEST_DIR) && caddy -root $(DEST_DIR) -conf DevCaddyfile


clean-fa:
	@echo Cleaning Farsi site
	rm -rf $(DEST_DIR)/fa


clean-en:
	@echo Cleaning English site
	rm -rf $(DEST_DIR)/en


ensure-dest-dir:
	mkdir -p $(DEST_DIR)


ensure-tmp:
	mkdir -p $(TMP_DIR)
