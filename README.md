# docker-build
## 内容
### kea-dhcp4
[Kea DHCP server](https://www.isc.org/kea/)をソースからビルドして、IPv4環境で動かすのに必要な部分だけ抜き出したもの。<br />
抜き出したものは[Ubuntu 20.04 LTSのパッケージ内容](https://packages.ubuntu.com/focal/amd64/kea-dhcp4-server/filelist)を参考にした。

### kea-dhcp6
[Kea DHCP server](https://www.isc.org/kea/)をソースからビルドして、IPv6環境で動かすのに必要な部分だけ抜き出したもの。<br />
抜き出したものは[Ubuntu 20.04 LTSのパッケージ内容](https://packages.ubuntu.com/focal/amd64/kea-dhcp6-server/filelist)を参考にした。

### radio-recorder
[超!A&G+](https://www.agqr.jp/)と[radiko]()で配信されている番組を録音するコンテナ。radikoの録音には[radigo](https://github.com/yyoshiki41/radigo)を`go get`したものを利用