# Terraform ARM64 Repro Configs

A small config to help with testing/repro for ARM64 linux issues. This config currently runs in us-east-2b & us-east-2c to make use of the Graviton2 T4g instances. 

You need only supply the version of Terraform you wish to test and the location of the your SSH public key in the root module. 