cmake_minimum_required(VERSION 2.8.4)
project(Practica2Compiladores)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall")

set(SOURCE_FILES main.c)
add_executable(Practica2Compiladores ${SOURCE_FILES})