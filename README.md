# PDSnake

Classic game snake for the Playdate console.

Includes high-score tracking, sound effect toggle, and a battery saver mode.

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
