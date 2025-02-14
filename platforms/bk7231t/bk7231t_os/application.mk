TOP_DIR = ../../..

# Initialize tool chain  /usr/bin/gcc-arm-none-eabi-4_9-2015q1/bin
# -------------------------------------------------------------------
TOOLCHAIN_DIR = ../toolchain
GENERATE_DIR = tools/generate
PACKAGE_TOOL_DIR = package_tool
ENCRYPT = ${PACKAGE_TOOL_DIR}/encrypt
BEKEN_PACK = ${PACKAGE_TOOL_DIR}/beken_packager
ARM_GCC_TOOLCHAIN = $(TOOLCHAIN_DIR)/gcc-arm-none-eabi-4_9-2015q1/bin
CROSS_COMPILE = $(ARM_GCC_TOOLCHAIN)/arm-none-eabi-

# Compilation tools
AR = $(CROSS_COMPILE)ar
CC = $(CROSS_COMPILE)gcc
AS = $(CROSS_COMPILE)as
NM = $(CROSS_COMPILE)nm
LD = $(CROSS_COMPILE)gcc
GDB = $(CROSS_COMPILE)gdb
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP = $(CROSS_COMPILE)objdump

# -------------------------------------------------------------------
# Initialize target name and target object files
# -------------------------------------------------------------------
APP_DIR = $(TOP_DIR)/apps/$(APP_NAME)

ifeq ("$(wildcard $(APP_DIR))", "")
$(error Unknown app "$(APP_NAME)")
endif
 
TARGET=Release
OUTPUT=$(APP_DIR)/output/$(APP_VERSION)/$(TARGET)
OBJ_DIR=$(OUTPUT)/obj

$(shell mkdir -p $(OBJ_DIR))


# -------------------------------------------------------------------
# Include folder list
# -------------------------------------------------------------------
INCLUDES =

