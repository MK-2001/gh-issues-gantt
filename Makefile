MIN_NPM_VER_MAJOR=6
MIN_NPM_VER_MINOR=1
MIN_NPM_VER_PATCH=0

CUR_NPM_VER := $(shell npm -v)
CUR_NPM_VER_MAJOR := $(shell echo $(CUR_NPM_VER) | cut -f1 -d.)
CUR_NPM_VER_MINOR := $(shell echo $(CUR_NPM_VER) | cut -f2 -d.)
CUR_NPM_VER_PATCH := $(shell echo $(CUR_NPM_VER) | cut -f3 -d.)
IS_NPM_OK := $(shell [ $(CUR_NPM_VER_MAJOR) -gt $(MIN_NPM_VER_MAJOR) -o \( $(CUR_NPM_VER_MAJOR) -eq $(MIN_NPM_VER_MAJOR) -a \( $(CUR_NPM_VER_MINOR) -gt $(MIN_NPM_VER_MINOR) -o \( $(CUR_NPM_VER_MINOR) -eq $(MIN_NPM_VER_MINOR) -a $(CUR_NPM_VER_PATCH) -ge $(MIN_NPM_VER_PATCH) \)  \) \) ] && echo true)


all: install

install:
	make build

check_npm_version:
ifneq ($(IS_NPM_OK),true)
	$(error npm-v$(MIN_NPM_VER_MAJOR).$(MIN_NPM_VER_MINOR).$(MIN_NPM_VER_PATCH)+ required)
endif

prd_depend: package.json package-lock.json check_npm_version
	npm ci

build: prd_depend
	node server.js

.PHONY: all build depend check_npm_version  build
