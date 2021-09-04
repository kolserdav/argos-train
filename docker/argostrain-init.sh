# Install Debian packages
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install python3 python3-pip python3-virtualenv zip git wget curl screen -y

# Setup Python environment
virtualenv ~/env
source env/bin/activate
git clone https://github.com/argosopentech/onmt-models.git ~/onmt-models
~/env/bin/pip install -e ~/onmt-models
echo "source ~/env/bin/activate" >> ~/.profile
source ~/.profile

# Install OpenNMT-py
# https://forum.opennmt.net/t/cuda-error-no-kernel-image-is-available-for-execution-on-the-device/4644/3
pip install torch==1.9.0+cu111 -f https://download.pytorch.org/whl/torch_stable.html
git clone https://github.com/OpenNMT/OpenNMT-py.git ~/OpenNMT-py
~/env/bin/pip install -e ~/OpenNMT-py
~/env/bin/pip install -r ~/OpenNMT-py/requirements.opt.txt

# Compile SentencePiece
cd
sudo apt-get install cmake build-essential pkg-config libgoogle-perftools-dev vim git -y
git clone https://github.com/google/sentencepiece.git ~/sentencepiece
cd sentencepiece
mkdir build
cd build
cmake ..
make -j $(nproc)
sudo make install
sudo ldconfig -v

