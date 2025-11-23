:<<BATCH
    @echo off
    echo **** GIMP-ML Setup started ****
    echo **** WINDOWS INSTALL PATH NOT SUPPORTED - PULL REQUESTS ARE WELCOME ****
    python -m pip install virtualenv
    python -m virtualenv gimpenv3
    if "%1"=="gpu" (gimpenv3\Scripts\python.exe -m pip install torch==1.8.1+cu111 torchvision==0.9.1+cu111 torchaudio===0.8.1 -f https://download.pytorch.org/whl/lts/1.8/torch_lts.html) else (gimpenv3\Scripts\python.exe -m pip install torch==1.8.1+cpu torchvision==0.9.1+cpu -f https://download.pytorch.org/whl/torch_stable.html)
    gimpenv3\Scripts\python.exe -m pip install GIMP-ML\.
    gimpenv3\Scripts\python.exe -c "import gimpml; gimpml.setup_python_weights()"
    echo **** GIMP-ML Setup Ended ****
    exit /b
BATCH
echo '**** GIMP-ML Setup started ****'
if python --version 2>&1 | grep -q '^Python 3\.'; then #
    echo 'Python 3 found.' #
    virtualenv -p python venv #
    source venv/bin/activate #
    python -m pip install "numpy<2" #
    python -m pip install torch torchvision torchaudio #
    python -m pip install . #
    python -c "import gimpml; gimpml.setup_python_weights()" #
    deactivate #
elif python3 --version 2>&1 | grep -q '^Python 3\.'; then #
    echo 'Python 3 found.' #
    virtualenv -p python3 venv #
    source venv/bin/activate #
    python3 -m pip install "numpy<2" #
    python3 -m pip install torch torchvision torchaudio #
    python3 -m pip install . #
    python3 -c "import gimpml; gimpml.setup_python_weights()" #
    deactivate #
else #
    echo 'Python 3 NOT found' #
fi #
echo '*** GIMP-ML Setup Ended ****'
