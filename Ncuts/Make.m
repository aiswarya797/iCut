clc;
clear;
mex -O -largeArrayDims affinityic.cpp
mex -O -largeArrayDims cimgnbmap.cpp
mex -O -largeArrayDims sparsifyc.cpp
mex -O -largeArrayDims spmtimesd.cpp
mex -O -largeArrayDims mex_w_times_x_symmetric.cpp