INCLUDES += -I./beken378/common
INCLUDES += -I./beken378/app
INCLUDES += -I./beken378/app/config
INCLUDES += -I./beken378/app/standalone-station
INCLUDES += -I./beken378/app/standalone-ap
INCLUDES += -I./beken378/ip/common
INCLUDES += -I./beken378/ip/ke/
INCLUDES += -I./beken378/ip/mac/
INCLUDES += -I./beken378/ip/lmac/src/hal
INCLUDES += -I./beken378/ip/lmac/src/mm
INCLUDES += -I./beken378/ip/lmac/src/ps
INCLUDES += -I./beken378/ip/lmac/src/rd
INCLUDES += -I./beken378/ip/lmac/src/rwnx
INCLUDES += -I./beken378/ip/lmac/src/rx
INCLUDES += -I./beken378/ip/lmac/src/scan
INCLUDES += -I./beken378/ip/lmac/src/sta
INCLUDES += -I./beken378/ip/lmac/src/tx
INCLUDES += -I./beken378/ip/lmac/src/vif
INCLUDES += -I./beken378/ip/lmac/src/rx/rxl
INCLUDES += -I./beken378/ip/lmac/src/tx/txl
INCLUDES += -I./beken378/ip/lmac/src/p2p
INCLUDES += -I./beken378/ip/lmac/src/chan
INCLUDES += -I./beken378/ip/lmac/src/td
INCLUDES += -I./beken378/ip/lmac/src/tpc
INCLUDES += -I./beken378/ip/lmac/src/tdls
INCLUDES += -I./beken378/ip/umac/src/mesh
INCLUDES += -I./beken378/ip/umac/src/rc
INCLUDES += -I./beken378/ip/umac/src/apm
INCLUDES += -I./beken378/ip/umac/src/bam
INCLUDES += -I./beken378/ip/umac/src/llc
INCLUDES += -I./beken378/ip/umac/src/me
INCLUDES += -I./beken378/ip/umac/src/rxu
INCLUDES += -I./beken378/ip/umac/src/scanu
INCLUDES += -I./beken378/ip/umac/src/sm
INCLUDES += -I./beken378/ip/umac/src/txu
INCLUDES += -I./beken378/driver/include
INCLUDES += -I./beken378/driver/common/reg
INCLUDES += -I./beken378/driver/entry
INCLUDES += -I./beken378/driver/dma
INCLUDES += -I./beken378/driver/intc
INCLUDES += -I./beken378/driver/phy
INCLUDES += -I./beken378/driver/rc_beken
INCLUDES += -I./beken378/driver/flash
INCLUDES += -I./beken378/driver/rw_pub
INCLUDES += -I./beken378/driver/common/reg
INCLUDES += -I./beken378/driver/common
INCLUDES += -I./beken378/driver/uart
INCLUDES += -I./beken378/driver/sys_ctrl
INCLUDES += -I./beken378/driver/gpio
INCLUDES += -I./beken378/driver/general_dma
INCLUDES += -I./beken378/driver/spidma
INCLUDES += -I./beken378/driver/icu
INCLUDES += -I./beken378/driver/ble 
INCLUDES += -I./beken378/driver/ble/ble_pub/ip/ble/hl/inc 
INCLUDES += -I./beken378/driver/ble/ble_pub/ip/ble/profiles/sdp/api 
INCLUDES += -I./beken378/driver/ble/ble_pub/ip/ble/profiles/comm/api 
INCLUDES += -I./beken378/driver/ble/ble_pub/modules/rwip/api 
INCLUDES += -I./beken378/driver/ble/ble_pub/modules/app/api 
INCLUDES += -I./beken378/driver/ble/ble_pub/modules/common/api 
INCLUDES += -I./beken378/driver/ble/ble_pub/modules/dbg/api 
INCLUDES += -I./beken378/driver/ble/ble_pub/modules/rwip/api 
INCLUDES += -I./beken378/driver/ble/ble_pub/modules/rf/api 
INCLUDES += -I./beken378/driver/ble/ble_pub/modules/ecc_p256/api 
INCLUDES += -I./beken378/driver/ble/ble_pub/plf/refip/src/arch 
INCLUDES += -I./beken378/driver/ble/ble_pub/plf/refip/src/arch/boot 
INCLUDES += -I./beken378/driver/ble/ble_pub/plf/refip/src/arch/compiler 
INCLUDES += -I./beken378/driver/ble/ble_pub/plf/refip/src/arch/ll 
INCLUDES += -I./beken378/driver/ble/ble_pub/plf/refip/src/arch                                                     
INCLUDES += -I./beken378/driver/ble/ble_pub/plf/refip/src/build/ble_full/reg/fw                                    
INCLUDES += -I./beken378/driver/ble/ble_pub/plf/refip/src/driver/reg                                               
INCLUDES += -I./beken378/driver/ble/ble_pub/plf/refip/src/driver/ble_icu                                           
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/hl/inc                                                          
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/hl/api                                                          
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/hl/src/gap/gapc 
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/hl/src/gap/gapm 
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/hl/src/gap/smpc 
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/hl/src/gap/smpm 
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/hl/src/gap 
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/hl/src/gatt/attc 
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/hl/src/gatt/attm 
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/hl/src/gatt/atts 
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/hl/src/gatt 
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/hl/src/gatt/gattc 
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/hl/src/gatt/gattm 
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/hl/src/l2c/l2cc 
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/hl/src/l2c/l2cm 
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/ll/src/rwble                                                    
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/ll/src/lld                                                      
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/ll/src/em                                                       
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/ll/src/llm                                                      
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ble/ll/src/llc                                                      
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/em/api                                                              
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ea/api                                                              
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/hci/api 
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/hci/src                                                             
INCLUDES += -I./beken378/driver/ble/ble_lib/ip/ahi/api                                                             
INCLUDES += -I./beken378/driver/ble/ble_lib/modules/ke/api                                                         
INCLUDES += -I./beken378/driver/ble/ble_lib/modules/ke/src                                                         
INCLUDES += -I./beken378/driver/ble/ble_lib/modules/h4tl/api  
INCLUDES += -I./beken378/func/include
INCLUDES += -I./beken378/func/rf_test
INCLUDES += -I./beken378/func/user_driver
INCLUDES += -I./beken378/func/power_save
INCLUDES += -I./beken378/func/uart_debug
INCLUDES += -I./beken378/func/ethernet_intf
INCLUDES += -I./beken378/func/hostapd-2.5/hostapd
INCLUDES += -I./beken378/func/hostapd-2.5/bk_patch
INCLUDES += -I./beken378/func/hostapd-2.5/src/utils
INCLUDES += -I./beken378/func/hostapd-2.5/src/ap
INCLUDES += -I./beken378/func/hostapd-2.5/src/common
INCLUDES += -I./beken378/func/hostapd-2.5/src/drivers
INCLUDES += -I./beken378/func/hostapd-2.5/src
INCLUDES += -I./beken378/func/lwip_intf/lwip-2.0.2
INCLUDES += -I./beken378/func/lwip_intf/lwip-2.0.2/src
INCLUDES += -I./beken378/func/lwip_intf/lwip-2.0.2/port
INCLUDES += -I./beken378/func/lwip_intf/lwip-2.0.2/src/include
INCLUDES += -I./beken378/func/lwip_intf/lwip-2.0.2/src/include/netif
INCLUDES += -I./beken378/func/lwip_intf/lwip-2.0.2/src/include/lwip
INCLUDES += -I./beken378/func/temp_detect
INCLUDES += -I./beken378/func/spidma_intf
INCLUDES += -I./beken378/func/rwnx_intf
INCLUDES += -I./beken378/func/joint_up
INCLUDES += -I./beken378/func/tuya_pwm
INCLUDES += -I./beken378/os/include
INCLUDES += -I./beken378/os/FreeRTOSv9.0.0/FreeRTOS/Source/portable/Keil/ARM968es
INCLUDES += -I./beken378/os/FreeRTOSv9.0.0/FreeRTOS/Source/include
INCLUDES += -I./beken378/os/FreeRTOSv9.0.0


