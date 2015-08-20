#!/bin/bash
if [[ -f miniconda.sh ]]; then
	echo "Using previously downloaded miniconda.sh"
else
	python INSTALL.py | xargs wget -O miniconda.sh
	chmod u+x miniconda.sh
fi

pref=$(dirname $(readlink -f miniconda.sh))/miniconda 

if [[ -d $pref ]]; then
	echo "Using current miniconda installation at $pref."
else
	./miniconda.sh -b -p $pref
fi
p=$PATH
export PATH="$pref/bin:$PATH"

conda create -n sci2 python=2 pip argcomplete numpy scipy scikit-learn pandas ipython-notebook matplotlib biopython seaborn 
conda create -n sci3 python=3 pip argcomplete numpy scipy scikit-learn pandas ipython-notebook matplotlib biopython seaborn

source activate sci2
pip install ipdb
source deactivate

source activate sci3
pip install ipdb
pip install snakemake --no-binary snakemake
source deactivate

export PATH=$p
echo ""
echo ""
echo "=========================================================="
echo "To load the conda environment on login, add this to your .bashrc, .bash_profile or .profile"
echo ""
echo "$ export PATH=$pref/bin:$PATH"
echo ""
echo "Or remember to execute this command before trying to activate the virtual environments"
echo "=========================================================="
echo "There are two virtual environments set up, sci2 and sci3. the sci2 uses pythnon2 while sci3 uses python3"
echo "To execute snakemake, you need to activate sci3 so:"
echo ""
echo "$ source activate sci3"
echo "$ snakemake Snakefile"
echo "=========================================================="
echo "To install python packages, you need to activate sci3 environment and then run: "
echo ""
echo "$ pip install <python-package>"
echo ""
echo "If this fails, the package might not work in python3 so then you need to activate sci2 and install again:"
echo ""
echo "$ source deactivate"
echo "$ source activate sci2"
echo "$ pip install <python-package>"
echo "$ source deactivate"
echo "$ source activate sci3"
echo "=========================================================="
echo ""

