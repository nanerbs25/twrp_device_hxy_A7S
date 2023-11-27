TWRP device tree for UMIDIGI A7S (A7S)
======================================

The UMIDIGI A7S (codenamed _"A7S"_) is an entry-level, low-range smartphone from UMIDIGI.
It was released in September, 2020.

## Device specifications

| Basic                   | Spec Sheet                                                  |
| -----------------------:|:----------------------------------------------------------- |
| CPU                     | Quad-core (4x1.3GHz Cortex-A53)                             |
| Chipset                 | MediaTek MT6737M (28 nm)                                    |
| GPU                     | 650MHz Mali-T720 MP1                                        |
| Memory                  | 2 GB RAM (LPDDR3 1600 MHz single-channel)                   |
| Shipped Android version | 10.0 (Go edition)                                           |
| SIM                     | Dual SIM (Nano-SIM, dual stand-by)                          |
| Storage                 | 32 GB                                                       |
| MicroSD                 | microSDXC, up to 128 GB                                     |
| Battery                 | Non-removable Li-Po 4150 mAh battery                        |
| Dimensions              | 164.0 x 77.14 x 9.45 mm                                     |
| Display                 | 6.53 inch, 720 x 1600 pixels, 20:9 ratio (~269 ppi density) |
| Rear camera 1           | 13 MP, f/1.8, (wide), 0.26", 1.13 µm                        |
| Rear camera 2           | 8 MP, f/2.2, 120˚, (ultrawide), 1/4", 1.12 µm               |
| Rear camera 3           | 2 MP, (depth)                                               |
| Front camera            | 8 MP, f/1.8                                                 |
| Sensors                 | Accelerometer, Gyro, Proximity, Compass                     |

| What's Working?                      | What's not Working?        |
| ------------------------------------:|:---------------------------|
| • Touch                              | • Decryption               |
| • MTP                                |                            |
| • ADB                                |                            |
| • Flashlight                         |                            |
| • Mount System, Product, and Vendor  |                            |
| • Flashing a zip                     |                            |

## Device picture

![UMIDIGI_A7S](https://fdn.gsmarena.com/imgroot/news/20/09/umidigi-a7s-official/-900x900/gsmarena_003.jpg)

## Build instruction

```shell
. build/envsetup.sh
lunch omni_A7S
mka recoveryimage -j $(($(nproc) + 1))
```

## Copyright

```text
    # Copyright (C) 2023 The Android Open Source Project
    # Copyright (C) 2023 TeamWin Recovery Project
    
    # Licensed under the Apache License, Version 2.0 (the "License");
    # you may not use this file except in compliance with the License.
    # You may obtain a copy of the License at
    #
    # http://www.apache.org/licenses/LICENSE-2.0
    #
    # Unless required by applicable law or agreed to in writing, software
    # distributed under the License is distributed on an "AS IS" BASIS,
    # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    # See the License for the specific language governing permissions and
    # limitations under the License.
```