# -------------------------------------------------------------------
# Source file list
# -------------------------------------------------------------------
SRC_C =
DRAM_C =
SRC_OS =

#application layer
SRC_C += ./beken378/app/app_bk.c
SRC_C += ./beken378/app/ate_app.c
SRC_C += ./beken378/app/config/param_config.c
SRC_C += ./beken378/app/standalone-ap/sa_ap.c
SRC_C += ./beken378/app/standalone-station/sa_station.c

#demo module
SRC_C += ./beken378/demo/ieee802_11_demo.c

#driver layer
SRC_C += ./beken378/driver/common/dd.c
SRC_C += ./beken378/driver/common/drv_model.c
SRC_C += ./beken378/driver/dma/dma.c
SRC_C += ./beken378/driver/driver.c
SRC_C += ./beken378/driver/entry/arch_main.c
SRC_C += ./beken378/driver/fft/fft.c
SRC_C += ./beken378/driver/flash/flash.c
SRC_C += ./beken378/driver/general_dma/general_dma.c
SRC_C += ./beken378/driver/gpio/gpio.c
SRC_C += ./beken378/driver/i2s/i2s.c
SRC_C += ./beken378/driver/icu/icu.c
SRC_C += ./beken378/driver/intc/intc.c
SRC_C += ./beken378/driver/irda/irda.c
SRC_C += ./beken378/driver/macphy_bypass/mac_phy_bypass.c
SRC_C += ./beken378/driver/phy/phy_trident.c
SRC_C += ./beken378/driver/pwm/pwm.c
SRC_C += ./beken378/driver/pwm/mcu_ps_timer.c
SRC_C += ./beken378/driver/pwm/bk_timer.c
SRC_C += ./beken378/driver/rw_pub/rw_platf_pub.c
SRC_C += ./beken378/driver/saradc/saradc.c
SRC_C += ./beken378/driver/spi/spi.c
SRC_C += ./beken378/driver/spidma/spidma.c
SRC_C += ./beken378/driver/sys_ctrl/sys_ctrl.c
SRC_C += ./beken378/driver/uart/Retarget.c
SRC_C += ./beken378/driver/uart/uart_bk.c
SRC_C += ./beken378/driver/wdt/wdt.c
SRC_C += ./beken378/driver/ble/ble.c
SRC_C += ./beken378/driver/ble/ble_pub/ip/ble/hl/src/prf/prf.c
SRC_C += ./beken378/driver/ble/ble_pub/ip/ble/profiles/sdp/src/sdp_service.c
SRC_C += ./beken378/driver/ble/ble_pub/ip/ble/profiles/sdp/src/sdp_service_task.c
SRC_C += ./beken378/driver/ble/ble_pub/ip/ble/profiles/comm/src/comm.c
SRC_C += ./beken378/driver/ble/ble_pub/ip/ble/profiles/comm/src/comm_task.c
SRC_C += ./beken378/driver/ble/ble_pub/modules/app/src/app_ble.c
SRC_C += ./beken378/driver/ble/ble_pub/modules/app/src/app_task.c
SRC_C += ./beken378/driver/ble/ble_pub/modules/app/src/app_sdp.c
SRC_C += ./beken378/driver/ble/ble_pub/modules/app/src/app_sec.c
SRC_C += ./beken378/driver/ble/ble_pub/modules/app/src/app_comm.c
SRC_C += ./beken378/driver/ble/ble_pub/modules/common/src/common_list.c
SRC_C += ./beken378/driver/ble/ble_pub/modules/common/src/common_utils.c
SRC_C += ./beken378/driver/ble/ble_pub/modules/common/src/RomCallFlash.c
SRC_C += ./beken378/driver/ble/ble_pub/modules/dbg/src/dbg.c
SRC_C += ./beken378/driver/ble/ble_pub/modules/dbg/src/dbg_mwsgen.c
SRC_C += ./beken378/driver/ble/ble_pub/modules/dbg/src/dbg_swdiag.c
SRC_C += ./beken378/driver/ble/ble_pub/modules/dbg/src/dbg_task.c
SRC_C += ./beken378/driver/ble/ble_pub/modules/rwip/src/rwip.c
SRC_C += ./beken378/driver/ble/ble_pub/modules/rf/src/ble_rf_xvr.c
SRC_C += ./beken378/driver/ble/ble_pub/modules/ecc_p256/src/ecc_p256.c
SRC_C += ./beken378/driver/ble/ble_pub/plf/refip/src/driver/uart/uart.c           

