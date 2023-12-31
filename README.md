# NAIFU

Naifu is a Diffusion Web UI using Leakd Novel AI code.
Another model can be loaded, but a CKPT file is required.
Since certain parameters have been adjusted, even when an existing model is loaded, the result is clean.

This is the Discord community for this.

https://discord.gg/SY9bKxcn4K

## How to use

### Setup 

Download this repository as a ZIP file and double-click setup.bat to complete the setup.

### Load other Model

1. Rename the prepared CKPT file to `model.ckpt`
2. Create a directory of any name in `NAIFU-main/models` and put `model.ckpt` in it.
3. If there is a `config.yaml` in the CKPT distribution location, use it, otherwise copy it from `NAIFU-main\models\animefull-final-pruned\config.yaml` to the directory you created.
4. Please place as this

```
NAIFU-main
|-models
| |-animefull-final-pruned
| |-ADDEDCKPT       # ADDED
| | |-config.yaml   # ADDED
| | |-model.ckpt    # ADDED
```

5. Add the `vae.pt` file, if any, to any location.
6. Edit the following section in the `run.bat` file. Enter the name of the directory you created in `MODEL_PATH` and the path to the `VAE` file you added in `VAE_PAT`. (Relative paths)

```bat
set MODEL_PATH=
set VAE_PATH=
```
7. run.bat

### Low GPU performance or small VRAM

In `run.bat`, enable either of the following

* Generated results are slightly inferior

```bat
:: set LOWVRAM=1
set MEDVRAM=1
```

### Change the destination

Uncomment the following and enter the destination path

```bat
:: set SAVE_PATH=
```

### Change Save Type

The following two types of save types are available

full : Save all generated image information
default : save only images

Change the following variables

```bat
set SAVE_TYPE=full
```
