cmake_minimum_required(VERSION 3.12)
project(proj2)

set(CMAKE_CXX_STANDARD 14)

add_executable(proj2 main.cu test.cu sobel_filter.cuh timer.h)