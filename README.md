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

# Install gRPC using vcpkg

## 1. Install vcpkg and add `VCPKG_ROOT` to environment `PATH`

## 2. Initialize vcpkg
```bash
vcpkg new --application
```

## 3. Add grpc package
```bash
vcpkg add port grpc
```

## 4. Install
```bash
vcpkg install
```

## 6. Edit CMakeLists.txt
```CMakeLists
include("path\\to\\vcpkg.cmake)
find_package(gRPC CONFIG REQUIRED)

target_link_libraries(ImmortalsGUIApp PRIVATE
...
gRPC::grpc++
)
```

