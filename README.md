## QtCudaHelloWorld

- 作者：李长圣
- 邮箱：sheng0619@163.com
- 功能：演示如何使用 `qtcreator` 创建 `CUDA` 程序。
- 使用方法：使用 `qtcreator` 打开 `QtCudaHelloWorld` 编译运行
- 支持 `window10` 和 `linux` 系统

### 操作方法

1. http://download.qt.io/archive/qt 下载安装Qt。   
本实例使用的版本 `Qt 5.12.9`
2. NVIDA官网下载 cuda工具包 https://developer.nvidia.com/cuda-downloads。  
本实例使用的版本为 `CUDA Toolkit 11.1`， https://developer.download.nvidia.cn/compute/cuda/11.1.0/local_installers/cuda_11.1.0_456.43_win10.exe ，双击安装。
3. 配置 `QtCudaHelloWorld.pro`，见源码。
4. 打开 `qtcreator` 编译运行项目 `QtCudaHelloWorld.pro` ，输出如下信息，表示正确构建了程序：
    ```
    Hello block 4 thread 0 
    Hello block 2 thread 0 
    Hello block 0 thread 0 
    Hello block 3 thread 0 
    Hello block 1 thread 0
    ```