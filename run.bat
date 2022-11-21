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
set PYTHON="python"

:: Model Paths
set MODEL_PATH=models/animefull-final-pruned
set VAE_PATH=models/animevae.pt
::set MODULE_PATH=models/modules
::set PRIOR_PATH=models/vector_adjust_v2.pt

:: Save type [default] or [full]
set SAVE_FILES=1
set SAVE_TYPE=full
:: set SAVE_PATH=

:: If VRAM is smaller than 8GB, enable one or the other for LOWVRAM or MEDVRAM.
:: set LOWVRAM=1
:: set MEDVRAM=1

%PYTHON% -m uvicorn --host 127.0.0.1 --port=80 --workers 1 main:app
pause
