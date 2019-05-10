# バスケチーム分け

## 使い方
1. 参加するメンバーのjsonファイルを作成します。```json/members/xxxxx.json```を日付をファイル名にして追加していってください。
  - rateは1~5で指定するようにしてください。
2. ```version_02.rb```の```MEMBER_FILE_PATH = "./json/members/20190201.json"```の部分を1で作ったファイル名に変更してください。
3. ```version_02.rb```の```TEAM_COUNT = 2```をチーム数に合わせてください。
4. 以下のコマンドを実行してください。

```
$ ruby version_02.rb
```

## チーム名を変更したい時
```json/team_names.json```を変更してください。
