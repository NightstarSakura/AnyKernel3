# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=boot;
is_slot_device=auto;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;
no_block_display=1

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## Select the correct image to flash
userflavor="$(file_getprop /system/build.prop "ro.build.flavor")";
case "$userflavor" in
    qssi-user) os="miui"; os_string="MIUI ROM";;
esac;
ui_print "  -> $os_string is detected!";
if [ -f $home/kernels/$os/Image.gz ] ; then
    mv $home/kernels/$os/Image.gz $home/Image;
else
    ui_print "  -> There is no kernel for your OS in this zip! Aborting...";
    exit 1;
fi;
if [ -f $home/kernels/$os/dtb ] ; then
    mv $home/kernels/$os/dtb $home/dtb;
fi;
if [ -f $home/kernels/$os/dtbo.img ] ; then
    mv $home/kernels/$os/dtbo.img $home/dtbo.img;
fi;

## AnyKernel boot install
split_boot;

flash_boot;
flash_dtbo;
## end boot install

# Vendor boot
#block=vendor_boot;
#is_slot_device=1;
#ramdisk_compression=auto;
#patch_vbmeta_flag=auto;

# reset for vendor_boot patching
#reset_ak;

## AnyKernel vendor_boot install
#split_boot;

#flash_boot;
## end vendor_boot install
