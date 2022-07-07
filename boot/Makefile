CURL := curl

WORK_DIR := /tmp/pyrogen
KERNEL_VERSION := 5.10.128
KCONFIG_VERSION := 5.10.77

KERNEL_URL := https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$(KERNEL_VERSION).tar.xz
KERNEL_LOCAL_ARCHIVE := $(WORK_DIR)/linux-$(KERNEL_VERSION).tar.xz

KCONFIG_URL := https://raw.githubusercontent.com/weaveworks/ignite/main/images/kernel/versioned/config-amd64-$(KCONFIG_VERSION)
KCONFIG_LOCAL_FILE := $(WORK_DIR)/config-$(KCONFIG_VERSION)

check:
	$(CURL) --version | head -1

clean:
	rm -rf $(WORK_DIR)

init:
	sudo apt-get -y -qq install make gcc flex bison libelf-dev libssl-dev bc

prep: init
	mkdir -p $(WORK_DIR)
	test -f $(KERNEL_LOCAL_ARCHIVE) || $(CURL) -m 60 -L -o $(KERNEL_LOCAL_ARCHIVE) $(KERNEL_URL)
	test -d $(WORK_DIR)/linux-$(KERNEL_VERSION) || tar xf $(KERNEL_LOCAL_ARCHIVE) -C $(WORK_DIR)
	test -f $(KCONFIG_LOCAL_FILE) || $(CURL) -m 60 -L -o $(KCONFIG_LOCAL_FILE) $(KCONFIG_URL)

vmlinux: prep
	echo "# pyrogen config" >> $(KCONFIG_LOCAL_FILE)
	echo "CONFIG_BPF_UNPRIV_DEFAULT_OFF=n" >> $(KCONFIG_LOCAL_FILE)
	echo "CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=n" >> $(KCONFIG_LOCAL_FILE)
	echo "CONFIG_KCSAN=n" >> $(KCONFIG_LOCAL_FILE)
	echo "CONFIG_KASAN=n" >> $(KCONFIG_LOCAL_FILE)
	cp $(KCONFIG_LOCAL_FILE) $(WORK_DIR)/linux-$(KERNEL_VERSION)/.config
	cd $(WORK_DIR)/linux-$(KERNEL_VERSION) && make vmlinux

.PHONY: check clean init prep vmlinux
