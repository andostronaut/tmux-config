<p align="center">
  <img
    src="tmux-config.png"
    alt="tmux-config"
    style="width:100%;"
  />
</p>

tmux configuration with predefined themes 💅

List of available themes:

<details>
  <summary>See all available themes</summary>

<!--Themes -->

- [Tokyo Night](themes/tokyonight.conf)
- [Github Light](themes/github-light.conf)
- [Github Dark](themes/github-dark.conf)
- [Kanagawa](themes/kanagawa.conf)
- [Oxocarbon](themes/oxocarbon.conf)

</details>

## Build

### Manual (build.sh)

Give some permission to build.sh script.

```sh
chmod +x build.sh
```

Build the configuration

- with flag `-t` to specify the theme
- with flag `-o` to specify the output file

```sh
./build.sh -t tokyonight -o root
```

### Makefile (make)

Run the following command to build the configuration.

- with variable `THEME` to specify the theme
- with variable `OUTPUT` to specify the output file

```sh
make build THEME=tokyonight OUTPUT=root
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
