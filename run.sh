#!/bin/bash -ex

if [ -z "$INPUT_PKGBUILD" ] || [ -z "$INPUT_OUTDIR" ] || [ -z "$GITHUB_SHA" ]; then
    echo 'Missing environment variables'
    exit 1
fi

# Resolve environment paths
INPUT_PKGBUILD="$(eval echo $INPUT_PKGBUILD)"
INPUT_OUTDIR="$(eval echo $INPUT_OUTDIR)"

# Prepare the environment
pacman -Syu --noconfirm --noprogressbar --needed base-devel devtools btrfs-progs dbus sudo

dbus-uuidgen --ensure=/etc/machine-id

useradd -m user
cd /home/user

sed -i "s|MAKEFLAGS=.*|MAKEFLAGS=-j$(nproc)|" /etc/makepkg.conf

sed "s|%COMMIT%|$GITHUB_SHA|" "$INPUT_PKGBUILD" > "$GITHUB_WORKSPACE"/PKGBUILD

# Build the package
extra-x86_64-build -- -U user

# Save the artifacts
mkdir -p "$INPUT_OUTDIR"
cp *.pkg.* "$INPUT_OUTDIR"/