#function layer
SRC_C += ./beken378/func/func.c
SRC_C += ./beken378/func/bk7011_cal/bk7231U_cal.c
SRC_C += ./beken378/func/bk7011_cal/manual_cal_bk7231U.c
SRC_C += ./beken378/func/joint_up/role_launch.c
SRC_C += ./beken378/func/hostapd_intf/hostapd_intf.c
SRC_C += ./beken378/func/hostapd-2.5/bk_patch/ddrv.c
SRC_C += ./beken378/func/hostapd-2.5/bk_patch/signal.c
SRC_C += ./beken378/func/hostapd-2.5/bk_patch/sk_intf.c
SRC_C += ./beken378/func/hostapd-2.5/bk_patch/fake_socket.c
SRC_C += ./beken378/func/hostapd-2.5/hostapd/main_none.c
SRC_C += ./beken378/func/hostapd-2.5/src/crypto/aes-internal.c
SRC_C += ./beken378/func/hostapd-2.5/src/crypto/aes-internal-dec.c
SRC_C += ./beken378/func/hostapd-2.5/src/crypto/aes-internal-enc.c
SRC_C += ./beken378/func/hostapd-2.5/src/crypto/aes-unwrap.c
SRC_C += ./beken378/func/hostapd-2.5/src/crypto/aes-wrap.c
SRC_C += ./beken378/func/hostapd-2.5/src/crypto/bk_md5.c
SRC_C += ./beken378/func/hostapd-2.5/src/crypto/md5-internal.c
SRC_C += ./beken378/func/hostapd-2.5/src/crypto/rc4.c
SRC_C += ./beken378/func/hostapd-2.5/src/crypto/bk_sha1.c
SRC_C += ./beken378/func/hostapd-2.5/src/crypto/sha1-internal.c
SRC_C += ./beken378/func/hostapd-2.5/src/crypto/sha1-pbkdf2.c
SRC_C += ./beken378/func/hostapd-2.5/src/crypto/sha1-prf.c
SRC_C += ./beken378/func/hostapd-2.5/src/crypto/tls_none.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/ap_config.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/ap_drv_ops.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/ap_list.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/ap_mlme.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/beacon.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/drv_callbacks.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/hostapd.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/hw_features.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/ieee802_11_auth.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/ieee802_11.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/ieee802_11_ht.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/ieee802_11_shared.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/ieee802_1x.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/sta_info.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/tkip_countermeasures.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/utils.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/wmm.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/wpa_auth.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/wpa_auth_glue.c
SRC_C += ./beken378/func/hostapd-2.5/src/ap/wpa_auth_ie.c
SRC_C += ./beken378/func/hostapd-2.5/src/common/hw_features_common.c
SRC_C += ./beken378/func/hostapd-2.5/src/common/ieee802_11_common.c
SRC_C += ./beken378/func/hostapd-2.5/src/common/wpa_common.c
SRC_C += ./beken378/func/hostapd-2.5/src/drivers/driver_beken.c
SRC_C += ./beken378/func/hostapd-2.5/src/drivers/driver_common.c
SRC_C += ./beken378/func/hostapd-2.5/src/drivers/drivers.c
SRC_C += ./beken378/func/hostapd-2.5/src/l2_packet/l2_packet_none.c
SRC_C += ./beken378/func/hostapd-2.5/src/rsn_supp/wpa.c
SRC_C += ./beken378/func/hostapd-2.5/src/rsn_supp/wpa_ie.c
SRC_C += ./beken378/func/hostapd-2.5/src/utils/common.c
SRC_C += ./beken378/func/hostapd-2.5/src/utils/eloop.c
SRC_C += ./beken378/func/hostapd-2.5/src/utils/os_none.c
SRC_C += ./beken378/func/hostapd-2.5/src/utils/wpabuf.c
SRC_C += ./beken378/func/hostapd-2.5/wpa_supplicant/blacklist.c
SRC_C += ./beken378/func/hostapd-2.5/wpa_supplicant/bss.c
SRC_C += ./beken378/func/hostapd-2.5/wpa_supplicant/config.c
SRC_C += ./beken378/func/hostapd-2.5/wpa_supplicant/config_none.c
SRC_C += ./beken378/func/hostapd-2.5/wpa_supplicant/events.c
SRC_C += ./beken378/func/hostapd-2.5/wpa_supplicant/main_supplicant.c
SRC_C += ./beken378/func/hostapd-2.5/wpa_supplicant/notify.c
SRC_C += ./beken378/func/hostapd-2.5/wpa_supplicant/wmm_ac.c
SRC_C += ./beken378/func/hostapd-2.5/wpa_supplicant/wpa_scan.c
SRC_C += ./beken378/func/hostapd-2.5/wpa_supplicant/wpas_glue.c
SRC_C += ./beken378/func/hostapd-2.5/wpa_supplicant/wpa_supplicant.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/port/ethernetif.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/port/net.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/port/sys_arch.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/api/api_lib.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/api/api_msg.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/api/err.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/api/netbuf.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/api/netdb.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/api/netifapi.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/api/sockets.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/api/tcpip.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/def.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/dns.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/inet_chksum.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/init.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/ip.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/ipv4/autoip.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/ipv4/dhcp.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/ipv4/etharp.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/ipv4/icmp.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/ipv4/igmp.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/ipv4/ip4_addr.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/ipv4/ip4.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/ipv4/ip4_frag.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/ipv6/dhcp6.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/ipv6/ethip6.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/ipv6/icmp6.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/ipv6/inet6.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/ipv6/ip6_addr.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/ipv6/ip6.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/ipv6/ip6_frag.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/ipv6/mld6.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/ipv6/nd6.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/mem.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/memp.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/netif.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/pbuf.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/raw.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/stats.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/sys.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/tcp.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/tcp_in.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/tcp_out.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/timeouts.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/core/udp.c
SRC_C += ./beken378/func/lwip_intf/lwip-2.0.2/src/netif/ethernet.c
SRC_C += ./beken378/func/lwip_intf/dhcpd/dhcp-server.c
SRC_C += ./beken378/func/lwip_intf/dhcpd/dhcp-server-main.c
SRC_C += ./beken378/func/misc/fake_clock.c
SRC_C += ./beken378/func/misc/target_util.c
SRC_C += ./beken378/func/misc/start_type.c
SRC_C += ./beken378/func/power_save/power_save.c
SRC_C += ./beken378/func/power_save/manual_ps.c
SRC_C += ./beken378/func/power_save/mcu_ps.c
SRC_C += ./beken378/func/rf_test/rx_sensitivity.c
SRC_C += ./beken378/func/rf_test/tx_evm.c
SRC_C += ./beken378/func/rwnx_intf/rw_ieee80211.c
SRC_C += ./beken378/func/rwnx_intf/rw_msdu.c
SRC_C += ./beken378/func/rwnx_intf/rw_msg_rx.c
SRC_C += ./beken378/func/rwnx_intf/rw_msg_tx.c
SRC_C += ./beken378/func/sim_uart/gpio_uart.c
SRC_C += ./beken378/func/sim_uart/pwm_uart.c
SRC_C += ./beken378/func/spidma_intf/spidma_intf.c
SRC_C += ./beken378/func/temp_detect/temp_detect.c
SRC_C += ./beken378/func/uart_debug/cmd_evm.c
SRC_C += ./beken378/func/uart_debug/cmd_help.c
SRC_C += ./beken378/func/uart_debug/cmd_reg.c
SRC_C += ./beken378/func/uart_debug/cmd_rx_sensitivity.c
SRC_C += ./beken378/func/uart_debug/command_line.c
SRC_C += ./beken378/func/uart_debug/command_table.c
SRC_C += ./beken378/func/uart_debug/udebug.c
SRC_C += ./beken378/func/user_driver/BkDriverFlash.c
SRC_C += ./beken378/func/user_driver/BkDriverRng.c
SRC_C += ./beken378/func/user_driver/BkDriverGpio.c
SRC_C += ./beken378/func/user_driver/BkDriverPwm.c
SRC_C += ./beken378/func/user_driver/BkDriverUart.c
SRC_C += ./beken378/func/user_driver/BkDriverWdg.c
SRC_C += ./beken378/func/user_driver/BkDriverTimer.c
SRC_C += ./beken378/func/wlan_ui/wlan_cli.c
SRC_C += ./beken378/func/wlan_ui/wlan_ui.c
SRC_C += ./beken378/func/tuya_pwm/tuya_pwm.c

