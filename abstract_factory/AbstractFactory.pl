use utf8;
use strict;
use warnings;
use lib './';
use Mailler_Factory;

my $server='ServerIP';
my $mailaddress='mailaddress';
my $password='mailpassword';


my @factorys;

#IMAP接続の工場
push(@factorys,Concreate_Factory->new(type=>'imap'));

#POP接続の工場
push(@factorys,Concreate_Factory->new(type=>'pop'));

#配列をeachで回す
for my $factory(@factorys){

	#受信部品を作成
	my $rec=$factory->create_receive($server,$mailaddress,$password);
	#接続する
	$rec->connect();
	#メールの一覧を取得する
	my %list=$rec->getuidl();
	#一通目を受信し、表示する
	print $rec->getmsg($list{1}),"\n";
	#切断する
	$rec->disconnect;

	#送信部品を作成
	my $tra=$factory->create_send($server);
	#接続する
	$tra->connect();
	#送信する
	$tra->send(qw($mailaddress $mailaddress test test123));
	#切断する
	$tra->disconnect();

}


