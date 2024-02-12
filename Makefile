TOOLCHAIN="+nightly-2023-08-15-x86_64-unknown-linux-gnu"

ifdef DADK_CURRENT_BUILD_DIR
# 如果是在dadk中编译，那么安装到dadk的安装目录中
	INSTALL_DIR = $(DADK_CURRENT_BUILD_DIR)
else
# 如果是在本地编译，那么安装到当前目录下的install目录中
	INSTALL_DIR = ./install
endif

ifeq ($(ARCH), x86_64)
	export RUST_TARGET=x86_64-unknown-linux-musl
else ifeq ($(ARCH), riscv64)
	export RUST_TARGET=riscv64gc-unknown-linux-gnu
else 
# 默认为x86_86，用于本地编译
	export RUST_TARGET=x86_64-unknown-linux-musl
endif

run:
	cargo $(TOOLCHAIN) run --target $(RUST_TARGET)

build:
	cargo $(TOOLCHAIN) build --target $(RUST_TARGET)

clean:
	cargo $(TOOLCHAIN) clean --target $(RUST_TARGET)

test:
	cargo $(TOOLCHAIN) test --target $(RUST_TARGET)

doc:
	cargo $(TOOLCHAIN) doc --target $(RUST_TARGET)

fmt:
	cargo $(TOOLCHAIN) fmt

fmt-check:
	cargo $(TOOLCHAIN) fmt --check

run-release:
	cargo $(TOOLCHAIN) run --target $(RUST_TARGET) --release

build-release:
	cargo $(TOOLCHAIN) build --target $(RUST_TARGET) --release

clean-release:
	cargo $(TOOLCHAIN) clean --target $(RUST_TARGET) --release

test-release:
	cargo $(TOOLCHAIN) test --target $(RUST_TARGET) --release

.PHONY: install
install:
	cargo $(TOOLCHAIN) install --target $(RUST_TARGET) --path . --no-track --root $(INSTALL_DIR) --force