#operation system module
SRC_OS += ./beken378/os/FreeRTOSv9.0.0/FreeRTOS/Source/croutine.c
SRC_OS += ./beken378/os/FreeRTOSv9.0.0/FreeRTOS/Source/event_groups.c
SRC_OS += ./beken378/os/FreeRTOSv9.0.0/FreeRTOS/Source/list.c
SRC_OS += ./beken378/os/FreeRTOSv9.0.0/FreeRTOS/Source/portable/Keil/ARM968es/port.c
SRC_OS += ./beken378/os/FreeRTOSv9.0.0/FreeRTOS/Source/portable/MemMang/heap_4.c
SRC_OS += ./beken378/os/FreeRTOSv9.0.0/FreeRTOS/Source/queue.c
SRC_OS += ./beken378/os/FreeRTOSv9.0.0/FreeRTOS/Source/tasks.c
SRC_OS += ./beken378/os/FreeRTOSv9.0.0/FreeRTOS/Source/timers.c
SRC_OS += ./beken378/os/FreeRTOSv9.0.0/rtos_pub.c
SRC_C += ./beken378/os/mem_arch.c
SRC_C += ./beken378/os/str_arch.c

#assembling files
SRC_S = 
SRC_S +=  ./beken378/driver/entry/boot_handlers.S
SRC_S +=  ./beken378/driver/entry/boot_vectors.S

