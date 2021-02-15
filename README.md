# About fbx test models

The sample FBX test models here are taken from the following:

1. [Skeleton][] ([link](Skeleton)) _ascii_
2. [Talking][] ([link](Talking))
3. [Shuffling][] ([link](Shuffling))

[Skeleton]: https://github.com/HeapsIO/heaps
[Talking]: https://sketchfab.com/3d-models/stylized-character-a1fc334b8bc54cda8a056b34c044eadb
[Shuffling]: https://sketchfab.com/3d-models/dancin-stormtrooper-2-6231570b8bb142909f27d37eae61d9d4

Converted models were generated using [`conv.sh`](conv.sh) with the [`osgconv`][osgconv] 
tool built against the [FBX SDK 2014.2.1][fbxsdk] on Ubuntu 20.04 (amd64).

Usage notes for `osgconv`:

```sh
# generate ascii files
$ osgconv -O FBX-ASCII <name>.binary.fbx <name>.text.fbx
```

[osgconv]: http://www.openscenegraph.org/
[fbxsdk]: https://www.autodesk.com/developer-network/platform-technologies/fbx-sdk-2014-2-1
