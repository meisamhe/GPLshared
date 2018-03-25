# for the training set after removing the noises device_id and device_ip
# the label is the first element and I ask it to ignore the header
# an alternative way rather than use removeDevice_ipDevice_id.py is to use -i option
# options are:
# "-s", "--skip_headers", "use this option if there are headers in the file - default false" )
# "-l", "--label_index", "index of label column (default 0, use -1 if there are no labels)"
#"-z", "--convert_zeros", "convert labels for binary classification from 0 to -1" 
#"-i", "--ignore_columns", "index(es) of columns to ignore, for example 3 or 3,4,5 (no spaces in between)" )
#"-c", "--categorical", "treat all columns as categorical" 
# "-n", "--print_counter", "print counter every _ examples (default 10000)" )

# the first step is to run removeDevice_ipDevice_id because it also helps to create a label that is either -1 or 1
pypy removeDevice_ipDevice_id.py

# over the training set
pypy ./FormatConversionVWLibSVM/phraug2-master/phraug2-master/csv2vw.py ./train/trainRmDidDip.csv ./vwtrain.data -l 0 -s -c

# run on the test set (-1 because we do not have the labels in the case of test set)
pypy ./FormatConversionVWLibSVM/phraug2-master/phraug2-master/csv2vw.py ./test/testRmDidDip.csv ./vwttest.data -l -1 -s -c

# install vowpal wabbit in cgywin
#Install Cygwin

Download the version of Cygwin for your operating system from: http://cygwin.com/install.html

In the Cygwin setup “Select Packages” window you will need to install the following packages:
Search for "git". From Devel select git: Distributed version control system
Search for "make". From Devel select make: the GNU version of the 'make' utility
Search for "g++". From Devel select gcc-g++ GNU compiler Collection (C++)
Search for "zlib". From Libs select zlib-devel: Zlib de/compression library (development)
Search for "boost". From Libs select libboost-devel: Boost C++ Libraries
Search for "libtool". From Devel select libtool: Generic library support script
Search for "automake". From Devel select automake: Wrapper scripts for automake and aclocal.
Search for "automake". From Devel select automake1.9: (1.9) a tool for generating GNU-compliant Makefiles (The others should be installed when resolving dependancies).
Search for "libboost". From Libs select libboost_python-devel: Boost C++ libraries
Search for "libboost". From Libs select libboost_program_options1.55: Boost C++ libraries

> c:\cygwin64\cygwin.bat

>git clone https://github.com/JohnLangford/vowpal_wabbit.git
>cd vowpal_wabbit
>./autogen.sh
>make
>make install
>cd vowpalwabbit
>./vw --help
>./vw --version
# to quickly put some .vw datasets there or copy the output predictions.
>C:\cygwin64\home\your_username\vowpal_wabbit\vowpalwabbit

#You could also use the cygdrive-prefix to run VW on files stored outside your user directory (or to output your model to another directory/drive). If your training set is on c:\data\train.vw try:

./vw -d /cygdrive/c/data/train.vw

#Perl should now also be installed. If not search for perl in the Cygwin setup and from perl select perl: Perl programming language interpreter. In the vowpal_wabbit/utl directory you’ll find some utility scripts, of which vw-varinfo is particularly useful.


# if the commands did not work and come with error use the windows version:
https://github.com/MLWave/Kaggle_Rotten_Tomatoes/blob/master/vw.exe

# running vowpal wabbit
#requires label that is either -1 or 1
# logistic
.\vowelWabbit\vw.exe -d .\vwtrain.data -f .\predictor.vw --loss_function logistic --l2 0.1 --l1 0.1
.\vowelWabbit\vw.exe -d .\vwttest.data -t -i .\predictor.vw -p .\predictions.out

# svm
.\vowelWabbit\vw.exe -d .\vwtrain.data -f .\predictorSVM.vw --loss_function hinge --l2 0.1 --l1 0.1
.\vowelWabbit\vw.exe -d .\vwttest.data -t -i .\predictorSVM.vw -p .\predictionsSVM.out