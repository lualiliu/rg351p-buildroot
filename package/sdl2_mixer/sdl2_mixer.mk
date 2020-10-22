################################################################################
#
# sdl2_mixer
#
################################################################################

SDL2_MIXER_VERSION = 2.0.4
SDL2_MIXER_SOURCE = SDL2_mixer-$(SDL2_MIXER_VERSION).tar.gz
SDL2_MIXER_SITE = http://www.libsdl.org/projects/SDL_mixer/release
SDL2_MIXER_LICENSE = Zlib
SDL2_MIXER_LICENSE_FILES = COPYING.txt
SDL2_MIXER_INSTALL_STAGING = YES
SDL2_MIXER_DEPENDENCIES = sdl2 host-pkgconf

SDL2_MIXER_CONF_OPTS = --disable-music-mp3

ifeq ($(BR2_PACKAGE_FLAC),y)
SDL2_MIXER_CONF_OPTS += --enable-music-flac
SDL2_MIXER_DEPENDENCIES += flac
else
SDL2_MIXER_CONF_OPTS += --disable-music-flac
endif

ifeq ($(BR2_PACKAGE_FLUIDSYNTH),y)
SDL2_MIXER_CONF_OPTS += --enable-music-midi-fluidsynth
SDL2_MIXER_DEPENDENCIES += fluidsynth
else
SDL2_MIXER_CONF_OPTS += --disable-music-midi-fluidsynth
endif

# Prefer libmikmod over Modplug due to dependency on C++
ifeq ($(BR2_PACKAGE_LIBMIKMOD),y)
SDL2_MIXER_CONF_OPTS += --enable-music-mod
SDL2_MIXER_DEPENDENCIES += libmikmod
else
ifeq ($(BR2_PACKAGE_LIBMODPLUG),y)
SDL2_MIXER_CONF_OPTS += --enable-music-mod-modplug
SDL2_MIXER_DEPENDENCIES += libmodplug
else
SDL2_MIXER_CONF_OPTS += --disable-music-mod-modplug
endif
endif

ifeq ($(BR2_PACKAGE_OPUSFILE),y)
SDL2_MIXER_CONF_OPTS += --enable-music-opus
SDL2_MIXER_DEPENDENCIES += opusfile
else
SDL2_MIXER_CONF_OPTS += --disable-music-opus
endif

ifeq ($(BR2_PACKAGE_TREMOR),y)
SDL2_MIXER_CONF_OPTS += --enable-music-ogg-tremor
SDL2_MIXER_DEPENDENCIES += tremor
else
SDL2_MIXER_CONF_OPTS += --disable-music-ogg-tremor
endif

$(eval $(autotools-package))