# Generate obj list
# -------------------------------------------------------------------
SRC_O = $(patsubst %.c,%.o,$(SRC_C))
SRC_C_LIST = $(notdir $(SRC_C)) $(notdir $(DRAM_C))
OBJ_LIST = $(addprefix $(OBJ_DIR)/,$(patsubst %.c,%.o,$(SRC_C_LIST)))
DEPENDENCY_LIST = $(addprefix $(OBJ_DIR)/,$(patsubst %.c,%.d,$(SRC_C_LIST)))

SRC_S_O = $(patsubst %.S,%.o,$(SRC_S))
SRC_S_LIST = $(notdir $(SRC_S)) 
OBJ_S_LIST = $(addprefix $(OBJ_DIR)/,$(patsubst %.S,%.o,$(SRC_S_LIST)))
DEPENDENCY_S_LIST = $(addprefix $(OBJ_DIR)/,$(patsubst %.S,%.d,$(SRC_S_LIST)))

SRC_OS_O = $(patsubst %.c,%.o,$(SRC_OS))
SRC_OS_LIST = $(notdir $(SRC_OS)) 
OBJ_OS_LIST = $(addprefix $(OBJ_DIR)/,$(patsubst %.c,%.o,$(SRC_OS_LIST)))
DEPENDENCY_OS_LIST = $(addprefix $(OBJ_DIR)/,$(patsubst %.c,%.d,$(SRC_OS_LIST)))

