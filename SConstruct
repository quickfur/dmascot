#!/usr/bin/scons

noalpha = ARGUMENTS.get('noalpha', 0)

mogrify = '/usr/bin/mogrify'
povray = '/usr/bin/povray'
povray_flags = '-D +W400 +H400 +AM2 +A0.3'

if not noalpha:
	povray_flags = povray_flags + ' +UA'

def Pose(env, pngfile, povfile):
	env.Command(pngfile, povfile, [
		"""$POVRAY $POVRAY_FLAGS +I$SOURCE +O$TARGET""",
		"""$MOGRIFY -trim $TARGET"""
	])
	env.Depends(pngfile, ['mascot.pov', 'defscene.pov'])
AddMethod(Environment, Pose)

env = Environment(
	MOGRIFY = mogrify,
	POVRAY = povray,
	POVRAY_FLAGS = povray_flags
)

env.Pose('mascot.png', 'pose_heythere.pov')
env.Pose('dance.png', 'pose_dance.pov')
