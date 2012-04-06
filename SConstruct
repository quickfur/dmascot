#!/usr/bin/scons

noalpha = ARGUMENTS.get('noalpha', 0)

povray = '/usr/bin/povray'
povray_flags = '-D +W500 +H500 +AM2 +A0.3'

if not noalpha:
	povray_flags = povray_flags + ' +UA'

env = Environment(
	POVRAY = povray,
	POVRAY_FLAGS = povray_flags
)

env.Command('mascot.png', 'mascot.pov',
	"""$POVRAY $POVRAY_FLAGS +I$SOURCE +O$TARGET"""
)
