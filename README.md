# Install grpc

## Clone 
```bash
git clone -b RELEASE_TAG_HERE https://github.com/grpc/grpc
cd grpc
git submodule update --init
```

## Build
```bash
md .build
cd .build
cmake .. -G "Visual Studio 17 2022"
cmake --build . --config Release
```

## Install 
```bash
cmake --install .
```