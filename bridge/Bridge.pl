use utf8;
#---------------------------------------------
# Name:Bridge.pl
#---------------------------------------------

my $server='ServerIP';
my $mailaddress='mailaddress';
my $password='password';

use Mailler_Receive;
use Mailler_Object;

#Mailler_ObjectにPOP接続、IMAP接続を代入する
my $pop = Mailler_Object->new( receiver => Receive_Pop->new( server => $server,mailaddress => $mailaddress, password => $password));
my $imap = Mailler_Object->new( receiver => Receive_Imap->new( server => $server,mailaddress => $mailadress, password => $passoword));

#--------------------------------------
# POPの処理
#--------------------------------------

#POPの接続
$pop->connect();

#メール一覧の取得
my %list=$pop->getuidl();

#一通目を受信し、表示する
print $pop->getmsg($list{1}),"\n";

#切断
$pop->disconnect();

#--------------------------------------
# IMAPの処理
#--------------------------------------

#IMAPの接続
$imap->connect();

#メール一覧の取得
my %list=$imap->getuidl();

#一通目を受信し、表示する
print $imap->getmsg($list{1}),"\n";

#切断
$imap->disconnect();