# Compile options
# -------------------------------------------------------------------
CFLAGS = -Werror
CFLAGS += -g -mthumb -mcpu=arm968e-s -march=armv5te -mthumb-interwork -mlittle-endian -Os -std=c99 -ffunction-sections -Wall -fsigned-char -fdata-sections -Wunknown-pragmas -nostdlib -Wno-unused-function -Wno-unused-but-set-variable

OSFLAGS = -Werror
OSFLAGS += -g -marm -mcpu=arm968e-s -march=armv5te -mthumb-interwork -mlittle-endian -Os -std=c99 -ffunction-sections -Wall -fsigned-char -fdata-sections -Wunknown-pragmas

ASMFLAGS = 
ASMFLAGS += -g -marm -mthumb-interwork -mcpu=arm968e-s -march=armv5te -x assembler-with-cpp

LFLAGS = 
LFLAGS += -g -Wl,--gc-sections -marm -mcpu=arm968e-s -mthumb-interwork -nostdlib -Xlinker -Map=$(OUTPUT)/$(APP_NAME).map  -Wl,-wrap,malloc -Wl,-wrap,free -Wl,-wrap,zalloc

LIBFLAGS =
LIBFLAGS += -L./beken378/lib/ -lrwnx
LIBFLAGS += -L./beken378/lib/ -lble

# Compile

APP_SRC_DIRS += $(shell find $(TOP_DIR)/apps/$(APP_NAME)/src -type d)

