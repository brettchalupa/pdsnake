# PDSnake

Classic game snake for the Playdate console.

Includes high-score tracking, sound effect toggle, and a battery saver mode.

## Get the Game

Download the game at https://brettchalupa.itch.io/pdsnake or from the latest ref at https://git.sr.ht/~bcodes/pdsnake/refs

Upload the game to your Playdate by:

1. Download the game zip
2. Sideload it onto your Playdate at https://play.date/account/sideload/ or via USB connection

## Credits

- Game programmed by Brett Chalupa
- Color snake and apple icons come from [OpenMoji](https://openmoji.org/)
- Pixel snake on the game's card and icon comes from the NEC emoji set from 1990
- Sound effects made with [jsfxr](https://sfxr.me/)

## Development

Uses Just for commands:

- Compile: `just compile`
- Compile and launch in Simulator: `just run`

## Release

1. Bump the version and build number in `source/pdxinfo`
2. Update the CHANGELOG.md
3. Create a release commit
4. Create a release tag with `git tag -a X.X.X`
5. Create a release build with `just release`
6. Push the commits and tag to sourcehut
7. Attach the build to the sourcehut tag
8. Upload the build to itch.io

## License

See LICENSE.txt.
