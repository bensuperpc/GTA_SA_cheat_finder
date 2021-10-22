#!/usr/bin/env bash

#//////////////////////////////////////////////////////////////
#//   ____                                                   //
#//  | __ )  ___ _ __  ___ _   _ _ __   ___ _ __ _ __   ___  //
#//  |  _ \ / _ \ '_ \/ __| | | | '_ \ / _ \ '__| '_ \ / __| //
#//  | |_) |  __/ | | \__ \ |_| | |_) |  __/ |  | |_) | (__  //
#//  |____/ \___|_| |_|___/\__,_| .__/ \___|_|  | .__/ \___| //
#//                             |_|             |_|          //
#//////////////////////////////////////////////////////////////
#//                                                          //
#//  Script, 2020                                            //
#//  Created: 06, October, 2020                              //
#//  Modified: 21, October, 2021                             //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: https://github.com/bensuperpc/scripts                                                //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

cmake -S . -B build -G Ninja "$*"

ninja -C build
