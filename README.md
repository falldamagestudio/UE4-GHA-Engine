
# UE4 + GitHub Actions - example engine build

This is a build system demonstration for the UE4 engine.

The engine source code is stored in a private GitHub repo. This repo contains just the build instructions. It builds using GitHub Actions, using a self-hosted runner. The result is an installed build, similar to what Epic Games Launcher offers. The build is stored in a [Longtail](https://github.com/DanEngelbrecht/longtail) cloud store. [Google Cloud Platform](https://cloud.google.com/gcp) is used for VMs and storage.

See [UE4-GHA-Game](https://github.com/falldamagestudio/UE4-GHA-Game) for a game that uses the engine builds, and [UE4-GHA-BuildSystem](https://github.com/falldamagestudio/UE4-GHA-BuildSystem) for the build system itself.

## Features

The [build script for the engine](.github/workflows/build.yaml) is short and to the point.

You can follow the build process via [GitHub Actions](https://github.com/falldamagestudio/UE4-GHA-Engine/actions).

The self-hosted runner VM allows for incremental builds.

The VM is only running when a build is in progress. Therefore, it only incurs vCPU/RAM cost during the builds. (The VM disk incurs cost even when the VM is stopped.)

The Longtail store deduplicates data server-side -- so having lots of near-identical builds will not use a lot of space server-side. Also, downloading near-identical builds works like downloading patches in Steam.

## Performance

A clean build takes about 2 hours on an `n1-standard-32` machine. This includes fetching the entire UE4 source code + deps, building Editor, Game, Client, Server for Win64, building tools, building feature packs, and uploading the resulting build to Longtail.

## Future development

See [the issues list](https://github.com/falldamagestudio/UE4-GHA-Engine/issues) to get a feeling for the project status and what is missing.

# License

Getting access to the actual UE4 source code via GitHub requires you to [sign an EULA with Epic Games](https://www.unrealengine.com/en-US/ue4-on-github).

The license for these engine build scripts are available in [LICENSE.txt](LICENSE.txt). See [golongtail](https://github.com/DanEngelbrecht/golongtail) for licenses of the software it depends on.
