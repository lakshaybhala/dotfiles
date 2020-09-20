# Terminfo

This is needed for italics support inside tmux.

To use the .txt files to generate terminfo, run:

```sh
tic -o ~/.terminfo ~/.terminfo/tmux-256color.terminfo.txt
tic -o ~/.terminfo ~/.terminfo/tmux.terminfo.txt
```

[Source](https://apple.stackexchange.com/a/267261/175672)
