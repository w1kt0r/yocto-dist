PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
SHELL=/bin/bash
BOARD ?= odroidc2

.PHONY: sourceme
sourceme:
	@source ${PWD}/layers/3pp/poky/oe-init-build-env ${PWD}/build_${BOARD} > /dev/null

.PHONY: setup
setup: sourceme
	@cp -rf ${PWD}/layers/templates/bblayers/${BOARD}.conf ${PWD}/build_${BOARD}/conf/bblayers.conf
	@cp -rf ${PWD}/layers/templates/local/${BOARD}.conf ${PWD}/build_${BOARD}/conf/local.conf
	@sed -i 's@+pwd+@${PWD}@g' ${PWD}/build_${BOARD}/conf/bblayers.conf
	@sed -i 's@+pwd+@${PWD}@g' ${PWD}/build_${BOARD}/conf/local.conf

.PHONY: cleanall
cleanall:
	@rm -rf ${PWD}/build_${BOARD}

.PHONY: bitbake-env
bitbake-env: setup
	$(shell /bin/bash -c "source ${PWD}/layers/3pp/poky/oe-init-build-env ${PWD}/build_${BOARD}")
