## はじめに
このリポジトリは書籍「[Webサービスチューニングコンテスト ISUCONのススメ](https://www.amazon.co.jp/dp/B08V5PK51F)」で扱っているGCPリソースのプロビジョニングを行なうための構成管理ドキュメントです。

### 注意

非公式です。  
もともとは一読者だった [@_tacmac](https://twitter.com/_tacmac)がリソースを構築し直すことが手間で、せっかくなら構成管理して、これからこの書籍を読む方々の作業も楽になるといいなと思って作成しました。

### 扱っている技術
1. Terraform: `0.14.6`
2. Ansible: 未定

### 使い方
Terraform -> Ansibleの順にセットアップしてください。  
ドキュメントはMacOSを例に解説しています。その他OSを使用する場合は適宜読み替えてください。
- Terraform: [セットアップ方法はこちら](https://github.com/tacumai/isucon-no-susume-provisioning/wiki/%F0%9F%9A%80-Terraform%E3%81%AE%E3%82%BB%E3%83%83%E3%83%88%E3%82%A2%E3%83%83%E3%83%97%E6%96%B9%E6%B3%95)
  - GCPリソースの構築のために使用しています
- Ansible: [セットアップ方法はこちら](https://github.com/tacumai/isucon-no-susume-provisioning/wiki/Ansible%E3%81%AE%E3%82%BB%E3%83%83%E3%83%88%E3%82%A2%E3%83%83%E3%83%97%E6%96%B9%E6%B3%95)
  - GCEのプロビジョニングのために利用しています
