# AWSのインフラ構成

## VPC

| 名前 | IPv4/CIDR|
|--|--|
| zenn-test-vpc | 10.0.0.0/16 |
|  | |  

## サブネット

 名前 | IPv4/CIDR| VPC |
|--|--|--|
| zenn-test-public-subnet1 | 10.0.1.0/24 | zenn-test-vpc |
| zenn-test-public-subnet2 | 10.0.1.0/24 | zenn-test-vpc |
| zenn-test-public-subnet1 | 10.0.100.0/24 | zenn-test-vpc |
| zenn-test-public-subnet2 | 10.0.101.0/24 | zenn-test-vpc |
| | | |

- パブリックサブネット×2
- プライベートサブネット×2

## インターネットゲートウェイ（Igw）
| 名前 | アタッチVPC|
|--|--|
| zenn-test-gw | zenn-test-vpc|

## セキュリティグループ


### バックエンド

#### api

#### ELB

#### RDS

#### フロントエンド
 