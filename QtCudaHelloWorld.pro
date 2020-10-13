#-------------------------------------------------
#
# Project created by QtCreator 2014-04-03T18:12:01
#
#-------------------------------------------------

QT       += core
QT       -= gui

TARGET = CUDA_helloworld
CONFIG   += console
CONFIG   -= app_bundle

TEMPLATE = app


SOURCES += main.cpp

#-------------------------------------------------
# CUDA
# This makes the .cu files appear in your project
OTHER_FILES += \
    kernel.cu
    README.md

CUDA_SOURCES += \
    kernel.cu

# CUDA settings
SYSTEM_NAME = x64                # Depending on your system either 'Win32', 'x64', or 'Win64'
SYSTEM_TYPE = 64                    # '32' or '64', depending on your system
CUDA_ARCH = sm_61                   # Type of CUDA architecture
NVCC_OPTIONS = --use_fast_math
#-------------------------------------------------
win32 {
    # Define output directories
    DESTDIR = ..\bin
    CUDA_OBJECTS_DIR = OBJECTS_DIR\..\cuda
    CUDA_DIR = "E:\cuda\v11.1"                # Path to cuda toolkit install
    LIBS += -L"E:\cuda\v11.1\lib\x64"
        -lcudart
    # MSVCRT link option (static or dynamic, it must be the same with your Qt SDK link option)
    MSVCRT_LINK_FLAG_DEBUG   = "/MDd"
    MSVCRT_LINK_FLAG_RELEASE = "/MD"

    # include paths
    INCLUDEPATH += $$CUDA_DIR\include \
                   $$CUDA_DIR\common/inc \
                   $$CUDA_DIR\..\shared\inc \
                   "E:\cuda\samples\common\inc"

    # library directories
    QMAKE_LIBDIR += $$CUDA_DIR\lib\$$SYSTEM_NAME \
                    $$CUDA_DIR\common\lib\$$SYSTEM_NAME \
                    $$CUDA_DIR\..\shared\lib\$$SYSTEM_NAME

    # The following makes sure all path names (which often include spaces) are put between quotation marks
    CUDA_INC = $$join(INCLUDEPATH,'" -I"','-I"','"')

    # Add the necessary libraries
    CUDA_LIB_NAMES = cudart_static

    for(lib, CUDA_LIB_NAMES) {
        CUDA_LIBS += -l$$lib
    }
    LIBS += $$CUDA_LIBS

    # Configuration of the Cuda compiler
    CONFIG(debug, debug|release) {
        # Debug mode
        cuda_d.input = CUDA_SOURCES
        cuda_d.output = $$CUDA_OBJECTS_DIR\${QMAKE_FILE_BASE}_cuda.obj
        cuda_d.commands = $$CUDA_DIR\bin\nvcc.exe -D_DEBUG $$NVCC_OPTIONS $$CUDA_INC $$LIBS \
                          --machine $$SYSTEM_TYPE -arch=$$CUDA_ARCH \
                          --compile -cudart static -g -DWIN32 -D_MBCS \
                          -Xcompiler "/wd4819,/EHsc,/W3,/nologo,/Od,/Zi,/RTC1" \
                          -Xcompiler $$MSVCRT_LINK_FLAG_DEBUG \
                          -c -o ${QMAKE_FILE_OUT} ${QMAKE_FILE_NAME}
        cuda_d.dependency_type = TYPE_C
        QMAKE_EXTRA_COMPILERS += cuda_d
    }
    else {
        # Release mode
        cuda.input = CUDA_SOURCES
        cuda.output = $$CUDA_OBJECTS_DIR\${QMAKE_FILE_BASE}_cuda.obj
        cuda.commands = $$CUDA_DIR\bin\nvcc.exe $$NVCC_OPTIONS $$CUDA_INC $$LIBS \
                        --machine $$SYSTEM_TYPE -arch=$$CUDA_ARCH \
                        --compile -cudart static -DWIN32 -D_MBCS \
                        -Xcompiler "/wd4819,/EHsc,/W3,/nologo,/O2,/Zi" \
                        -Xcompiler $$MSVCRT_LINK_FLAG_RELEASE \
                        -c -o ${QMAKE_FILE_OUT} ${QMAKE_FILE_NAME}
        cuda.dependency_type = TYPE_C
        QMAKE_EXTRA_COMPILERS += cuda
    }
}

#-------------------------------------------------
unix {
    # Define output directories
    DESTDIR = ../bin
    CUDA_OBJECTS_DIR = OBJECTS_DIR/../cuda
    CUDA_DIR = "/usr/local/cuda-10.0"            # Path to cuda toolkit install
    LIBS += -L"/usr/local/lib" \
            -L"/usr/local/cuda/lib64" \
            -lcudart

    # include paths
    INCLUDEPATH += $$CUDA_DIR/include \
                   $$CUDA_DIR/common/inc \
                   $$CUDA_DIR/../shared/inc

    # library directories
    QMAKE_LIBDIR += $$CUDA_DIR\lib64

    # The following makes sure all path names (which often include spaces) are put between quotation marks
    CUDA_INC = $$join(INCLUDEPATH,'" -I"','-I"','"')

    # Add the necessary libraries
    CUDA_LIB_NAMES = cudart_static

    for(lib, CUDA_LIB_NAMES) {
        CUDA_LIBS += -l$$lib
    }
    LIBS += $$CUDA_LIBS

    # Configuration of the Cuda compiler
    CONFIG(debug, debug|release) {
        # Debug mode
        cuda_d.input = CUDA_SOURCES
        cuda_d.output = $$CUDA_OBJECTS_DIR\${QMAKE_FILE_BASE}_cuda.o
        cuda_d.commands = $$CUDA_DIR/bin/nvcc -D_DEBUG $$NVCC_OPTIONS $$CUDA_INC $$LIBS \
                          --machine $$SYSTEM_TYPE -arch=$$CUDA_ARCH \
                          --compile -cudart static -g -DWIN32 -D_MBCS \
                          -c -o ${QMAKE_FILE_OUT} ${QMAKE_FILE_NAME}
        cuda_d.dependency_type = TYPE_C
        QMAKE_EXTRA_COMPILERS += cuda_d
    }
    else {
        # Release mode
        cuda.input = CUDA_SOURCES
        cuda.output = $$CUDA_OBJECTS_DIR\${QMAKE_FILE_BASE}_cuda.obj
        cuda.commands = $$CUDA_DIR/bin/nvcc $$NVCC_OPTIONS $$CUDA_INC $$LIBS \
                        --machine $$SYSTEM_TYPE -arch=$$CUDA_ARCH \
                        --compile -cudart static -DWIN32 -D_MBCS \
                        -c -o ${QMAKE_FILE_OUT} ${QMAKE_FILE_NAME}
        cuda.dependency_type = TYPE_C
        QMAKE_EXTRA_COMPILERS += cuda
    }
}