SRC_C += $(foreach dir, $(APP_SRC_DIRS), $(wildcard $(dir)/*.c)) # need export
SRC_C += $(foreach dir, $(APP_SRC_DIRS), $(wildcard $(dir)/*.cpp)) 
SRC_C += $(foreach dir, $(APP_SRC_DIRS), $(wildcard $(dir)/*.s)) 
SRC_C += $(foreach dir, $(APP_SRC_DIRS), $(wildcard $(dir)/*.S)) 

APP_INC_DIRS += $(shell find $(TOP_DIR)/apps/$(APP_NAME)/include -type d)

INCLUDES += $(foreach base_dir, $(APP_INC_DIRS), $(addprefix -I , $(base_dir))) 

APP_BASE = $(OUTPUT)/$(APP_NAME)_$(APP_VERSION)
UA_BIN = ${APP_NAME}_UA_${APP_VERSION}.bin
CUR_PATH = $(shell pwd)	

.PHONY: app
app: ua_bin

ua_bin: $(OUTPUT)/${UA_BIN}
	@:

$(OUTPUT)/${UA_BIN}: $(APP_BASE).map $(APP_BASE).asm $(APP_BASE).bin ${GENERATE_DIR}/mpytools.py
	@echo "CRC $(notdir $@)"  
	@cd ${GENERATE_DIR};./${ENCRYPT} ../../${APP_BASE}.bin 510fb093 a3cbeadc 5993a17e c7adeb03 10000 >/dev/null
	@cd ${GENERATE_DIR}; python mpytools.py ../../${APP_BASE}_enc.bin ${APP_VERSION}
	@cd ${GENERATE_DIR};./${BEKEN_PACK} config.json >/dev/null
	@mv ${GENERATE_DIR}/all_${APP_VERSION}.bin $(OUTPUT)/${APP_NAME}_QIO_${APP_VERSION}.bin
	@mv ${GENERATE_DIR}/${APP_NAME}_${APP_VERSION}_enc_uart_${APP_VERSION}.bin $(OUTPUT)/${UA_BIN}
	@cp $(OUTPUT)/${UA_BIN} /media/sf_Downloads/tuya

$(APP_BASE).bin: %.bin: %.axf
	@echo "DUMP $(notdir $@)"
	@$(OBJCOPY) -O binary $< $@

$(APP_BASE).asm: %.asm : %.axf
	@echo "DUMP $(notdir $@)"
	@$(OBJDUMP) -d $< > $@
	
$(APP_BASE).map: %.map : %.axf
	@echo "NM $(notdir $@)"
	@$(NM) $< | sort > $@

$(APP_BASE).axf: $(SRC_O) $(SRC_S_O) $(SRC_OS_O)
	@echo "LD $(notdir $@)"
	@$(LD) $(LFLAGS) -o $@  $(OBJ_LIST) $(OBJ_S_LIST) $(OBJ_OS_LIST) $(LIBFLAGS) -T./beken378/build/bk7231_ota.ld

$(SRC_O): %.o : %.c
	@echo CC $<
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -MM -MT $@ -MF $(OBJ_DIR)/$(notdir $(patsubst %.o,%.d,$@))
	@cp $@ $(OBJ_DIR)/$(notdir $@)
	@chmod 777 $(OBJ_DIR)/$(notdir $@)

$(SRC_S_O): %.o : %.S
	@echo AS $<
	@$(CC) $(ASMFLAGS) $(INCLUDES) -c $< -o $@
	@$(CC) $(ASMFLAGS) $(INCLUDES) -c $< -MM -MT $@ -MF $(OBJ_DIR)/$(notdir $(patsubst %.o,%.d,$@))
	@cp $@ $(OBJ_DIR)/$(notdir $@)
	@chmod 777 $(OBJ_DIR)/$(notdir $@)

$(SRC_OS_O): %.o : %.c
	@echo CC $<
	@$(CC) $(OSFLAGS) $(INCLUDES) -c $< -o $@
	@$(CC) $(OSFLAGS) $(INCLUDES) -c $< -MM -MT $@ -MF $(OBJ_DIR)/$(notdir $(patsubst %.o,%.d,$@))
	@cp $@ $(OBJ_DIR)/$(notdir $@)
	@chmod 777 $(OBJ_DIR)/$(notdir $@)

-include $(DEPENDENCY_LIST)
-include $(DEPENDENCY_S_LIST)
-include $(DEPENDENCY_OS_LIST)


.PHONY: clean
clean:
	@rm -rf $(TARGET)
	@rm -f $(SRC_O)
	@rm -f $(SRC_S_O)
	@rm -f $(SRC_OS_O)
	@rm -rf $(OUTPUT)

