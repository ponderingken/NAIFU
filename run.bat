@echo off

:: Advanced Settings
set ERROR_REPORTING=FALSE
set DTYPE=float32
set CLIP_CONTEXTS=3
set AMP=1
set MODEL=stable-diffusion
set DEV=True
set ENABLE_EMA=1
set PENULTIMATE=1
set PYTHONDONTWRITEBYTECODE=1

:: Python Path
set PYTHON=python

:: Tags Path
::set TAGS_PATH=models/tags.json
::set TAGS_PATH_GEN=models/tags.index

:: Model Paths
::set MODULE_PATH=models/modules
::set PRIOR_PATH=models/vector_adjust_v2.pt
set CONFIG_PATH=models/animefull-final-pruned/config.yaml
set MODEL_PATH=models/animefull-final-pruned/model.ckpt
set VAE_PATH=models/animevae.pt

:: Save type [default] or [full] or [metadata]
set SAVE_FILES=1
set SAVE_TYPE=metadata
:: set SAVE_PATH=

:: If VRAM is smaller than 8GB, enable one or the other for LOWVRAM or MEDVRAM.
:: set LOWVRAM=1
:: set MEDVRAM=1

%PYTHON% -m uvicorn --host 127.0.0.1 --port=80 --workers 1 main:app
pause
