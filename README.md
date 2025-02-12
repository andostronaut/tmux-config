# TMUX Config

This repository contains personalized configurations for Tmux with some themes.

## Themes

- [Tokyo Night](themes/tokyonight.conf)
- [Github Light](themes/github-light.conf)

## Build

### Manual

Give some permission to build.sh script

```sh
chmod +x build.sh
```

Build the configuration

    - with flag `-t` to specify the theme
    - with flag `-o` to specify the output file

```sh
./build.sh -t tokyonight -o root
```

### Automatic

Run the following command to build the configuration

```sh
make build
```

## Source

```sh
tmux source ~/.tmux.conf
```

```sh
tmux source-file ~/.tmux.conf
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
