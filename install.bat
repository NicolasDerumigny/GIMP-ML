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
    PYTHON=python
elif python3 --version 2>&1 | grep -q '^Python 3\.'; then #
    echo 'Python 3 found.' #
    PYTHON=python3
else #
    echo 'Python 3 NOT found' #
fi #
if [ "${PYTHON}" != "" ]; then #
    virtualenv -p python venv #
    source venv/bin/activate #
    ${PYTHON} -m pip install "numpy<2" #
    ${PYTHON} -m pip install torch torchvision torchaudio six #
    ${PYTHON} -m pip install . #
    ${PYTHON} -c "import gimpml; gimpml.setup_python_weights()" #
    PYTHON_FOLDER=`ls -d ~/.config/GIMP/3.0/plug-ins/GIMP-ML/venv/lib/python*` #
    cp ~/.config/GIMP/3.0/plug-ins/GIMP-ML/gimpml/tools/gimp_ml_config.pkl ${PYTHON_FOLDER}/site-packages/gimpml/tools/gimp_ml_config.pkl #
    PLUG_INS=`ls -d ~/.config/GIMP/3.0/plug-ins/GIMP-ML/gimpml/plugins/*/` #
    for i in ${PLUG_INS}; do #
        ln -s $i ~/.config/GIMP/3.0/plug-ins/ #
    done #
    deactivate #
fi #
echo '*** GIMP-ML Setup Ended ****'
