[![Docker Pulls](https://img.shields.io/docker/pulls/itzg/minecraft-server.svg)](https://hub.docker.com/r/itzg/minecraft-server/)
[![Docker Stars](https://img.shields.io/docker/stars/itzg/minecraft-server.svg?maxAge=2592000)](https://hub.docker.com/r/itzg/minecraft-server/)
[![GitHub Issues](https://img.shields.io/github/issues-raw/itzg/docker-minecraft-server.svg)](https://github.com/itzg/docker-minecraft-server/issues)
[![Discord](https://img.shields.io/discord/660567679458869252?label=Discord&logo=discord)](https://discord.gg/DXfKpjB)
[![Build and Publish](https://github.com/itzg/docker-minecraft-server/workflows/Build%20and%20Publish/badge.svg)](https://github.com/itzg/docker-minecraft-server/actions)
[![](https://img.shields.io/badge/Donate-Buy%20me%20a%20coffee-orange.svg)](https://www.buymeacoffee.com/itzg)

This docker image provides a Minecraft Server that will automatically download the latest stable
version at startup. You can also run/upgrade to any specific version or the
latest snapshot. See the _Versions_ section below for more information in full documentation.


By default, the container will download the latest version of the "vanilla" [Minecraft: Java Edition server](https://www.minecraft.net/en-us/download/server) provided by Mojang. The [`VERSION`](#versions) and the [`TYPE`](#server-types) can be configured to create many variations of desired Minecraft server. 

## Looking for a Bedrock Dedicated Server

For Minecraft clients running on consoles, mobile, or native Windows, you'll need to
use this image instead:

[itzg/minecraft-bedrock-server](https://hub.docker.com/r/itzg/minecraft-bedrock-server)