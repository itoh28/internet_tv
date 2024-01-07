## 提出課題で使用するDBの作成手順です。
前提として、WSL2(Ubuntu)上でMySQLをインストールし、操作を行います。

1. パッケージ一覧の更新
````
$ sudo apt update
````
2. MySQLをインストールする
````
$ sudo apt install mysql-server
````
3. MySQLのバージョン番号とインストールを確認する 
　※現時点のMySQLのバージョンは8.0.35
````
$ mysql --version 
$ mysql  Ver 8.0.35-0ubuntu0.22.04.1 for Linux on x86_64 ((Ubuntu))
````
4. rootユーザーとして、MySQLにログインする
````
$ sudo mysql
````
5. MySQLサーバーにrootユーザーのパスワードを設定する
　※'○○○○'の部分に設定するパスワードを記述する
````
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '○○○○';
````
6. rootユーザーのパスワード変更を反映させる
````
FLUSH PRIVILEGES;
````
7. MySQLからログアウトする
````
exit
````
8. rootパスワードが設定されたことを確認する
　※sudoコマンドでMySQLにログインしようとすると、エラーが発生することを確認する
````
$ sudo mysql
ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: NO)
````
9. rootユーザーでログインする
　※パスワードを訊かれるので、設定したパスワードを入力する
````
$ mysql -u root -p
````
10. 新規ユーザーを作成する
　※''new_user'の部分にユーザー名、
'○○○○'の部分に設定するパスワードを記述する
````
CREATE USER 'new_user'@'localhost' IDENTIFIED BY '○○○○';
````
11. ユーザーが作成できたことを確認する
　※mysqlデータベースのuserテーブルからユーザー名とホストを検索する
````
SELECT user, host FROM mysql.user;
````
12. ユーザーにデータベースへのアクセス権を付与する
　※これにより、'new_user'は全てのデータベースおよびテーブルに対しての権限を持つことになる。セキュリティの観点から、実際の環境では必要な権限のみを付与するようにする
````
GRANT ALL PRIVILEGES ON *.* TO 'new_user'@'localhost';
````
13. アクセス権の変更を反映させる
````
FLUSH PRIVILEGES;
````
14. 一旦、MySQLからログアウトする
````
exit
````
15. 作成したユーザーで再度MySQLにログインする
　※''new_user'の部分にユーザー名を記述する
````
mysql -u 'new_user' -p
````
16. 新しいデータベース（internet_tv）を作成する
````
CREATE DATABASE internet_tv;
````
17. 作成したデータベースを選択する
````
USE internet_tv;
````