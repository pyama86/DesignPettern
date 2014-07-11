use utf8;
#-------------------------------------------
# Name:Client.pl
#-------------------------------------------
use Invoker;
use Command;
use Receiver;

#コマンドの集合となるインボーカー(実行者)
my $i=Invoker->new();

#コマンドのインスタンス化
my $comP=PasteCommand->new();
my $comD=DeleteCommand->new();

#コマンドの対象となるレシーバー
#このレシーバーに対してコマンドが実行される
#そしてレシーバーのみがコマンドの実行内容を知る
my $recD=DirReceiver->new();
my $recF=FileReceiver->new();

#ペーストコマンドにディレクトリのレシーバーをセットする
$comP->set_receiver($recD);

#デリートコマンドにファイルのレシーバーをセットする
$comD->set_receiver($recF);

#インボーカーに登録する
$i->add_commands($comP);
$i->add_commands($comD);

#実行する
$i->run();


