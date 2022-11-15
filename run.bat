@echo off

if not defined PYTHON (set PYTHON=python)
if not defined VENV_DIR (set VENV_DIR=venv)

set ERROR_REPORTING=FALSE
set PYTHON="python"
set DTYPE=float32
set CLIP_CONTEXTS=3
set AMP=1
set MODEL=stable-diffusion
set DEV=True
set MODEL_PATH=models/animefull-final-pruned
set ENABLE_EMA=1
set VAE_PATH=models/animevae.pt
set PENULTIMATE=1
set PYTHONDONTWRITEBYTECODE=1

::set MODULE_PATH=models/modules
::set PRIOR_PATH=models/vector_adjust_v2.pt

%PYTHON% -m uvicorn --host 127.0.0.1 --port=80 --workers 1 main:app
pause
