#
# Copyright (C) 2021 The Android Open Source Project
# Copyright (C) 2021 The TWRP Open Source Project
# Copyright (C) 2021 SebaUbuntu's TWRP device tree generator 
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit some common Omni stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Virtual A/B OTA
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Inherit Telephony packages
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit language packages
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Inherit 64bit support
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

PRODUCT_USE_DYNAMIC_PARTITION := true

# A/B
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    lk \
    preloader \
    product \
    system \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# V A/B
ENABLE_VIRTUAL_AB := true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl-recovery \
    android.hardware.boot@1.1-impl \
    bootctrl.$(PRODUCT_PLATFORM).recovery

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload \
    bootctl

# VNDK
PRODUCT_TARGET_VNDK_VERSION := 30

# API
PRODUCT_SHIPPING_API_LEVEL := 30

# Health Hal
PRODUCT_PACKAGES += \
     android.hardware.health@2.1-impl

TW_OVERRIDE_SYSTEM_PROPS := \
    "ro.build.product;ro.build.fingerprint;ro.build.version.incremental;ro.product.device=ro.product.system.device;ro.product.model=ro.product.system.model;ro.product.name=ro.product.system.name"

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := selene
PRODUCT_NAME := omni_selene
PRODUCT_BRAND := xiaomi
PRODUCT_MODEL := Redmi 10
PRODUCT_MANUFACTURER := xiaomi
PRODUCT_RELEASE_NAME := Redmi 10
